package com.payroll.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con = null;

    public static Connection getConnection() {

        try {

            if (con == null || con.isClosed()) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/payroll_db?useSSL=false&serverTimezone=UTC",
                    "root",
                    "dharshiniv@916"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();   // IMPORTANT
        }

        return con;
    }
}