/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;
import aac.domain.Customer;
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
public class CustomersDAO implements DAOInterface<Integer, Customer> { // K主鍵值型別是否不可為基本型別

    private static final String COLUMNS_C = "passenger_id,email,mobile,card_number,card_expiry_date,card_ccv";

    private static final String TABLE_C = "customers";

    private static final String INSERT_SQL_C = "INSERT INTO " + TABLE_C + " ("
            + COLUMNS_C + ") VALUES (?,?,?,?,?,?)";

    private static final String UPDATE_SQL_C = "UCDATE " + TABLE_C + " SET "
            + "passenger_id=? ,email=? ,mobile=? ,card_number=? ,card_expiry_date=? ,"
            + "card_ccv=? " + " WHERE id=?";

    private static final String DELETE_SQL_C = "DELETE FROM " + TABLE_C + " WHERE id=?";

    private static final String SELECT_SQL_BY_ID_C = "SELECT " + COLUMNS_C + " FROM " + TABLE_C
            + " WHERE id=?";
    
    private static final String SELECT_SQL_BY_EMAIL_C = "SELECT " + COLUMNS_C + " FROM " + TABLE_C
            + " WHERE email=?";

    private static final String SELECT_ALL_SQL_C = "SELECT " + COLUMNS_C + " FROM " + TABLE_C;

    private int CustomerId;

    public int getCustomerId() {
        return CustomerId;
    }

    public void setCustomerId(int CustomerId) {
        this.CustomerId = CustomerId;
    }

    @Override
    public void insert(Customer c) throws AACException {
        if (c == null) {
            throw new IllegalArgumentException("顧客新增失敗-顧客資料不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt
                = connection.prepareStatement(INSERT_SQL_C, Statement.RETURN_GENERATED_KEYS);//3.建立Statement物件
                ) {
            pstmt.setInt(1, c.getPassengerId());
            pstmt.setString(2, c.getEmail());
            pstmt.setString(3, c.getMobile());
            pstmt.setString(4, c.getCardNumber());
            pstmt.setDate(5, new java.sql.Date(c.getCardExpiryDate().getTime()));
            pstmt.setString(6, c.getCardCCV());

            //4.確認顧客資料後 執行指令 並且將DB自給ID放回dao中
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys();) {
                while (rs.next()) {
                    this.setCustomerId(rs.getInt(1));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, "顧客新增失敗", ex);
            throw new AACException("顧客新增失敗", ex);
        } catch (AACException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, "顧客新增失敗", ex);
            throw ex;
        }
    }

    @Override
    public void update(Customer c) throws AACException {
        if (c != null) {
            try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                    PreparedStatement pstmt = connection.prepareStatement(UPDATE_SQL_C);//3.建立Statement物件
                    ) {
                pstmt.setInt(1, c.getPassengerId());
                pstmt.setString(2, c.getEmail());
                pstmt.setString(3, c.getMobile());
                pstmt.setString(4, c.getCardNumber());
                pstmt.setDate(5, new java.sql.Date(c.getCardExpiryDate().getTime()));
                pstmt.setString(6, c.getCardCCV());
                pstmt.setInt(7, c.getId());
                // 4.確認主鍵值沒有被修改 執行指令
                // 主鍵值如果被修改 會修改到對應錯誤鍵值的資料...

                pstmt.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, "顧客修改失敗", ex);
                throw new AACException("顧客修改失敗", ex);
            }
        } else {
            throw new IllegalArgumentException("修改顧客資料時顧客不得為null");
        }
    }

    @Override
    public void delete(Customer c) throws AACException {
        if (c == null) {
            throw new IllegalArgumentException("顧客刪除失敗-顧客資料不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(DELETE_SQL_C);//3.建立Statement物件
                ) {
            pstmt.setInt(1, c.getId());
            //4.執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, "顧客刪除失敗", ex);
            throw new AACException("顧客刪除失敗", ex);
        }
    }

    @Override
    public Customer get(Integer id) throws AACException {
        Customer c = new Customer();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_ID_C);//3.建立Statement物件
                ) {
            pstmt.setInt(1, id);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
//                    c.setId(rs.getInt("id"));
                    c.setPassengerId(rs.getInt("passenger_id"));
                    c.setEmail(rs.getString("email"));
                    c.setMobile(rs.getString("mobile"));
                    c.setCardNumber(rs.getString("card_number"));
                    c.setCardExpiryDate(rs.getDate("card_expiry_date"));
                    c.setCardCCV(rs.getString("card_ccv"));
                }
            }
            return c;
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, "查詢顧客失敗:" + id, ex);
            throw new AACException("查詢顧客失敗!", ex);
        }
    }
    
    public Customer getByEmail(String email) throws AACException {
        Customer c = new Customer();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_EMAIL_C);//3.建立Statement物件
                ) {
            pstmt.setString(1, email);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
//                    c.setId(rs.getInt("id"));
                    c.setPassengerId(rs.getInt("passenger_id"));
                    c.setEmail(rs.getString("email"));
                    c.setMobile(rs.getString("mobile"));
                    c.setCardNumber(rs.getString("card_number"));
                    c.setCardExpiryDate(rs.getDate("card_expiry_date"));
                    c.setCardCCV(rs.getString("card_ccv"));
                }
            }
            return c;
        } catch (SQLException ex) {
            Logger.getLogger(CustomersDAO.class.getName()).log(Level.SEVERE, "查詢顧客失敗:" + email, ex);
            throw new AACException("查詢顧客失敗!", ex);
        }
    }
}
