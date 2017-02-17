/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.Gender;
import aac.domain.dataCategory.PassengerType;
import aac.domain.Passenger;
import aac.domain.dataCategory.Country;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Walker
 */
public class PassengersDAO implements DAOInterface<Integer, Passenger> { // K主鍵值型別是否不可為基本型別

    private static final String COLUMNS_P = "ptype, first_name, last_name, gender, birthday, "
            + "residence, nation, passport_number, passport_issue_place, passport_expiry";

    private static final String TABLE_P = "passengers";

    private static final String INSERT_SQL_P = "INSERT INTO " + TABLE_P + " ("
            + COLUMNS_P + ") VALUES (?,?,?,?,?,?,?,?,?,?)";

    private static final String UPDATE_SQL_P = "UPDATE " + TABLE_P + " SET "
            + "ptype=?, first_name=?, last_name=?, gender=?, birthday=?, residence=?, "
            + "nation=?, passport_number=? ,passport_issue_place=?, passport_expiry=?" + " WHERE id=?";

    private static final String DELETE_SQL_P = "DELETE FROM " + TABLE_P + " WHERE id=?";

    private static final String SELECT_SQL_BY_ID_P = "SELECT " + COLUMNS_P + " FROM " + TABLE_P
            + " WHERE id=?";

    private static final String SELECT_SQL_BY_NAME_P = "SELECT " + COLUMNS_P + " FROM " + TABLE_P
            + " WHERE first_name=? AND last_name=?";

    private static final String SELECT_ALL_SQL_P = "SELECT " + COLUMNS_P + " FROM " + TABLE_P;

    private int passengerId;

    public int getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(int passengerId) {
        this.passengerId = passengerId;
    }

    @Override
    public void insert(Passenger p) throws AACException {
        if (p == null) {
            throw new IllegalArgumentException("乘客新增失敗-乘客資料不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt
                = connection.prepareStatement(INSERT_SQL_P, Statement.RETURN_GENERATED_KEYS);//3.建立Statement物件
                ) {
            pstmt.setInt(1, p.getPassengerType().ordinal());
            pstmt.setString(2, p.getFirstName());
            pstmt.setString(3, p.getLastName());
            pstmt.setInt(4, p.getGender().ordinal());
            if (p.getBirthday() != null) {
                pstmt.setDate(5, new java.sql.Date(p.getBirthday().getTime()));
            } else {
                pstmt.setDate(5, null);
            }
            pstmt.setInt(6, p.getResidence().ordinal());
            pstmt.setInt(7, p.getNation().ordinal());
            pstmt.setString(8, p.getPassportNumber());
            pstmt.setInt(9, p.getPassportIssuePlace().ordinal());
            if (p.getPassportExpiryDate() != null) {
                pstmt.setDate(10, new java.sql.Date(p.getPassportExpiryDate().getTime()));
            } else {
                pstmt.setDate(10, null);
            }

            //4.確認是否出現重複乘客資料後 執行指令 並且將DB自給ID放回dao中
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys();) {
                while (rs.next()) {
                    this.setPassengerId(rs.getInt(1));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PassengersDAO.class.getName()).log(Level.SEVERE, "乘客新增失敗", ex);
            throw new AACException("乘客新增失敗", ex);
        } catch (AACException ex) {
            Logger.getLogger(PassengersDAO.class.getName()).log(Level.SEVERE, "乘客新增失敗", ex);
            throw ex;
        }
    }

    @Override
    public void update(Passenger p) throws AACException {
        if (p != null) {
            try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                    PreparedStatement pstmt = connection.prepareStatement(UPDATE_SQL_P);//3.建立Statement物件
                    ) {
                pstmt.setString(1, p.getPassengerType().name());
                pstmt.setString(2, p.getFirstName());
                pstmt.setString(3, p.getLastName());
                pstmt.setString(4, p.getGender().name());
                if (p.getBirthday() != null) {
                    pstmt.setDate(5, new java.sql.Date(p.getBirthday().getTime()));
                } else {
                    pstmt.setDate(5, null);
                }
                pstmt.setInt(6, p.getResidence().ordinal());
                pstmt.setInt(7, p.getNation().ordinal());
                pstmt.setString(8, p.getPassportNumber());
                pstmt.setInt(9, p.getPassportIssuePlace().ordinal());
                if (p.getPassportExpiryDate() != null) {
                    pstmt.setDate(10, new java.sql.Date(p.getPassportExpiryDate().getTime()));
                } else {
                    pstmt.setDate(10, null);
                }
                pstmt.setInt(11, p.getId());
                // 4.確認主鍵值沒有被修改 執行指令
                // 主鍵值如果被修改 會修改到對應錯誤鍵值的資料...

                pstmt.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(PassengersDAO.class.getName()).log(Level.SEVERE, "乘客修改失敗", ex);
                throw new AACException("乘客修改失敗", ex);
            }
        } else {
            throw new IllegalArgumentException("修改乘客資料時乘客不得為null");
        }
    }

