/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.model.dao;

import aac.domain.dataCategory.AACException;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Administrator
 */
public class RDBConnection {
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/aac?zeroDateTimeBehavior=convertToNull";
    private static final String USER_ID = "root", PASSWORD = "12345678";

    static Connection getConnection() throws AACException {
        try {
            //1. 載入MySQL JDBC Driver
            Class.forName(DRIVER);
            try {
                //2. 建立連線(Connection)
                Connection connection = DriverManager.getConnection(URL, USER_ID, PASSWORD);                
                //3. 回傳連線(Connection)
                return connection;
            } catch (SQLException ex) {
                Logger.getLogger(RDBConnection.class.getName()).log(Level.SEVERE, "無法建立連線", ex);
                throw new AACException("無法建立連線", ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RDBConnection.class.getName()).log(Level.SEVERE, "無法載入"+DRIVER, ex);
            throw new AACException("無法載入"+DRIVER, ex);
        }
    }
    
    public static void main(String[] args) {
        try (Connection connection = RDBConnection.getConnection();){
            System.out.println(connection.getCatalog());
        } catch (Exception ex) {
            Logger.getLogger(RDBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
