package model;
import java.sql.*;

public class Database {
    private static final String SERVER_URL = "jdbc:mysql://localhost:3306/?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_NAME = "employees";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
           
            try (Connection serverConn = DriverManager.getConnection(SERVER_URL, USER, PASSWORD);
                 Statement st = serverConn.createStatement()) {
                st.executeUpdate("CREATE DATABASE IF NOT EXISTS " + DB_NAME + " CHARACTER SET utf8mb4");
            }

            String finalUrl = "jdbc:mysql://localhost:3306/" + DB_NAME + "?useSSL=false&useUnicode=true&characterEncoding=UTF-8";
            return DriverManager.getConnection(finalUrl, USER, PASSWORD);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Lỗi: " + e.getMessage());
        }
    }
}