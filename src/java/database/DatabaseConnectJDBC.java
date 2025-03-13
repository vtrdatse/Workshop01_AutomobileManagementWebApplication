/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author datvt
 */
public class DatabaseConnectJDBC {

    private static final String HOST_NAME = "localhost:1433";
    private static final String DATABASE_NAME = "MyStock";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123456";
    private static final String URL = String.format("jdbc:sqlserver://%s;databaseName=%s;Encrypt=True;TrustServerCertificate=True", HOST_NAME, DATABASE_NAME);

    public static Connection connect() throws ClassNotFoundException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection connection = null;

        try {
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Database connected successfully!");
        } catch (SQLException exception) {
            System.out.println(exception);
        }

        return connection;
    }
}
