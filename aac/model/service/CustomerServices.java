/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.service;

import aac.domain.Customer;
import aac.model.dao.CustomersDAO;
import aac.domain.dataCategory.AACException;
import aac.domain.Passenger;

/**
 *
 * @author Walker
 */
public class CustomerServices {

    private final CustomersDAO dao = new CustomersDAO();

    /**
     * 提供消費者輸入顧客(Customer)資料相關的商業邏輯
     *
     * @param c:消費者透過Web輸入的顧客資料
     * @throws aac.domain.dataCategory.AACException
     */
    public void create(Customer c) throws AACException {
        //TODO: replace by JDBC insert....
        dao.insert(c);
        c.setId(dao.getCustomerId());
    }

    public Customer find(int id) throws AACException {
        return dao.get(id);
    }
}
