/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.service;

import aac.domain.dataCategory.AACException;
import aac.domain.PassengerList;
import aac.model.dao.PassengerListDAO;

/**
 *
 * @author Walker
 */
public class PassengerListServices {

    private final PassengerListDAO dao = new PassengerListDAO();

    /**
     * 提供消費者(Customer)輸入乘客資料相關的商業邏輯
     *
     * @param pl:消費者透過Web輸入的乘客清單資料
     * @throws aac.domain.dataCategory.AACException
     */
    public void build(PassengerList pl) throws AACException {
        //TODO: replace by JDBC insert....
        dao.insert(pl);
        pl.setId(dao.getPassengerListId());
    }

    public PassengerList find(int id) throws AACException {
        return dao.get(id);
    }
}
