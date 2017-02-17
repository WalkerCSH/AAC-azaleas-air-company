/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.test;

import aac.domain.TicketOrder;
import aac.domain.dataCategory.AACException;
import aac.model.dao.TicketOrderDAO;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author Walker
 */
public class TestTicketOrderDAO {

    public static void main(String[] args) throws AACException {
        TicketOrderDAO dao = new TicketOrderDAO();
        SimpleDateFormat fullDate = new SimpleDateFormat();

        // 測insert
        // 測get       
        TicketOrder to = dao.get(5);
        System.out.println("to = " + to);
        System.out.println("to.getOrderTime() = " + to.getOrderTime());
        System.out.println("new Date() = " + new Date());
        Calendar c = new GregorianCalendar();
        System.out.println("c.getTime() = " + c.getTime());
        // 測update

        // 測delete
    }
}