    @Override
    public void delete(Passenger p) throws AACException {
        if (p == null) {
            throw new IllegalArgumentException("乘客刪除失敗-乘客資料不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(DELETE_SQL_P);//3.建立Statement物件
                ) {
            pstmt.setInt(1, p.getId());
            //4.執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PassengersDAO.class.getName()).log(Level.SEVERE, "乘客刪除失敗", ex);
            throw new AACException("乘客刪除失敗", ex);
        }
    }

    @Override
    public Passenger get(Integer id) throws AACException {
        Passenger p = new Passenger();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_ID_P);//3.建立Statement物件
                ) {
            pstmt.setInt(1, id);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
//                    p.setId(rs.getInt("id"));
                    p.setPassengerType(PassengerType.values()[rs.getInt("ptype")]);
                    p.setFirstName(rs.getString("first_name"));
                    p.setLastName(rs.getString("last_name"));
                    p.setGender(Gender.values()[rs.getInt("gender")]);
                    p.setBirthday(rs.getDate("birthday"));
                    p.setResidence(Country.values()[rs.getInt("residence")]);
                    p.setNation(Country.values()[rs.getInt("nation")]);
                    p.setPassportNumber(rs.getString("passport_number"));
                    p.setPassportIssuePlace(Country.values()[rs.getInt("passport_issue_place")]);
                    p.setPassportExpiryDate(rs.getDate("passport_expiry"));
                }
            }
            return p;
        } catch (SQLException ex) {
            Logger.getLogger(PassengersDAO.class.getName()).log(Level.SEVERE, "查詢乘客失敗:" + id, ex);
            throw new AACException("查詢乘客失敗!", ex);
        }
    }

    // 未完成~~
    public List<Passenger> getByName(String firstname, String lastname) throws AACException {
        List<Passenger> list = new ArrayList<>();

        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_NAME_P);//3.建立Statement物件
                ) {
            pstmt.setString(1, firstname);
            pstmt.setString(2, lastname);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
                    Passenger p = new Passenger();
                    System.out.println("rs moved..");
                    p.setId(rs.getInt("id"));
                    p.setPassengerType(PassengerType.valueOf(rs.getString("ptype")));
                    p.setFirstName(rs.getString("first_name"));
                    p.setLastName(rs.getString("last_name"));
                    p.setGender(Gender.valueOf(rs.getString("gender")));
                    p.setBirthday(rs.getDate("birthday"));
                    p.setResidence(Country.values()[rs.getInt("residence")]);
                    p.setNation(Country.values()[rs.getInt("nation")]);
                    p.setPassportNumber(rs.getString("passport_number"));
                    p.setPassportIssuePlace(Country.values()[rs.getInt("passport_issue_place")]);
                    p.setPassportExpiryDate(rs.getDate("passport_expiry"));
                    System.out.println("rs done..");
                    list.add(p);
                }
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(PassengersDAO.class.getName()).log(Level.SEVERE, "查詢乘客失敗:" + firstname + " " + lastname, ex);
            throw new AACException("查詢乘客失敗!", ex);
        }
    }

}
