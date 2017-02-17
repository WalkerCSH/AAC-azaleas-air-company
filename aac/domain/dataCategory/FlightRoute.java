/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain.dataCategory;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Walker
 */
public enum FlightRoute {

    JZ121(Airport.HND, Airport.TSA, "19:00", "21:20"), // 約3hr20min -1hr
    JZ122(Airport.TSA, Airport.HND, "07:20", "11:40"), // 約3hr20min +1hr
    JZ151(Airport.TSA, Airport.SIN, "07:30", "11:30"), // 約4hr20min
    JZ152(Airport.SIN, Airport.TSA, "17:40", "22:00"), // 約4hr20min
    JZ191(Airport.TSA, Airport.BKK, "08:30", "11:30"), // 約4hr00min -1hr
    JZ192(Airport.BKK, Airport.TSA, "17:20", "22:20"); // 約4hr00min +1hr

    private final Airport takeoffAirport;
    private final Airport landingAirport;
    private final String takeoffScheduleTime;
    private final String landingScheduleTime;

    private FlightRoute(Airport takeoff, Airport landing, String takeoffScheduleTime, String landingScheduleTime) {
        this.takeoffAirport = takeoff;
        this.landingAirport = landing;
        this.takeoffScheduleTime = takeoffScheduleTime;
        this.landingScheduleTime = landingScheduleTime;
    }

    public static FlightRoute matchFlightRouteName(int depart, int destin) {
        FlightRoute correct = null;
        if ((depart < Airport.values().length && depart >= 0) && (destin < Airport.values().length && destin >= 0)) {
            for (FlightRoute fr : FlightRoute.values()) {
                if (fr.getTakeoffAirport().name().equals(Airport.values()[depart].name())
                        && fr.getLandingAirport().name().equals(Airport.values()[destin].name())) {
                    correct = fr;
                }
            }
        }
        if (correct == null) {
            System.out.println("尋找失敗 depart = " + depart + " ,destin =  " + destin);
        }
        return correct;
    }

    public static FlightRoute getJZ121() {
        return JZ121;
    }

    public static FlightRoute getJZ122() {
        return JZ122;
    }

    public static FlightRoute getJZ151() {
        return JZ151;
    }

    public static FlightRoute getJZ152() {
        return JZ152;
    }

    public static FlightRoute getJZ191() {
        return JZ191;
    }

    public static FlightRoute getJZ192() {
        return JZ192;
    }

    public Airport getTakeoffAirport() {
        return takeoffAirport;
    }

    public Airport getLandingAirport() {
        return landingAirport;
    }

    public String getTakeoffScheduleTime() {
        return takeoffScheduleTime;
    }

    public String getLandingScheduleTime() {
        return landingScheduleTime;
    }

    @Override
    public String toString() {
        return "FlightNumber{" + "takeoff=" + takeoffAirport + ", landing=" + landingAirport + '}';
    }

}
