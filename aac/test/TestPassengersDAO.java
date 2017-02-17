/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test;

import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.Gender;
import aac.domain.dataCategory.PassengerType;
import aac.domain.Passenger;
import aac.domain.dataCategory.Country;
import aac.model.dao.PassengersDAO;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author Walker
 */
public class TestPassengersDAO {

    public static void main(String[] args) throws AACException {
        PassengersDAO dao = new PassengersDAO();

        // 測insert
        Passenger p1 = new Passenger();
        p1.setPassengerType(PassengerType.ADULT);
        p1.setFirstName("CHX");
        p1.setLastName("LIE");
        p1.setGender(Gender.FEMALE);
        Date birthdateP1 = new GregorianCalendar(2011, 1 - 1, 1).getTime();
        p1.setBirthday(birthdateP1);
        p1.setResidence(Country.ROC);
        p1.setNation(Country.ROC);
        p1.setPassportNumber("1234567890");
        p1.setPassportIssuePlace(Country.ROC);
        p1.setPassportExpiryDate("2022-12-31");
        System.out.println("p1= " + p1);
        dao.insert(p1);
        p1.setId(dao.getPassengerId());
        System.out.println("p1.getId() = " + p1.getId());

        Passenger p2 = new Passenger();
        p2.setPassengerType(PassengerType.CHILD);
        p2.setFirstName("CHX");
        p2.setLastName("LIE");
        p2.setGender(Gender.FEMALE);
        Date birthdateP2 = new GregorianCalendar(2000, 8 - 1, 11).getTime();
        p2.setBirthday(birthdateP2);
        p2.setResidence(Country.JPN);
        p2.setNation(Country.JPN);
        p2.setPassportNumber("0983721324");
        p2.setPassportIssuePlace(Country.JPN);
        p2.setPassportExpiryDate(2030, 12 - 1, 10);
        System.out.println("p2= " + p2);        
        dao.insert(p2);
        p2.setId(dao.getPassengerId());
        System.out.println("p2.getId() = " + p2.getId());

//        Passenger p3 = new Passenger();
//        p3.setPassengerSet(PassengerType.ADULT);
//        p3.setFirstName("PHI");
//        p3.setLastName("WEX");
//        p3.setGender(Gender.MALE);
//        Date birthdateP3 = new GregorianCalendar(2011, 1 - 1, 1).getTime();
//        p3.setBirthday(birthdateP3);
//        p3.setResidence("USA");
//        p3.setNation("USA");
//        p3.setPassportNumber("05547124463");
//        p3.setIssuePlace("USA");
//        p3.setPassportExpiryDate(2023, 12 - 1, 10);
//        System.out.println("p3= " + p3);
//        dao.insert(p3);
//
//        Passenger p4 = new Passenger();
//        p4.setPassengerSet(PassengerType.ADULT);
//        p4.setFirstName("PHI");
//        p4.setLastName("WEX");
//        p4.setGender(Gender.MALE);
//        Date birthdateP3 = new GregorianCalendar(2011, 1 - 1, 1).getTime();
//        p4.setBirthday(birthdateP3);
//        p4.setResidence("USA");
//        p4.setNation("USA");
//        p4.setPassportNumber("05547124463");
//        p4.setIssuePlace("USA");
//        p4.setPassportExpiryDate(2023, 12 - 1, 10);
//        System.out.println("p4= " + p4);
//        dao.insert(p4);


        // 測get
//        int index = 1;
//        Passenger pGet = dao.get(index);
//        System.out.println(pGet);
//        index = 5;
//        pGet = dao.get(index);
//        System.out.println(pGet);
//        index = 5;
//        pGet = dao.get(index);
//        System.out.println(pGet);
//        若查詢健值超出主鍵值範圍 會回傳id=0 各欄位為default 的物件...

        // 測getByName
//        String firstname = "PHI";
//        String lastname = "WEX";
//        System.out.println(dao.getByName(firstname, lastname));

        // 測update
//        注意!!!主鍵值如果被修改 會修改到對應錯誤鍵值的資料...       
//        pUpdate.setId(2);
//        int index = 3;
//        Passenger pUpdate = dao.get(index);
//        System.out.println(pUpdate);
//        pUpdate.setPassengerSet(PassengerType.ADULT);
//        pUpdate.setFirstName("LII");
//        pUpdate.setLastName("CHEN");
//        pUpdate.setGender(Gender.MALE);
//        Date birthdate = new GregorianCalendar(1995, 1 - 1, 1).getTime();
//        pUpdate.setBirthday(birthdate);
//        pUpdate.setResidence("USA");
//        pUpdate.setNation("USA");
//        pUpdate.setPassportNumber("05547124463");
//        pUpdate.setIssuePlace("USA");
//        pUpdate.setPassportExpiryDate(2023, 12 - 1, 10);
//        System.out.println(pUpdate);
//        dao.update(pUpdate);
//        pUpdate = dao.get(index);
//        System.out.println(pUpdate);
        // 測delete
//        int index = 6;
//        Passenger pUpdate = dao.get(index);
//        System.out.println(pUpdate);
//        dao.delete(pUpdate);
//        System.out.println(dao.get(index));
    }
}
