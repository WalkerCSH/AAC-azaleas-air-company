/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.service;

import aac.model.dao.PassengersDAO;
import aac.domain.dataCategory.AACException;
import aac.domain.Passenger;

/**
 *
 * @author Walker
 */
public class PassengerServices {

    private final PassengersDAO dao = new PassengersDAO();

    /**
     * 提供消費者(Customer)輸入乘客資料相關的商業邏輯
     *
     * @param p:消費者透過Web輸入的乘客資料
     * @throws aac.domain.dataCategory.AACException
     */
    public void create(Passenger p) throws AACException {
        //TODO: replace by JDBC insert....
        dao.insert(p);
        p.setId(dao.getPassengerId());
    }

    public Passenger find(int id) throws AACException {
        return dao.get(id);
    }
}
