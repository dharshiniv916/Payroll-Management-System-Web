package com.payroll.servlet;

import com.payroll.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class AdminPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String user = (String) request.getSession().getAttribute("user");

        String oldPass = request.getParameter("old");
        String newPass = request.getParameter("new");

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM admin WHERE username=? AND password=?");

            check.setString(1, user);
            check.setString(2, oldPass);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {

                PreparedStatement update = con.prepareStatement(
                    "UPDATE admin SET password=? WHERE username=?");

                update.setString(1, newPass);
                update.setString(2, user);

                update.executeUpdate();

                response.sendRedirect("settings.jsp?msg=success");

            } else {

                response.sendRedirect("settings.jsp?msg=wrong");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}