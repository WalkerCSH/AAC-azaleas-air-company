/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.model.dao.DAOInterface;
import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.FlightRoute;
import aac.domain.PriceSheet;
import aac.domain.dataCategory.CabinClass;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Walker
 */
public class PriceSheetDAO implements DAOInterface<String, PriceSheet> { // K主鍵值型別是否不可為基本型別

    private static final String COLUMNS = "code,effective_date,expiry_date,flight_number,glory_price,fancy_price,happy_price";

    private static final String TABLE = "price_sheet";

    private static final String INSERT_SQL = "INSERT INTO " + TABLE + " ("
            + COLUMNS + ") VALUES (?,?,?,?,?,?,?)";

    private static final String UPDATE_SQL = "UPDATE " + TABLE + " SET "
            + "effective_date=?,expiry_date=?,flight_number=?,glory_price=?,fancy_price=?,happy_price=?" + " WHERE code=?";

    private static final String DELETE_SQL = "DELETE FROM " + TABLE + " WHERE code=?";

    private static final String SELECT_SQL_BY_ID = "SELECT " + COLUMNS + " FROM " + TABLE
            + " WHERE code=?";

    private static final String SELECT_SQL_BY_DATE = "SELECT " + COLUMNS + " FROM " + TABLE
            + " WHERE effective_date<=? AND expiry_date>=?";

    private static final String SELECT_SQL_BY_FLIGHT_NUMBER = "SELECT " + COLUMNS + " FROM " + TABLE
            + " WHERE flight_number=?";

    private static final String SELECT_ALL_SQL = "SELECT " + COLUMNS + " FROM " + TABLE;

