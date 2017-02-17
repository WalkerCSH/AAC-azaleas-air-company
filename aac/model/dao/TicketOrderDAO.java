/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;
import aac.domain.TicketOrder;
import aac.domain.dataCategory.CabinClass;
import aac.domain.dataCategory.FlightRoute;
import aac.domain.dataCategory.TripType;
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
public class TicketOrderDAO implements DAOInterface<Integer, TicketOrder> { // K主鍵值型別是否不可為基本型別

    private static final String COLUMNS_TO = "order_number,trip_type,depart_flight_route,"
            + "depart_date,depart_cabin_class,return_flight_route,return_date,return_cabin_class,customer_id,"
            + "coupon,gross_price,status,passenger_list_id,seats_selected_set_id,order_time";

    private static final String TABLE_TO = "ticket_orders";

    private static final String INSERT_SQL_TO = "INSERT INTO " + TABLE_TO + " ("
            + COLUMNS_TO + ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    private static final String UPDATE_SQL_TO = "UPDATE " + TABLE_TO + " SET "
            + "order_number=?,trip_type,depart_flight_route=?,"
            + "depart_date=?,depart_cabin_class=?,return_flight_route=?,return_date=?,return_cabin_class=?,customer_id=?,"
            + "coupon=?,gross_price=?,status=?,passenger_list_id=?,"
            + "seats_selected_set_id=?,order_time=?" + " WHERE id=?";

    private static final String DELETE_SQL_TO = "DELETE FROM " + TABLE_TO + " WHERE id=?";

    private static final String SELECT_SQL_BY_ID_TO = "SELECT " + COLUMNS_TO + " FROM " + TABLE_TO + " WHERE id=?";
    
    private static final String SELECT_SQL_BY_ORDERNUMBER_TO = "SELECT " + COLUMNS_TO + " FROM " + TABLE_TO + 
            " WHERE order_number=?";

    private int ticketOrderId;

    public int getTicketOrderId() {
        return ticketOrderId;
    }

    public void setTicketOrderId(int ticketOrderId) {
        this.ticketOrderId = ticketOrderId;
    }

    @Override
    public void insert(TicketOrder to) throws AACException {
        if (to == null) {
            throw new IllegalArgumentException("訂單新增失敗-訂單資料不得為null");
        }
        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(INSERT_SQL_TO, Statement.RETURN_GENERATED_KEYS);//3.建立Statement物件
                ) {
            pstmt.setString(1, to.getOrderNumber());
            pstmt.setInt(2, to.getTripType().ordinal());
            pstmt.setInt(3, to.getDepartFlightRoute().ordinal());
            pstmt.setDate(4, new java.sql.Date(to.getDepartDate().getTime()));
            pstmt.setInt(5, to.getCabinClass()[0].ordinal());
            if (to.getTripType().ordinal() == 0) {
                pstmt.setInt(6, to.getReturnFlightRoute().ordinal());
                pstmt.setDate(7, new java.sql.Date(to.getReturnDate().getTime()));
                pstmt.setInt(8, to.getCabinClass()[1].ordinal());
            } else {
                pstmt.setInt(6, 99);
                pstmt.setDate(7, null);
                pstmt.setInt(8, 99);
            }
            pstmt.setInt(9, to.getCustomerId());
            pstmt.setString(10, to.getCoupon());
            pstmt.setInt(11, to.getGrossPrice());
            pstmt.setInt(12, to.getStatus().ordinal());
            pstmt.setInt(13, to.getPassengerListId());
            pstmt.setInt(14, to.getSeatsSelectedSetId());
            pstmt.setTimestamp(15, new java.sql.Timestamp(to.getOrderTime().getTime()));

            //4.確認無重複訂單資料後 執行指令
            pstmt.executeUpdate();
            try (ResultSet rs = pstmt.getGeneratedKeys();) {
                while (rs.next()) {
                    this.setTicketOrderId(rs.getInt(1));
                    System.out.println("rs.getInt(1) = " + rs.getInt(1));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketOrderDAO.class.getName()).log(Level.SEVERE, "訂單新增失敗", ex);
            throw new AACException("訂單新增失敗", ex);
        } catch (AACException ex) {
            Logger.getLogger(TicketOrderDAO.class.getName()).log(Level.SEVERE, "訂單新增失敗", ex);
            throw ex;
        }
    }

