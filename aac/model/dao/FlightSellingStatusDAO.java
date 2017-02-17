/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.Aircraft;
import aac.domain.dataCategory.CabinClass;
import aac.domain.dataCategory.FlightRoute;
import aac.domain.Flight;
import aac.domain.flight.PresentAvailable;
import aac.domain.flight.PresentSold;
import aac.domain.flight.SeatDistribute;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class FlightSellingStatusDAO implements DAOInterface<String, Flight> {

    // FlightInfoDAO >>FI
    private static final String COLUMNS_FI = "id,takeoff_date,flight_number,aircraft_type,status";
    private static final String TABLE_FI = "flight_info";
    private static final String INSERT_SQL_FI = "INSERT INTO " + TABLE_FI + " ("
            + COLUMNS_FI + ") VALUES (?,?,?,?,?)";
    private static final String UPDATE_SQL_FI = "UPDATE " + TABLE_FI + " SET "
            + "take_off_date=? ,flight_number=? ,aircraft_type=? ,status=? " + " WHERE id=?";
    private static final String DELETE_SQL_FI = "DELETE FROM " + TABLE_FI + " WHERE id=?";
    private static final String SELECT_SQL_BY_ID_FI = "SELECT " + COLUMNS_FI + " FROM " + TABLE_FI
            + " WHERE id=?";
    private static final String SELECT_ALL_SQL_FI = "SELECT " + COLUMNS_FI + " FROM " + TABLE_FI;

    // FlightPresentSoldDAO >>FPS
    private static final String COLUMNS_FPS = "id,glory,fancy,happy";
    private static final String TABLE_FPS = "flight_present_sold";
    private static final String INSERT_SQL_FPS = "INSERT INTO " + TABLE_FPS + " ("
            + COLUMNS_FPS + ") VALUES (?,?,?,?)";
    private static final String UPDATE_SQL_FPS = "UPDATE " + TABLE_FPS + " SET "
            + "glory=? ,fancy=? ,happy=?" + " WHERE id=?";
    private static final String DELETE_SQL_FPS = "DELETE FROM " + TABLE_FPS + " WHERE id=?";
    private static final String SELECT_SQL_BY_ID_FPS = "SELECT " + COLUMNS_FPS + " FROM " + TABLE_FPS
            + " WHERE id=?";
    private static final String SELECT_ALL_SQL_FPS = "SELECT " + COLUMNS_FPS + " FROM " + TABLE_FPS;

    // FlightSeatDistributeDAO >> FSD
    private static final String COLUMNS_FSD = "id,column_a,column_b,column_c,column_d,column_e,"
            + "column_f,column_g,column_h,column_j,column_k";
    private static final String TABLE_FSD = "flight_seat_distribute";
    private static final String INSERT_SQL_FSD = "INSERT INTO " + TABLE_FSD + " ("
            + COLUMNS_FSD + ") VALUES (?,?,?,?,?,?,?,?,?,?,?)";
    private static final String UPDATE_SQL_FSD = "UPDATE " + TABLE_FSD + " SET "
            + "column_a=?,column_b=?,column_c=?,column_d=?,column_e=?,"
            + "column_f=?,column_g=?,column_h=?,column_j=?,column_k=?" + " WHERE id=?";
    private static final String DELETE_SQL_FSD = "DELETE FROM " + TABLE_FSD + " WHERE id=?";
    private static final String SELECT_SQL_BY_ID_FSD = "SELECT " + COLUMNS_FSD + " FROM " + TABLE_FSD
            + " WHERE id=?";
    private static final String SELECT_ALL_SQL_FSD = "SELECT " + COLUMNS_FSD + " FROM " + TABLE_FSD;

    @Override
    public void insert(Flight fss) throws AACException {
        if (fss == null) {
            throw new IllegalArgumentException("航班不得為null");
        }
        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmtFI = connection.prepareStatement(INSERT_SQL_FI);//3.建立Statement物件
                PreparedStatement pstmtFPS = connection.prepareStatement(INSERT_SQL_FPS);
                PreparedStatement pstmtFSD = connection.prepareStatement(INSERT_SQL_FSD);) {
            connection.setAutoCommit(false); // 只要其中出現錯誤 整筆都會回溯 不會出現部分完成的情況
            try {
                pstmtFI.setString(1, fss.getId());
                pstmtFI.setDate(2, new java.sql.Date(fss.getTakeOffDate().getTime()));
                pstmtFI.setString(3, fss.getFlightRoute().name());
                pstmtFI.setString(4, fss.getType().name());
                pstmtFI.setInt(5, fss.getStatus().ordinal());

                pstmtFPS.setString(1, fss.getId());
                pstmtFPS.setInt(2, fss.getPresentSold().getGloryClassAmount());
                pstmtFPS.setInt(3, fss.getPresentSold().getFancyClassAmount());
                pstmtFPS.setInt(4, fss.getPresentSold().getHappyClassAmount());

                pstmtFSD.setString(1, fss.getId());
                pstmtFSD.setInt(2, Integer.parseInt(fss.getSeatDistribute().getColumnA(), 2));
                pstmtFSD.setInt(3, Integer.parseInt(fss.getSeatDistribute().getColumnB(), 2));
                pstmtFSD.setInt(4, Integer.parseInt(fss.getSeatDistribute().getColumnC(), 2));
                pstmtFSD.setInt(5, Integer.parseInt(fss.getSeatDistribute().getColumnD(), 2));
                pstmtFSD.setInt(6, Integer.parseInt(fss.getSeatDistribute().getColumnE(), 2));
                pstmtFSD.setInt(7, Integer.parseInt(fss.getSeatDistribute().getColumnF(), 2));
                pstmtFSD.setInt(8, Integer.parseInt(fss.getSeatDistribute().getColumnG(), 2));
                pstmtFSD.setInt(9, Integer.parseInt(fss.getSeatDistribute().getColumnH(), 2));
                pstmtFSD.setInt(10, Integer.parseInt(fss.getSeatDistribute().getColumnJ(), 2));
                pstmtFSD.setInt(11, Integer.parseInt(fss.getSeatDistribute().getColumnK(), 2));

                //4.確認是否出現重複乘客資料後 執行指令
                pstmtFI.executeUpdate();
                pstmtFPS.executeUpdate();
                pstmtFSD.executeUpdate();
                connection.commit();
            } catch (SQLException ex) {
                connection.rollback();
                Logger.getLogger(FlightSellingStatusDAO.class.getName()).log(Level.SEVERE, "航班新增失敗", ex);
                throw ex;
            } finally {
                connection.setAutoCommit(true); // 將AutoCommit改回設定 才能還給connection pool
            }
        } catch (AACException ex) {
            Logger.getLogger(FlightSellingStatusDAO.class.getName()).log(Level.SEVERE, "航班新增失敗", ex);
            throw new AACException("航班新增失敗", ex);
        } catch (SQLException ex) {
            Logger.getLogger(FlightSellingStatusDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw new AACException("航班新增失敗", ex);
        }
    }

    @Override
    public void update(Flight fss) throws AACException {
        throw new UnsupportedOperationException("update is not supported...");
    }

    public void seatsSelected(Flight fss) throws AACException {
        if (fss != null) {
            try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                    PreparedStatement pstmtFSD = connection.prepareStatement(UPDATE_SQL_FSD);//3.建立Statement物件
                    PreparedStatement pstmtFPS = connection.prepareStatement(UPDATE_SQL_FPS);) {
                connection.setAutoCommit(false); // 只要其中出現錯誤 整筆都會回溯 不會出現部分完成的情況
                try {                    
                    pstmtFSD.setInt(1, Integer.parseInt(fss.getSeatDistribute().getColumnA(), 2));
                    pstmtFSD.setInt(2, Integer.parseInt(fss.getSeatDistribute().getColumnB(), 2));
                    pstmtFSD.setInt(3, Integer.parseInt(fss.getSeatDistribute().getColumnC(), 2));
                    pstmtFSD.setInt(4, Integer.parseInt(fss.getSeatDistribute().getColumnD(), 2));
                    pstmtFSD.setInt(5, Integer.parseInt(fss.getSeatDistribute().getColumnE(), 2));
                    pstmtFSD.setInt(6, Integer.parseInt(fss.getSeatDistribute().getColumnF(), 2));
                    pstmtFSD.setInt(7, Integer.parseInt(fss.getSeatDistribute().getColumnG(), 2));
                    pstmtFSD.setInt(8, Integer.parseInt(fss.getSeatDistribute().getColumnH(), 2));
                    pstmtFSD.setInt(9, Integer.parseInt(fss.getSeatDistribute().getColumnJ(), 2));
                    pstmtFSD.setInt(10, Integer.parseInt(fss.getSeatDistribute().getColumnK(), 2));
                    pstmtFSD.setString(11, fss.getId());                    
                    
                    pstmtFPS.setInt(1, SeatDistribute.countPassengers(fss.getType(), CabinClass.GLORY, fss.getSeatDistribute()));
                    pstmtFPS.setInt(2, SeatDistribute.countPassengers(fss.getType(), CabinClass.FANCY, fss.getSeatDistribute()));
                    pstmtFPS.setInt(3, SeatDistribute.countPassengers(fss.getType(), CabinClass.HAPPY, fss.getSeatDistribute()));
                    pstmtFPS.setString(4, fss.getId());

                    // 4.確認主鍵值沒有被修改 執行指令
                    // 主鍵值如果被修改 會修改到對應錯誤鍵值的資料...
                    pstmtFSD.executeUpdate();
                    pstmtFPS.executeUpdate();
                    connection.commit();
                } catch (SQLException ex) {
                    connection.rollback();
                    Logger.getLogger(FlightSellingStatusDAO.class.getName()).log(Level.SEVERE, "選擇座位失敗", ex);
                    throw ex;
                } finally {
                    connection.setAutoCommit(true); // 將AutoCommit改回設定 才能還給connection pool
                }
            } catch (SQLException ex) {
                Logger.getLogger(FlightSellingStatusDAO.class.getName()).log(Level.SEVERE, "選擇座位失敗", ex);
                throw new AACException("選擇座位失敗", ex);
            }
        } else {
            throw new IllegalArgumentException("航班不得為null");
        }
    }

    public void seatsCanceled(String id) throws AACException {
        throw new UnsupportedOperationException("seatsCanceled has not been supported yet...");
    }

    @Override
    public void delete(Flight fss) throws AACException {
        throw new UnsupportedOperationException("delete is not supported...");
    }

    @Override
    public Flight get(String id) throws AACException {
        Flight fss = new Flight();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmtFI = connection.prepareStatement(SELECT_SQL_BY_ID_FI);//3.建立Statement物件
                PreparedStatement pstmtFPS = connection.prepareStatement(SELECT_SQL_BY_ID_FPS);
                PreparedStatement pstmtFSD = connection.prepareStatement(SELECT_SQL_BY_ID_FSD);) {
            pstmtFI.setString(1, id);
            pstmtFPS.setString(1, id);
            pstmtFSD.setString(1, id);
            //4.執行指令
            try (ResultSet rsFI = pstmtFI.executeQuery();
                    ResultSet rsFPS = pstmtFPS.executeQuery();
                    ResultSet rsFSD = pstmtFSD.executeQuery();) {
                //5. 處理rs
                while (rsFI.next() && rsFPS.next() && rsFSD.next()) {
                    fss.setTakeOffDate(rsFI.getDate("takeoff_date"));
                    fss.setFlightRoute(FlightRoute.valueOf(rsFI.getString("flight_number")));
                    Aircraft type = Aircraft.valueOf(rsFI.getString("aircraft_type"));
                    fss.setType(type);
                    fss.setStatus(Flight.Status.values()[rsFI.getInt("status")]);
                    fss.setId();

                    PresentSold ps = new PresentSold(rsFPS.getInt("glory"), rsFPS.getInt("fancy"), rsFPS.getInt("happy"));
                    fss.setPresentSold(ps);
                    fss.setPresentAvailable(new PresentAvailable(type, ps));

                    SeatDistribute sd = new SeatDistribute();
                    sd.resetColumnA(Integer.toBinaryString(rsFSD.getInt("column_a")));
                    sd.resetColumnB(Integer.toBinaryString(rsFSD.getInt("column_b")));
                    sd.resetColumnC(Integer.toBinaryString(rsFSD.getInt("column_c")));
                    sd.resetColumnD(Integer.toBinaryString(rsFSD.getInt("column_d")));
                    sd.resetColumnE(Integer.toBinaryString(rsFSD.getInt("column_e")));
                    sd.resetColumnF(Integer.toBinaryString(rsFSD.getInt("column_f")));
                    sd.resetColumnG(Integer.toBinaryString(rsFSD.getInt("column_g")));
                    sd.resetColumnH(Integer.toBinaryString(rsFSD.getInt("column_h")));
                    sd.resetColumnJ(Integer.toBinaryString(rsFSD.getInt("column_j")));
                    sd.resetColumnK(Integer.toBinaryString(rsFSD.getInt("column_k")));
                    fss.setSeatDistribute(sd);
                }
            }
            return fss;

        } catch (SQLException ex) {
            Logger.getLogger(FlightSellingStatusDAO.class.getName()).log(Level.SEVERE, "查詢航班失敗:" + id, ex);
            throw new AACException("查詢航班失敗!", ex);
        }
    }

    public List<Flight> getAll() throws AACException {
        List<Flight> list = new ArrayList<>();

        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmtFI = connection.prepareStatement(SELECT_ALL_SQL_FI);//3.建立Statement物件
                PreparedStatement pstmtFPS = connection.prepareStatement(SELECT_ALL_SQL_FPS);
                PreparedStatement pstmtFSD = connection.prepareStatement(SELECT_ALL_SQL_FSD);
                ResultSet rsFI = pstmtFI.executeQuery();//4.執行指令
                ResultSet rsFPS = pstmtFPS.executeQuery();
                ResultSet rsFSD = pstmtFSD.executeQuery();) {
            //5. 處理rs
            while (rsFI.next() && rsFPS.next() && rsFSD.next()) {
                Flight fss = new Flight();
                System.out.println("rs moved..");
                fss.setTakeOffDate(rsFI.getDate("takeoff_date"));
                fss.setFlightRoute(FlightRoute.valueOf(rsFI.getString("flight_number")));
                Aircraft type = Aircraft.valueOf(rsFI.getString("aircraft_type"));
                fss.setType(type);
                fss.setStatus(Flight.Status.values()[rsFI.getInt("status")]);
                fss.setId();

                PresentSold ps = new PresentSold(rsFPS.getInt("glory"), rsFPS.getInt("fancy"), rsFPS.getInt("happy"));
                fss.setPresentSold(ps);
                fss.setPresentAvailable(new PresentAvailable(type, ps));

                SeatDistribute sd = new SeatDistribute();
                sd.resetColumnA(Integer.toBinaryString(rsFSD.getInt("column_a")));
                sd.resetColumnB(Integer.toBinaryString(rsFSD.getInt("column_b")));
                sd.resetColumnC(Integer.toBinaryString(rsFSD.getInt("column_c")));
                sd.resetColumnD(Integer.toBinaryString(rsFSD.getInt("column_d")));
                sd.resetColumnE(Integer.toBinaryString(rsFSD.getInt("column_e")));
                sd.resetColumnF(Integer.toBinaryString(rsFSD.getInt("column_f")));
                sd.resetColumnG(Integer.toBinaryString(rsFSD.getInt("column_g")));
                sd.resetColumnH(Integer.toBinaryString(rsFSD.getInt("column_h")));
                sd.resetColumnJ(Integer.toBinaryString(rsFSD.getInt("column_j")));
                sd.resetColumnK(Integer.toBinaryString(rsFSD.getInt("column_k")));
                fss.setSeatDistribute(sd);
                list.add(fss);
                System.out.println("rs ready for next..");
            }
            return list;

        } catch (SQLException ex) {
            Logger.getLogger(FlightSellingStatusDAO.class.getName()).log(Level.SEVERE, "查詢航班資訊失敗:", ex);
            throw new AACException("查詢航班資訊失敗!", ex);
        }
    }

}
