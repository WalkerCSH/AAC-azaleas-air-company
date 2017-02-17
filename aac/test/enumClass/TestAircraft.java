/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test.Enum;

import aac.domain.dataCategory.Aircraft;
import java.text.ParseException;

/**
 *
 * @author Walker
 */
public class TestAircraft {

    public static void main(String[] args) throws ParseException {

        System.out.println("Aircraft.getA330()= " + Aircraft.getA330());
        System.out.println("Aircraft.valueOf('A330')= " + Aircraft.valueOf("A330"));
        System.out.println("Aircraft.A330.getCarryCapacity() = " + Aircraft.A330.getCarryCapacity());
        System.out.println("Aircraft.getA330().getCarryCapacity() = " + Aircraft.getA330().getCarryCapacity());
        
        System.out.println("");
        System.out.println("========");
        System.out.println("");
        System.out.println("Aircraft.getB777()= " + Aircraft.getB777());
        System.out.println("Aircraft.B777.getGloryCapacity() = " + Aircraft.B777.getGloryCapacity());
        System.out.println("Aircraft.getB777().getGloryCapacity() = " + Aircraft.getB777().getHappyCapacity());       

    }
}
