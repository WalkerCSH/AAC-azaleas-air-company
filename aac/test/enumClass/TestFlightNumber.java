/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test.Enum;

import aac.domain.dataCategory.FlightRoute;
import java.text.ParseException;
import java.util.Arrays;

/**
 *
 * @author Walker
 */
public class TestFlightNumber {

    public static void main(String[] args) throws ParseException {
        System.out.println("Arrays.toString(FlightNumber.values())= " + Arrays.toString(FlightRoute.values()));
        System.out.println("FlightNumber.JZ121= " + FlightRoute.JZ121);
        System.out.println("FlightNumber.getJZ122()= " + FlightRoute.getJZ122());

        System.out.println("");
        System.out.println("");

        System.out.println("FlightNumber.JZ121.getDeclaringClass()= " + FlightRoute.JZ121.getDeclaringClass());
        System.out.println("FlightNumber.JZ121.getClass()= " + FlightRoute.JZ121.getClass());

        System.out.println("");
        System.out.println("");

        System.out.println("FlightNumber.getJZ122().name()= " + FlightRoute.getJZ122().name());
        System.out.println("FlightNumber.JZ192.getTakeoff()= " + FlightRoute.JZ192.getTakeoffAirport());
        System.out.println("FlightNumber.JZ191.getLanding()= " + FlightRoute.JZ191.getLandingAirport());        
        System.out.println("FlightNumber.JZ151.getTakeoffAirport().name()= " + FlightRoute.JZ151.getTakeoffAirport().name());
        System.out.println("FlightNumber.JZ151.getLandingAirport().name()= " + FlightRoute.JZ151.getLandingAirport().name());        
        System.out.println("FlightNumber.JZ151.getTakeoffScheduleTime()= " + FlightRoute.JZ151.getTakeoffScheduleTime());
        System.out.println("FlightNumber.JZ151.getLandingScheduleTime()= " + FlightRoute.JZ151.getLandingScheduleTime());
        
    }
}
