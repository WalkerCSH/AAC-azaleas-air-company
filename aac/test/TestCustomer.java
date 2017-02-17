/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test;

import aac.domain.Customer;
import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.CreditCard;
import aac.domain.dataCategory.Gender;
import aac.domain.dataCategory.PassengerType;
import aac.domain.Passenger;
import aac.domain.dataCategory.Country;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Walker
 */
public class TestCustomer {

    public static void main(String[] args) throws ParseException, AACException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        Date bd = sdf.parse("2000/01/02");
        Date exd = sdf.parse("2021/05/30");                
        Passenger p = new Passenger(PassengerType.ADULT, "ANDY", "WEI", Gender.values()[1] ,bd,Country.JPN,Country.JPN,"2314887760",Country.JPN,exd);
        System.out.println("p.getFirstName = " + p.getFirstName());
        System.out.println("p.getLastName = " + p.getLastName());
        System.out.println("p.getGender = " + p.getGender());
        System.out.println("p.getBirthday = " + sdf.format(p.getBirthday()));
        System.out.println("p.getResidence = " + p.getResidence());
        System.out.println("p.getNation = " + p.getNation());
        System.out.println("p.getPassportNumber = " + p.getPassportNumber());
        System.out.println("p.getPassportIssuePlace = " + p.getPassportIssuePlace());
        System.out.println("p.getPassportExpiryDate = " + sdf.format(p.getPassportExpiryDate()));
        System.out.println();
        
        Passenger p2 = new Customer(p);
        Customer c = (Customer)p2;
        c.setEmail("andywei@gmail.com");        
        c.setMobile("0880012476");
        c.setPassportNumber("66548712354");
        c.setCardNumber("123456780123");
        c.setCardCCV("123");
//        c.setCreditCard(CreditCard.JCB);
        
        System.out.println("c.getFirstName = " + c.getFirstName());
        System.out.println("c.getLastName = " + c.getLastName());
        System.out.println("c.getGender = " + c.getGender());
        System.out.println("c.getBirthday = " + sdf.format(c.getBirthday()));
        System.out.println("c.getResidence = " + c.getResidence());
        System.out.println("c.getNation = " + c.getNation());
        System.out.println("c.getPassportNumber = " + c.getPassportNumber());
        System.out.println("c.getPassportIssuePlace = " + c.getPassportIssuePlace());
        System.out.println("c.getPassportExpiryDate = " + sdf.format(c.getPassportExpiryDate()));
        System.out.println("c.getEmail = " + c.getEmail());        
        System.out.println("c.getMobile = " + c.getMobile());
        System.out.println("c.getCardNumber = " + c.getCardNumber());
        System.out.println("c.getCardCCV = " + c.getCardCCV());
//        System.out.println("c.getCreditCard = " + c.getCreditCard());
        
        System.out.println("p.getPassportNumber = " + p.getPassportNumber());
    }
}
