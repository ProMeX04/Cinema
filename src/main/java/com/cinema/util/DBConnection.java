package com.cinema.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    private static final String URL = System.getenv().getOrDefault("CINEMA_DB_URL",
            "jdbc:mysql://localhost:3306/cinema");
    private static final String USER = System.getenv().getOrDefault("CINEMA_DB_USER", "root");
    private static final String PASSWORD = System.getenv().getOrDefault("CINEMA_DB_PASSWORD", "");

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