    // 參考資料-MySQL語法重點整理 : http://www.mysql.tw/2015/05/select-sql.html
    @Override
    public void insert(PriceSheet ps) throws AACException {
        if (ps == null) {
            throw new IllegalArgumentException("票價表新增失敗-票價表物件不得為null");
        }
        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(INSERT_SQL);//3.建立Statement物件
                ) {
            pstmt.setString(1, ps.getCode());
            pstmt.setDate(2, new java.sql.Date(ps.getEffectiveDate().getTime()));
            pstmt.setDate(3, new java.sql.Date(ps.getExpiryDate().getTime()));
            pstmt.setString(4, ps.getFlightNumber().name());
            pstmt.setInt(5, ps.getGloryPrice());
            pstmt.setInt(6, ps.getFancyPrice());
            pstmt.setInt(7, ps.getHappyPrice());

            //4.確認是否出現重複乘客資料後 執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "票價表新增失敗", ex);
            throw new AACException("票價表新增失敗", ex);
        } catch (AACException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "票價表新增失敗", ex);
            throw ex;
        }
    }

    @Override
    public void update(PriceSheet ps) throws AACException {
        if (ps != null) {
            try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                    PreparedStatement pstmt = connection.prepareStatement(UPDATE_SQL);//3.建立Statement物件
                    ) {
                pstmt.setDate(1, new java.sql.Date(ps.getEffectiveDate().getTime()));
                pstmt.setDate(2, new java.sql.Date(ps.getExpiryDate().getTime()));
                pstmt.setString(3, ps.getFlightNumber().name());
                pstmt.setInt(4, ps.getGloryPrice());
                pstmt.setInt(5, ps.getFancyPrice());
                pstmt.setInt(6, ps.getHappyPrice());
                pstmt.setString(7, ps.getCode());
                // 4.確認主鍵值沒有被修改 執行指令
                // 主鍵值如果被修改 會修改到對應錯誤鍵值的資料...
                pstmt.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "票價表修改失敗", ex);
                throw new AACException("票價表修改失敗", ex);
            }
        } else {
            throw new IllegalArgumentException("票價表修改時票價表物件不得為null");
        }
    }

    @Override
    public void delete(PriceSheet ps) throws AACException {
        if (ps == null) {
            throw new IllegalArgumentException("票價表刪除失敗-票價表物件不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(DELETE_SQL);//3.建立Statement物件
                ) {
            pstmt.setString(1, ps.getCode());
            //4.執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "票價表刪除失敗", ex);
            throw new AACException("票價表刪除失敗", ex);
        }
    }

    @Override
    public PriceSheet get(String code) throws AACException {
        PriceSheet ps = new PriceSheet();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_ID);//3.建立Statement物件
                ) {
            pstmt.setString(1, code);
            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
                    ps.setEffectiveDate(rs.getDate("effective_date"));
                    ps.setExpiryDate(rs.getDate("expiry_date"));
                    ps.setFlightNumber(FlightRoute.valueOf(rs.getString("flight_number")));
                    ps.setCode();
                    ps.setGloryPrice(rs.getInt("glory_price"));
                    ps.setFancyPrice(rs.getInt("fancy_price"));
                    ps.setHappyPrice(rs.getInt("happy_price"));
                }
            }
            return ps;
        } catch (SQLException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "查詢票價表失敗:" + code, ex);
            throw new AACException("查詢票價表失敗!", ex);
        }
    }

    public List<PriceSheet> getByDate(Date date) throws AACException {
        List<PriceSheet> list = new ArrayList<>();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_DATE);//3.建立Statement物件
                ) {
            pstmt.setDate(1, new java.sql.Date(date.getTime()));
            pstmt.setDate(2, new java.sql.Date(date.getTime()));
            try (ResultSet rs = pstmt.executeQuery();//4.執行指令
                    ) {
                while (rs.next()) {
                    //5. 處理rs
                    PriceSheet ps = new PriceSheet();
                    ps.setEffectiveDate(rs.getDate("effective_date"));
                    ps.setExpiryDate(rs.getDate("expiry_date"));
                    ps.setFlightNumber(FlightRoute.valueOf(rs.getString("flight_number")));
                    ps.setCode();
                    ps.setGloryPrice(rs.getInt("glory_price"));
                    ps.setFancyPrice(rs.getInt("fancy_price"));
                    ps.setHappyPrice(rs.getInt("happy_price"));
                    list.add(ps);
                    System.out.println("rs ready for next..");
                }
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "查詢指定日期票價表失敗:", ex);
            throw new AACException("查詢指定日期票價表失敗!", ex);
        }
    }

    public List<PriceSheet> getByFlightNumber(FlightRoute flightNumber) throws AACException {
        List<PriceSheet> list = new ArrayList<>();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_FLIGHT_NUMBER);//3.建立Statement物件
                ) {
            pstmt.setString(1, flightNumber.name());
            try (ResultSet rs = pstmt.executeQuery();//4.執行指令
                    ) {
                while (rs.next()) {
                    //5. 處理rs
                    PriceSheet ps = new PriceSheet();
                    ps.setEffectiveDate(rs.getDate("effective_date"));
                    ps.setExpiryDate(rs.getDate("expiry_date"));
                    ps.setFlightNumber(FlightRoute.valueOf(rs.getString("flight_number")));
                    ps.setCode();
                    ps.setGloryPrice(rs.getInt("glory_price"));
                    ps.setFancyPrice(rs.getInt("fancy_price"));
                    ps.setHappyPrice(rs.getInt("happy_price"));
                    list.add(ps);
                    System.out.println("rs ready for next..");
                }
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "查詢指定航班代號票價表失敗:", ex);
            throw new AACException("查詢指定航班代號票價表失敗!", ex);
        }
    }

    public PriceSheet getByDateAndFlightNumber(Date date, FlightRoute flightNumber) throws AACException {
        PriceSheet ps = new PriceSheet();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_DATE);//3.建立Statement物件
                ) {
            pstmt.setDate(1, new java.sql.Date(date.getTime()));
            pstmt.setDate(2, new java.sql.Date(date.getTime()));
            try (ResultSet rs = pstmt.executeQuery();//4.執行指令
                    ) {
                while (rs.next()) {
                    //5. 處理rs
                    FlightRoute listFlight = FlightRoute.valueOf(rs.getString("flight_number"));
                    if (listFlight.ordinal() == flightNumber.ordinal()) {
                        ps.setEffectiveDate(rs.getDate("effective_date"));
                        ps.setExpiryDate(rs.getDate("expiry_date"));
                        ps.setFlightNumber(FlightRoute.valueOf(rs.getString("flight_number")));
                        ps.setCode();
                        ps.setGloryPrice(rs.getInt("glory_price"));
                        ps.setFancyPrice(rs.getInt("fancy_price"));
                        ps.setHappyPrice(rs.getInt("happy_price"));
                    }
                    System.out.println("rs ready for next..");
                }
            }
            return ps;
        } catch (SQLException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "查詢指定航班代號票價表失敗:", ex);
            throw new AACException("查詢指定航班代號票價表失敗!", ex);
        }
    }    
    
    public List<PriceSheet> getAll() throws AACException {
        List<PriceSheet> list = new ArrayList<>();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_SQL);//3.建立Statement物件
                ResultSet rs = pstmt.executeQuery();//4.執行指令
                ) {
            //5. 處理rs
            while (rs.next()) {
                PriceSheet ps = new PriceSheet();
                ps.setEffectiveDate(rs.getDate("effective_date"));
                ps.setExpiryDate(rs.getDate("expiry_date"));
                ps.setFlightNumber(FlightRoute.valueOf(rs.getString("flight_number")));
                ps.setCode();
                ps.setGloryPrice(rs.getInt("glory_price"));
                ps.setFancyPrice(rs.getInt("fancy_price"));
                ps.setHappyPrice(rs.getInt("happy_price"));
                list.add(ps);
                System.out.println("rs ready for next..");
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(PriceSheetDAO.class.getName()).log(Level.SEVERE, "查詢所有票價表失敗:", ex);
            throw new AACException("查詢所有票價表失敗!", ex);
        }
    }

//    @Override
//    public PriceSheet get(Integer id) throws AACException {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
//    }
}
