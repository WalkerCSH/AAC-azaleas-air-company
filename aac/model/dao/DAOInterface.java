/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;

/**
 *
 * @author Walker
 */
public interface DAOInterface<K, T> {

    abstract void insert(T data) throws AACException;

    void update(T data) throws AACException;

    public abstract void delete(T data) throws AACException;

    public T get(K id) throws AACException;

}
