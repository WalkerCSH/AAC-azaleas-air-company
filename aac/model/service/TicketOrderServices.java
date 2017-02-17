/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.service;

import aac.domain.dataCategory.AACException;
import aac.domain.TicketOrder;
import aac.model.dao.TicketOrderDAO;

/**
 *
 * @author Walker
 */
public class TicketOrderServices {

    private final TicketOrderDAO dao = new TicketOrderDAO();

    /**
     * 提供消費者(Customer)輸入乘客資料相關的商業邏輯
     *
     * @param to: 將消費者透過Web輸入的資料統整後 建立的訂單內容
     * @throws aac.domain.dataCategory.AACException
     */
    public void build(TicketOrder to) throws AACException {
        //TODO: replace by JDBC insert....
        dao.insert(to);
        to.setId(dao.getTicketOrderId());
    }

    public TicketOrder findById(int id) throws AACException {
        return dao.get(id);
    }
    
    public TicketOrder findByOrderNumber(String orderNumber) throws AACException {
        return dao.getByOrderNumber(orderNumber);
    }
}
