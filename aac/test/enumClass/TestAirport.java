/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test.Enum;

import aac.domain.dataCategory.Airport;

/**
 *
 * @author Walker
 */
public class TestAirport {

    public static void main(String[] args) {
        System.out.println("Airport.TPE= " + Airport.TSA);
        System.out.println("Airport.getBKK()= " + Airport.getBKK());
        System.out.println("Airport.NRT= " + Airport.HND);
        System.out.println("Airport.getSIN()= " + Airport.getSIN());
        
        System.out.println("");
        System.out.println("=============");
        System.out.println("");
        
        System.out.println("Airport.SIN.getName()= " + Airport.SIN.getName());
        System.out.println("Airport.BKK.getName()= " + Airport.BKK.getCountry());
        System.out.println("Airport.TPE.getName()= " + Airport.TSA.getCity());
        

    }
}
