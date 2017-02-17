/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test;

import aac.domain.dataCategory.FlightRoute;
import aac.domain.PriceSheet;
import aac.model.dao.PriceSheetDAO;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

/**
 *
 * @author Walker
 */
public class TestPriceSheetDAO {

    public static void main(String[] args) throws Exception {
        PriceSheetDAO psdao = new PriceSheetDAO();
        SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy/MM/dd");
        Calendar cal = new GregorianCalendar();
        
        cal.setTime(sdfDateOnly.parse("2017/05/22"));        
        Date effectiveDate = cal.getTime();
        cal.add(Calendar.WEEK_OF_MONTH, 4);
        Date expiryDate = cal.getTime();
        System.out.println(effectiveDate);
        System.out.println(expiryDate);
        
        // 測insert
        PriceSheet ps1 = new PriceSheet(effectiveDate, expiryDate, FlightRoute.JZ121, 9000 + 0, 7500 + 0, 6000 + 0);
        psdao.insert(ps1);
        PriceSheet ps2 = new PriceSheet(effectiveDate, expiryDate, FlightRoute.JZ122, 8500 + 0, 7000 + 0, 6000 + 0);
        psdao.insert(ps2);
        PriceSheet ps3 = new PriceSheet(effectiveDate, expiryDate, FlightRoute.JZ151, 9000 + 0, 8000 + 0, 6500 + 0);
        psdao.insert(ps3);
        PriceSheet ps4 = new PriceSheet(effectiveDate, expiryDate, FlightRoute.JZ152, 9000 + 0, 7500 + 0, 6000 + 0);
        psdao.insert(ps4);
        PriceSheet ps5 = new PriceSheet(effectiveDate, expiryDate, FlightRoute.JZ191, 9500 + 0, 8500 + 0, 7500 + 0);
        psdao.insert(ps5);
        PriceSheet ps6 = new PriceSheet(effectiveDate, expiryDate, FlightRoute.JZ192, 9500 + 0, 8000 + 0, 7000 + 0);
        psdao.insert(ps6);

        // 測get, getAll
//        PriceSheet ps = psdao.get("2016120120170131JZ191");
//        List<PriceSheet> list = psdao.getAll();
//        for(PriceSheet ps : list){
//            System.out.println("code = " + ps.getCode());
//            System.out.println("EffectiveDate = " + ps.getEffectiveDate());
//            System.out.println("ExpiryDate = " + ps.getExpiryDate());
//            System.out.println("FlightRoute = " + ps.getFlightNumber().name());
//            System.out.println("GloryPrice = " + ps.getGloryPrice());
//            System.out.println("FancyPrice = " + ps.getFancyPrice());
//            System.out.println("HappyPrice = " + ps.getHappyPrice());            
//        }
        // 測getByDate,getByFlightNumber
//        Date searchDate = sdfDateOnly.parse("2016/12/05");
//        List<PriceSheet> list = psdao.getByDate(searchDate);
//        PriceSheet ps = psdao.getByDateAndFlightNumber(searchDate, FlightRoute.JZ121);
//        List<PriceSheet> list = psdao.getByFlightNumber(FlightRoute.JZ122);
//        for(PriceSheet ps : list){
//            System.out.println("code = " + ps.getCode());
//            System.out.println("EffectiveDate = " + ps.getEffectiveDate());
//            System.out.println("ExpiryDate = " + ps.getExpiryDate());
//            System.out.println("FlightNumber = " + ps.getFlightNumber().name());
//            System.out.println("FlightNumber = " + ps.getFlightNumber());
//            System.out.println("GloryPrice = " + ps.getGloryPrice());
//            System.out.println("FancyPrice = " + ps.getFancyPrice());
//            System.out.println("HappyPrice = " + ps.getHappyPrice());            
//        }
    }
}
