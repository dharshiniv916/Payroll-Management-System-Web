package com.payroll.servlet;

import com.payroll.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class EmployeePasswordServlet extends HttpServlet {

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
                "SELECT * FROM employee_login WHERE username=? AND password=?");

            check.setString(1, user);
            check.setString(2, oldPass);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {

                PreparedStatement update = con.prepareStatement(
                    "UPDATE employee_login SET password=? WHERE username=?");

                update.setString(1, newPass);
                update.setString(2, user);

                update.executeUpdate();

                response.sendRedirect("employee_settings.jsp");

            } else {

                response.getWriter().println("Current Password is Incorrect");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}