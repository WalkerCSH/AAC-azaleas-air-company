/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;
import aac.domain.SeatsSelectedSet;
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
public class SeatsSelectedSetDAO implements DAOInterface<Integer, SeatsSelectedSet> { // K主鍵值型別是否不可為基本型別

    private static final String COLUMNS_SSS = "depart_seat_r,depart_seat_1,depart_seat_2,depart_seat_3,"
            + "return_seat_r,return_seat_1,return_seat_2,return_seat_3";

    private static final String TABLE_SSS = "seats_selected_sets";

    private static final String INSERT_SQL_SSS = "INSERT INTO " + TABLE_SSS + " ("
            + COLUMNS_SSS + ") VALUES (?,?,?,?,?,?,?,?)";

    private static final String UPDATE_SQL_SSS = "UPDATE " + TABLE_SSS + " SET "
            + "depart_seat_r=?, depart_seat_1=? ,depart_seat_2=? ,depart_seat_3=? ,"
            + "return_seat_r=?, return_seat_1=?, return_seat_2=? ,return_seat_3=? " + " WHERE id=?";

    private static final String DELETE_SQL_SSS = "DELETE FROM " + TABLE_SSS + " WHERE id=?";

    private static final String SELECT_SQL_BY_ID_SSS = "SELECT " + COLUMNS_SSS + " FROM " + TABLE_SSS
            + " WHERE id=?";

    private static final String SELECT_ALL_SQL_SSS = "SELECT " + COLUMNS_SSS + " FROM " + TABLE_SSS;

    private int seatsSelectedSetsId;

    public int getSeatsSelectedSetsId() {
        return seatsSelectedSetsId;
    }

    public void setSeatsSelectedSetsId(int seatsSelectedSetsId) {
        this.seatsSelectedSetsId = seatsSelectedSetsId;
    }

    @Override
    public void insert(SeatsSelectedSet sss) throws AACException {
        if (sss == null) {
            throw new IllegalArgumentException("座位清單新增失敗-座位清單資料不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt
                = connection.prepareStatement(INSERT_SQL_SSS, Statement.RETURN_GENERATED_KEYS);//3.建立Statement物件
                ) {
            pstmt.setString(1, sss.getDepartSeatR());
            pstmt.setString(2, sss.getDepartSeat1());
            pstmt.setString(3, sss.getDepartSeat2());
            pstmt.setString(4, sss.getDepartSeat3());
            pstmt.setString(5, sss.getReturnSeatR());
            pstmt.setString(6, sss.getReturnSeat1());
            pstmt.setString(7, sss.getReturnSeat2());
            pstmt.setString(8, sss.getReturnSeat3());

            //4.確認是否出現重複乘客資料後 執行指令 並且將DB自給ID放回dao中
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys();) {
                while (rs.next()) {
                    this.setSeatsSelectedSetsId(rs.getInt(1));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatsSelectedSetDAO.class.getName()).log(Level.SEVERE, "座位清單新增失敗", ex);
            throw new AACException("座位清單新增失敗", ex);
        } catch (AACException ex) {
            Logger.getLogger(SeatsSelectedSetDAO.class.getName()).log(Level.SEVERE, "座位清單新增失敗", ex);
            throw ex;
        }
    }

    @Override
    public void update(SeatsSelectedSet sss) throws AACException {
        if (sss != null) {
            try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                    PreparedStatement pstmt = connection.prepareStatement(UPDATE_SQL_SSS);//3.建立Statement物件
                    ) {
                pstmt.setString(1, sss.getDepartSeatR());
                pstmt.setString(2, sss.getDepartSeat1());
                pstmt.setString(3, sss.getDepartSeat2());
                pstmt.setString(4, sss.getDepartSeat3());
                pstmt.setString(5, sss.getReturnSeatR());
                pstmt.setString(6, sss.getReturnSeat1());
                pstmt.setString(7, sss.getReturnSeat2());
                pstmt.setString(8, sss.getReturnSeat3());
                pstmt.setInt(9, sss.getId());
                // 4.確認主鍵值沒有被修改 執行指令
                // 主鍵值如果被修改 會修改到對應錯誤鍵值的資料...

                pstmt.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(SeatsSelectedSetDAO.class.getName()).log(Level.SEVERE, "座位清單修改失敗", ex);
                throw new AACException("座位清單修改失敗", ex);
            }
        } else {
            throw new IllegalArgumentException("修改座位清單資料時座位清單不得為null");
        }
    }

    @Override
    public void delete(SeatsSelectedSet sss) throws AACException {
        if (sss == null) {
            throw new IllegalArgumentException("座位清單刪除失敗-座位清單資料不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(DELETE_SQL_SSS);//3.建立Statement物件
                ) {
            pstmt.setInt(1, sss.getId());
            //4.執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SeatsSelectedSetDAO.class.getName()).log(Level.SEVERE, "座位清單刪除失敗", ex);
            throw new AACException("座位清單刪除失敗", ex);
        }
    }

    @Override
    public SeatsSelectedSet get(Integer id) throws AACException {
        SeatsSelectedSet sss = new SeatsSelectedSet();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_ID_SSS);//3.建立Statement物件
                ) {
            pstmt.setInt(1, id);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
                    sss.setId(rs.getInt("id"));
                    sss.setDepartSeatR(rs.getString("depart_seat_r"));
                    sss.setDepartSeat1(rs.getString("depart_seat_1"));
                    sss.setDepartSeat2(rs.getString("depart_seat_2"));
                    sss.setDepartSeat3(rs.getString("depart_seat_3"));
                    sss.setReturnSeatR(rs.getString("return_seat_r"));
                    sss.setReturnSeat1(rs.getString("return_seat_1"));
                    sss.setReturnSeat2(rs.getString("return_seat_2"));
                    sss.setReturnSeat3(rs.getString("return_seat_3"));
                }
            }
            return sss;
        } catch (SQLException ex) {
            Logger.getLogger(SeatsSelectedSetDAO.class.getName()).log(Level.SEVERE, "查詢座位清單失敗:" + id, ex);
            throw new AACException("查詢座位清單失敗!", ex);
        }
    }

}
