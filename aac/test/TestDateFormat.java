/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test;

import aac.domain.dataCategory.FlightRoute;
import aac.domain.TicketOrder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Walker
 */
public class TestDateFormat {

    public static void main(String[] args) throws ParseException {
        String test = "2016/10/07 20:50:30";
        SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy/MM/dd");
        SimpleDateFormat sdfWeekdayName = new SimpleDateFormat("E");
        Date takeOffDate = sdfDateOnly.parse(test);
//        System.out.println("sdf.format(takeOffDate)= " + sdfDateOnly.format(takeOffDate));
//        System.out.println("sdfWeekdayName.format(takeOffDate) = " + sdfWeekdayName.format(takeOffDate));
        String takeOffDateStr = sdfDateOnly.format(takeOffDate).replace("/", "");
//        System.out.println(takeOffDateStr);

        Calendar c = Calendar.getInstance();
        c.setTime(takeOffDate);
//        System.out.println("c = " + c.get(Calendar.WEEK_OF_YEAR));
        System.out.println("c. Weekday = " + c.get(Calendar.DAY_OF_WEEK));
        System.out.println(sdfWeekdayName.format(c.getTime()));
        System.out.println("");
//        System.out.println("c.Mon of week = " + c.get(Calendar.DAY_OF_WEEK));

        while (!(c.get(Calendar.DAY_OF_WEEK) == 1)) {
            c.add(Calendar.DATE, -1);
            System.out.println(sdfDateOnly.format(c.getTime()));
            System.out.println(sdfWeekdayName.format(c.getTime()));
        }
        

//        
//        System.out.println("");
//        System.out.println("**************");
//        System.out.println("");
//        
//        String test2 = "20:50:30";
//        SimpleDateFormat sdfTimeOnly = new SimpleDateFormat("HH:mm:ss");
//        Date takeOffTime = sdfTimeOnly.parse(test2);
//        System.out.println("sdfTimeOnly.format(takeOffTime) " + sdfTimeOnly.format(takeOffTime));
        // 參考資料 https://dotblogs.com.tw/superlm102/2013/01/10/87119
        // 參考資料 http://www.ewdna.com/2009/01/javadatecalendardateformatsimpledatefor.html
        // 參考資料 http://fanli7.net/a/shujuku/20120705/181124.html
        // 參考資料 http://www.coctec.com/docs/java/show-post-60331.html
        
//        String rand = TicketOrder.generateOrderNumber();
//        System.out.println("rand = " + rand);
//        FlightRoute correct = FlightRoute.matchFlightRouteName(0, 2);
//        if (correct != null) {
//            System.out.println("correct = " + correct.name());
//            System.out.println("correct = " + correct);
//        }
    }
}