    @Override
    public void update(TicketOrder to) throws AACException {
        if (to != null) {
            try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                    PreparedStatement pstmt = connection.prepareStatement(UPDATE_SQL_TO);//3.建立Statement物件
                    ) {
                pstmt.setString(1, to.getOrderNumber());
                pstmt.setInt(2, to.getTripType().ordinal());
                pstmt.setInt(3, to.getDepartFlightRoute().ordinal());
                pstmt.setDate(4, new java.sql.Date(to.getDepartDate().getTime()));
                pstmt.setInt(5, to.getCabinClass()[0].ordinal());
                if (to.getTripType().ordinal() == 0) {
                    pstmt.setInt(6, to.getReturnFlightRoute().ordinal());
                    pstmt.setDate(7, new java.sql.Date(to.getReturnDate().getTime()));
                    pstmt.setInt(8, to.getCabinClass()[1].ordinal());
                } else {
                    pstmt.setInt(6, 99);
                    pstmt.setDate(7, null);
                    pstmt.setInt(8, 99);
                }
                pstmt.setInt(9, to.getCustomerId());
                pstmt.setString(10, to.getCoupon());
                pstmt.setInt(11, to.getGrossPrice());
                pstmt.setInt(12, to.getStatus().ordinal());
                pstmt.setInt(13, to.getPassengerListId());
                pstmt.setInt(14, to.getSeatsSelectedSetId());
                pstmt.setDate(15, new java.sql.Date(to.getOrderTime().getTime()));

                pstmt.setInt(16, to.getId());
                // 4.確認主鍵值沒有被修改 執行指令
                // 主鍵值如果被修改 會修改到對應錯誤鍵值的資料...

                pstmt.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(TicketOrderDAO.class.getName()).log(Level.SEVERE, "訂單修改失敗", ex);
                throw new AACException("訂單修改失敗", ex);
            }
        } else {
            throw new IllegalArgumentException("修改訂單資料時訂單不得為null");
        }
    }

    @Override
    public void delete(TicketOrder to) throws AACException {
        if (to == null) {
            throw new IllegalArgumentException("訂單內容刪除失敗-訂單內容不得為null");
        }

        try (Connection connection = RDBConnection.getConnection();//1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(DELETE_SQL_TO);//3.建立Statement物件
                ) {
            pstmt.setInt(1, to.getId());
            //4.執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TicketOrderDAO.class.getName()).log(Level.SEVERE, "訂單內容刪除失敗", ex);
            throw new AACException("訂單內容刪除失敗", ex);
        }
    }

    @Override
    public TicketOrder get(Integer id) throws AACException {
        TicketOrder to = new TicketOrder();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_ID_TO);//3.建立Statement物件
                ) {
            pstmt.setInt(1, id);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
//                    to.setId(rs.getInt("id"));
                    to.setOrderNumber(rs.getString("order_number"));
                    to.setTripType(TripType.values()[rs.getInt("trip_type")]);

                    to.setDepartFlightRoute(FlightRoute.values()[rs.getInt("depart_flight_route")]);
                    to.setDepartDate(rs.getDate("depart_date"));

                    CabinClass ccd = CabinClass.values()[rs.getInt("depart_cabin_class")];
                    CabinClass ccr = null;
                    if (to.getTripType().ordinal() == 0) {
                        to.setReturnFlightRoute(FlightRoute.values()[rs.getInt("return_flight_route")]);
                        to.setReturnDate(rs.getDate("return_date"));
                        ccr = CabinClass.values()[rs.getInt("return_cabin_class")];
                    }
                    CabinClass[] ccAr = {ccd, ccr};
                    to.setCabinClass(ccAr);

                    to.setCustomerId(rs.getInt("customer_id"));
                    to.setCoupon(rs.getString("coupon"));
                    to.setGrossPrice(rs.getInt("gross_price"));
                    to.setNetPrice();
                    to.setStatus(TicketOrder.Status.values()[rs.getInt("status")]);
                    to.setPassengerListId(rs.getInt("passenger_list_id"));
                    to.setSeatsSelectedSetId(rs.getInt("seats_selected_set_id"));
                    to.setOrderTime(rs.getTimestamp("order_time"));
                }
            }
            return to;
        } catch (SQLException ex) {
            Logger.getLogger(TicketOrderDAO.class.getName()).log(Level.SEVERE, "查詢訂單失敗:" + id, ex);
            throw new AACException("查詢訂單失敗!", ex);
        }
    }

    public TicketOrder getByOrderNumber(String orderNumber) throws AACException {
        TicketOrder to = new TicketOrder();
        try (Connection connection = RDBConnection.getConnection(); //1. 2. 取得連線
                PreparedStatement pstmt = connection.prepareStatement(SELECT_SQL_BY_ORDERNUMBER_TO);//3.建立Statement物件
                ) {
            pstmt.setString(1, orderNumber);

            //4.執行指令
            try (ResultSet rs = pstmt.executeQuery();) {
                //5. 處理rs
                while (rs.next()) {
//                    to.setId(rs.getInt("id"));
                    to.setOrderNumber(rs.getString("order_number"));
                    to.setTripType(TripType.values()[rs.getInt("trip_type")]);

                    to.setDepartFlightRoute(FlightRoute.values()[rs.getInt("depart_flight_route")]);
                    to.setDepartDate(rs.getDate("depart_date"));

                    CabinClass ccd = CabinClass.values()[rs.getInt("depart_cabin_class")];
                    CabinClass ccr = null;
                    if (to.getTripType().ordinal() == 0) {
                        to.setReturnFlightRoute(FlightRoute.values()[rs.getInt("return_flight_route")]);
                        to.setReturnDate(rs.getDate("return_date"));
                        ccr = CabinClass.values()[rs.getInt("return_cabin_class")];
                    }
                    CabinClass[] ccAr = {ccd, ccr};
                    to.setCabinClass(ccAr);

                    to.setCustomerId(rs.getInt("customer_id"));
                    to.setCoupon(rs.getString("coupon"));
                    to.setGrossPrice(rs.getInt("gross_price"));
                    to.setNetPrice();
                    to.setStatus(TicketOrder.Status.values()[rs.getInt("status")]);
                    to.setPassengerListId(rs.getInt("passenger_list_id"));
                    to.setSeatsSelectedSetId(rs.getInt("seats_selected_set_id"));
                    to.setOrderTime(rs.getTimestamp("order_time"));
                }
            }
            return to;
        } catch (SQLException ex) {
            Logger.getLogger(TicketOrderDAO.class.getName()).log(Level.SEVERE, "以訂單代號查詢訂單失敗:" + orderNumber, ex);
            throw new AACException("以訂單代號查詢訂單失敗!", ex);
        }
    }
}
