/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;
import aac.domain.Passenger;
import aac.domain.PassengerList;
import aac.model.service.PassengerServices;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Walker
 */
public class PassengerListDAO implements DAOInterface<Integer, PassengerList> { // K主鍵值型別是否不可為基本型別

    private static final String COLUMNS_PL = "adult,child,infant,passenger_id_r,passenger_id_1,passenger_id_2,passenger_id_3";

    private static final String TABLE_PL = "passenger_list";

    private static final String INSERT_SQL_PL = "INSERT INTO " + TABLE_PL + " ("
            + COLUMNS_PL + ") VALUES (?,?,?,?,?,?,?)";

    private static final String UPDATE_SQL_PL = "UPDATE " + TABLE_PL + " SET "
            + "adult=?, child=? ,infant=? ,passenger_id_r=? ,passenger_id_1=? ,"
            + "passenger_id_2=? ,passenger_id_3=? " + " WHERE id=?";

    private static final String DELETE_SQL_PL = "DELETE FROM " + TABLE_PL + " WHERE id=?";

    private static final String SELECT_SQL_BY_ID_PL = "SELECT " + COLUMNS_PL + " FROM " + TABLE_PL
            + " WHERE id=?";

    private static final String SELECT_ALL_SQL_PL = "SELECT " + COLUMNS_PL + " FROM " + TABLE_PL;
    
    private int passengerListId;

    public int getPassengerListId() {
        return passengerListId;
    }

    public void setPassengerListId(int passengerListId) {
        this.passengerListId = passengerListId;
    }

    @Override
    public void insert(PassengerList pl) throws AACException {
        if (pl == null) {
            throw new IllegalArgumentException("乘客名單新增失敗-乘客名單不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(INSERT_SQL_PL, Statement.RETURN_GENERATED_KEYS);//3.建立Statement物件
                ) {
            pstmt.setInt(1, pl.getAdultNumber());
            pstmt.setInt(2, pl.getChildNumber());
            pstmt.setInt(3, pl.getInfantNumber());
            pstmt.setInt(4, pl.getPassengerIdR());
            pstmt.setInt(5, pl.getPassengerId1());
            pstmt.setInt(6, pl.getPassengerId2());
            pstmt.setInt(7, pl.getPassengerId3());

            //4.確認是否出現重複乘客資料後 執行指令
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys();) {
                while (rs.next()) {
                    this.setPassengerListId(rs.getInt(1));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PassengerListDAO.class.getName()).log(Level.SEVERE, "乘客名單新增失敗", ex);
            throw new AACException("乘客名單新增失敗", ex);
        } catch (AACException ex) {
            Logger.getLogger(PassengerListDAO.class.getName()).log(Level.SEVERE, "乘客名單新增失敗", ex);
            throw ex;
        }
    }

    @Override
    public void update(PassengerList pl) throws AACException {
        if (pl != null) {
            try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                    PreparedStatement pstmt = connection.prepareStatement(UPDATE_SQL_PL);//3.建立Statement物件
                    ) {
                pstmt.setInt(1, pl.getAdultNumber());
                pstmt.setInt(2, pl.getChildNumber());
                pstmt.setInt(3, pl.getInfantNumber());
                pstmt.setInt(4, pl.getPassengerIdR());
                pstmt.setInt(5, pl.getPassengerId1());
                pstmt.setInt(6, pl.getPassengerId2());
                pstmt.setInt(7, pl.getPassengerId3());
                pstmt.setInt(8, pl.getId());
                // 4.確認主鍵值沒有被修改 執行指令
                // 主鍵值如果被修改 會修改到對應錯誤鍵值的資料...

                pstmt.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(PassengerListDAO.class.getName()).log(Level.SEVERE, "乘客名單修改失敗", ex);
                throw new AACException("乘客名單修改失敗", ex);
            }
        } else {
            throw new IllegalArgumentException("修改乘客名單時客戶不得為null");
        }
    }

    @Override
    public void delete(PassengerList p) throws AACException {
        if (p == null) {
            throw new IllegalArgumentException("乘客名單刪除失敗-乘客名單不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(DELETE_SQL_PL);//3.建立Statement物件
                ) {
            pstmt.setInt(1, p.getId());
            //4.執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PassengerListDAO.class.getName()).log(Level.SEVERE, "乘客名單刪除失敗", ex);
            throw new AACException("乘客名單刪除失敗", ex);
        }
    }

    @Override
    public PassengerList get(Integer id) throws AACException {
        PassengerList pl = new PassengerList();
        String[] passengerName = {"passenger_id_r", "passenger_id_1", "passenger_id_2", "passenger_id_3"};
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_ID_PL);//3.建立Statement物件
                ) {
            pstmt.setInt(1, id);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
//                    pl.setId(rs.getInt("id"));
                    int[] passengers = {rs.getInt("adult"), rs.getInt("child"), rs.getInt("infant")};
                    pl.setPassengers(passengers);
                    int totalpassengers = pl.getAdultNumber() + pl.getChildNumber();
                    Passenger[] passengerInfo = {null, null, null, null};
                    PassengerServices ps = new PassengerServices();
                    for (int i = 0; i < totalpassengers; i++) {
                        passengerInfo[i] = ps.find(rs.getInt(passengerName[i]));
                    }
                    pl.setPassengerInfo(passengerInfo);
                }
            }
            return pl;
        } catch (SQLException ex) {
            Logger.getLogger(PassengerListDAO.class.getName()).log(Level.SEVERE, "查詢乘客名單失敗:" + id, ex);
            throw new AACException("查詢乘客名單失敗!", ex);
        }
    }

}
