package com.cinema.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class responsible for creating JDBC connections to the Cinema
 * database.
 * The values are intentionally configurable through environment variables to
 * make the
 * application easy to deploy on different environments without recompilation.
 */
public final class DBConnection {

    private static final String URL = System.getenv().getOrDefault("CINEMA_DB_URL",
            "jdbc:mysql://localhost:3306/cinema");
    private static final String USER = System.getenv().getOrDefault("CINEMA_DB_USER", "root");
    private static final String PASSWORD = System.getenv().getOrDefault("CINEMA_DB_PASSWORD", "");

    private DBConnection() {
    }

    /**
     * Opens and returns a new JDBC connection using the configured credentials.
     *
     * @return an active {@link Connection}
     * @throws SQLException if the driver cannot establish a connection
     */
    public static Connection getConnection() throws SQLException {
        // Do not log credentials. Use environment variables to configure DB access.
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
