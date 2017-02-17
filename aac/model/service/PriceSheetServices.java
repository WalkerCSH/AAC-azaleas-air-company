/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model;

import aac.model.dao.PassengersDAO;
import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.FlightRoute;
import aac.domain.Passenger;
import aac.domain.PriceSheet;
import aac.domain.dataCategory.CabinClass;
import aac.model.dao.PriceSheetDAO;
import java.util.Date;

/**
 *
 * @author Walker
 */
public class PriceSheetServices {

    private final PriceSheetDAO psdao = new PriceSheetDAO();

    /**
     * 提供消費者(Customer)輸入查詢機票價格的商業邏輯
     *
     * @param date:搭乘日期
     * @param flightNumber:航班編號
     * @throws aac.domain.dataCategory.AACException
     */
    public PriceSheet getPriceByDateAndFlightRoute(Date date, FlightRoute flightNumber) throws AACException {
        //TODO: replace by JDBC insert....
        return psdao.getByDateAndFlightNumber(date, flightNumber);
    }

    public int getPriceByDateAndFlightRouteAndClass(Date date, FlightRoute flightNumber, CabinClass cabinClass) throws AACException {
        //TODO: replace by JDBC insert....
        PriceSheet ps = psdao.getByDateAndFlightNumber(date, flightNumber);
        int price = 0;
        switch (cabinClass.ordinal()) {
            case 0:
                price = ps.getGloryPrice();
                break;
            case 1:
                price = ps.getFancyPrice();
                break;
            case 2:
                price = ps.getHappyPrice();
                break;
        }
        return price;
    }

}
