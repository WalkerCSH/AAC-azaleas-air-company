/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test;

import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.Aircraft;
import aac.domain.dataCategory.CabinClass;
import aac.domain.dataCategory.FlightRoute;
import aac.domain.Flight;
import aac.domain.flight.PresentSold;
import aac.domain.flight.SeatDistribute;
import aac.model.service.FlightSellingStatusServices;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Walker
 */
public class TestFlightSellingStatusServices {

    public static void main(String[] args) throws Exception {
        FlightSellingStatusServices fsss = new FlightSellingStatusServices();
        SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy/MM/dd");
        Aircraft[] ac = {Aircraft.A330, Aircraft.B777};
        FlightRoute[] fn
                = {FlightRoute.JZ121, FlightRoute.JZ122, FlightRoute.JZ151, FlightRoute.JZ152, FlightRoute.JZ191, FlightRoute.JZ192};

        // 測insert
        Calendar c = Calendar.getInstance();
        for (int i = 1; i <= 210; i++) {
            c.set(2016, 10 - 1, i);
            for (int j = 0; j < 6; j++) {
                if (j == 2 || j == 3) {
                    Flight flight = new Flight(c.getTime(), fn[j], ac[0]);

                    SeatDistribute sd = new SeatDistribute(ac[0]);
                    sd.randomSeatDistribute(ac[0]);
                    flight.setSeatDistribute(sd);
                    PresentSold ps = new PresentSold(SeatDistribute.countPassengers(ac[0], CabinClass.values()[0], sd),
                            SeatDistribute.countPassengers(ac[0], CabinClass.values()[1], sd),
                            SeatDistribute.countPassengers(ac[0], CabinClass.values()[2], sd));
                    flight.setPresentSold(ps);
                    fsss.build(flight);
                } else {
                    Flight flight = new Flight(c.getTime(), fn[j], ac[1]);
                    SeatDistribute sd = new SeatDistribute(ac[1]);
                    sd.randomSeatDistribute(ac[1]);
                    flight.setSeatDistribute(sd);
                    PresentSold ps = new PresentSold(SeatDistribute.countPassengers(ac[1], CabinClass.values()[0], sd),
                            SeatDistribute.countPassengers(ac[1], CabinClass.values()[1], sd),
                            SeatDistribute.countPassengers(ac[1], CabinClass.values()[2], sd));
                    flight.setPresentSold(ps);
                    fsss.build(flight);
                }
            }
        }

        // 測randomSeatDistribute
//        SeatDistribute sd = new SeatDistribute();
//        sd.randomSeatDistribute(Aircraft.A330);
//        System.out.println("sd = " + sd);

        // 測get
//        Flight fss = fsss.search("20161209JZ191");
//        System.out.println("fss = " + fss);
//        System.out.println("fss.getId() = " + fss.getId());
//        System.out.println("fss.getTakeOffDate() = " + fss.getTakeOffDate());
//        System.out.println("fss.getFlightRoute() = " + fss.getFlightRoute());
//        System.out.println("fss.getType() = " + fss.getType().name());
//        System.out.println("fss.getType() = " + fss.getType());
//        System.out.println("fss.getPresentSold() = " + fss.getPresentSold());
//        System.out.println("fss.getPresentAvailable() = " + fss.getPresentAvailable());
//        System.out.println("fss.getSeatDistribute() = " + fss.getSeatDistribute());        
//        SeatDistribute sdSelecting = fss.getSeatDistribute();
//        for (int i = 0; i < SeatDistribute.getColName().length; i++) {
//            System.out.println(i + "= " + sdSelecting.getColBinStr(SeatDistribute.getColName()[i]));
//        }
//        System.out.println("fss.getSeatDistribute() " + SeatDistribute.getColName()[0] + "31 = " + SeatDistribute.getSeatStatusIsAvailable(fss.getSeatDistribute(), SeatDistribute.getColName()[0], 31));
        // 測update
//        PresentSold ps = new PresentSold(6, 12, 231);
//        fss.setPresentSold(ps);
//        fsss.updateFlightPresentSold(fss);
//        Flight fssUpdated = fsss.search("20161201JZ191");
//        System.out.println("fssUpdated.getPresentSold() = " + fssUpdated.getPresentSold());
//        System.out.println("fssUpdated.getPresentAvailable() = " + fssUpdated.getPresentAvailable());
        // 測getAll
//        List<Flight> list = new ArrayList<>(fsss.searchAll());
//        for (Flight fss : list) {
//            System.out.println("");
//            System.out.println(fss.getId() + ".data: ");
//            System.out.println(fss.getId() + ".getPresentSold() = " + fss.getPresentSold());
//            System.out.println(fss.getId() + ".getPresentAvailable()" + fss.getPresentAvailable());
//            System.out.println(fss.getId() + ".getSeatDistribute() = " + fss.getSeatDistribute());
//        }
//        Date date = sdfDateOnly.parse("2020/10/10");
//        Flight f = new Flight(date,FlightRoute.JZ122,Aircraft.B777);
//        System.out.println("list.get(3) = " + list.get(3));
//        list.set(3, f);
//        System.out.println("list.get(3) = " + list.get(3));
//         測seatsSelected
//        Flight fss = fsss.search("20161108JZ191");
//        System.out.println("fss = " + fss);
//        System.out.println("fss.getId() = " + fss.getId());
//        System.out.println("fss.getTakeOffDate() = " + fss.getTakeOffDate());
//        System.out.println("fss.getFlightRoute() = " + fss.getFlightRoute());
//        System.out.println("fss.getType() = " + fss.getType().name());
//        System.out.println("fss.getType() = " + fss.getType());
//        System.out.println("fss.getPresentSold() = " + fss.getPresentSold());
//        System.out.println("fss.getPresentAvailable() = " + fss.getPresentAvailable());
//        System.out.println("fss.getSeatDistribute() = " + fss.getSeatDistribute());
//
//        SeatDistribute sdStatus = fss.getSeatDistribute();
//        for (int i = 0; i < SeatDistribute.getColName().length; i++) {
//            System.out.println(i + "= " + sdStatus.getColBinStr(SeatDistribute.getColName()[i]));
//        }
//        SeatDistribute sdSelecting = new SeatDistribute(fss.getType());
////        sdSelecting.setColumnE("0000000000000010000000000000000");
////        sdSelecting.setColumnF("0000000000000000000000000000000");
////        sdSelecting.setColumnK("0111110110011110111110111111000");
////        sdSelecting.setColumnA("0111110011111100011100000111000");        
//
//        fss.setSeatDistribute(sdSelecting);
//        fsss.seatsSelected(fss);
//
//        Flight fssSelected = fsss.search("20161108JZ191");
//        System.out.println("fssSelected = " + fssSelected);
//        System.out.println("fssSelected.getId() = " + fssSelected.getId());
//        System.out.println("fssSelected.getTakeOffDate() = " + fssSelected.getTakeOffDate());
//        System.out.println("fssSelected.getFlightRoute() = " + fssSelected.getFlightRoute());
//        System.out.println("fssSelected.getType() = " + fssSelected.getType().name());
//        System.out.println("fssSelected.getType() = " + fssSelected.getType());
//        System.out.println("fssSelected.getPresentSold() = " + fssSelected.getPresentSold());
//        System.out.println("fssSelected.getPresentAvailable() = " + fssSelected.getPresentAvailable());
//        System.out.println("fssSelected.getSeatDistribute() = " + fssSelected.getSeatDistribute());
//        SeatDistribute sdSelected = fssSelected.getSeatDistribute();
//        for (int i = 0; i < SeatDistribute.getColName().length; i++) {
//            System.out.println(i + "= " + sdSelected.getColBinStr(SeatDistribute.getColName()[i]));            
//        }
//        for (int i = 0 ; i<CabinClass.values().length;i++){
//            System.out.println(CabinClass.values()[i] +" passengers = " 
//                    + SeatDistribute.countPassengers(fssSelected.getType(), CabinClass.values()[i], fssSelected.getSeatDistribute()));
//        }
    }
}
