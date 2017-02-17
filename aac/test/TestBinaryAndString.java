/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test;

import aac.domain.dataCategory.Aircraft;
import aac.domain.dataCategory.FlightRoute;
import aac.domain.Flight;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Walker
 */
public class TestBinaryAndString {

    public static void main(String[] args) throws ParseException {
        StringBuilder one = new StringBuilder();
        for (int i=1 ; i <=5;i++){
            one.append(i);
        }
        System.out.println("one = " + one);
        StringBuilder two = new StringBuilder(one); 
        System.out.println("two = " + two);
               
        while(one.length()<10){
            one.append('0');
        }
        System.out.println("one = " + one);
        
        two.reverse(); 
        while(two.length()<10){
            two.append('0');
        }
        two.reverse();
        System.out.println("two = " + two);
        //        int bin10 = 0b1111111111111111111111111;
//        String bin10Str = "1111111111111111111111111";
//        System.out.println("bin10 = " + bin10);
//        System.out.println(Integer.parseInt(bin10Str,2));
//        int bin10int = Integer.parseInt(bin10Str,2);
//        System.out.println("Integer.toBinaryString(bin10int) = " + Integer.toBinaryString(bin10int));
        
    }
}
