/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.service;

import aac.domain.dataCategory.AACException;
import aac.domain.SeatsSelectedSet;
import aac.model.dao.SeatsSelectedSetDAO;

/**
 *
 * @author Walker
 */
public class SeatsSelectedSetServices {

    private final SeatsSelectedSetDAO dao = new SeatsSelectedSetDAO();

    /**
     * 提供消費者(Customer)輸入乘客資料相關的商業邏輯
     *
     * @param sss:消費者透過Web輸入的乘客資料
     * @throws aac.domain.dataCategory.AACException
     */
    public void build(SeatsSelectedSet sss) throws AACException {
        //TODO: replace by JDBC insert....
        dao.insert(sss);
        sss.setId(dao.getSeatsSelectedSetsId());
    }

    public SeatsSelectedSet find(int id) throws AACException {
        return dao.get(id);
    }
}
