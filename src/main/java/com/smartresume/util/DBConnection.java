
package com.smartresume.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            System.getenv().getOrDefault(
                    "SMARTRESUME_DB_URL",
                    "jdbc:mysql://localhost:3306/smartresume"
                    + "?useSSL=false"
                    + "&allowPublicKeyRetrieval=true"
                    + "&serverTimezone=UTC"
            );

    private static final String USER =
            System.getenv().getOrDefault(
                    "SMARTRESUME_DB_USER",
                    "smartresume_app"
            );

    private static final String PASSWORD =
            System.getenv("SMARTRESUME_DB_PASSWORD");

    public static Connection getConnection()
            throws SQLException {

        if (PASSWORD == null || PASSWORD.isBlank()) {
            throw new SQLException(
                    "SMARTRESUME_DB_PASSWORD is not configured."
            );
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "MySQL JDBC Driver not found!", e
            );
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
