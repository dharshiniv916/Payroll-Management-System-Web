package com.payroll.servlet;

import com.payroll.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class UpdateEmployeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE employee SET emp_code=?, name=?, department=?, designation=?, email=?, phone=?, basic_salary=? WHERE emp_id=?");

            ps.setString(1, request.getParameter("code"));
            ps.setString(2, request.getParameter("name"));
            ps.setString(3, request.getParameter("department"));
            ps.setString(4, request.getParameter("designation"));
            ps.setString(5, request.getParameter("email"));
            ps.setString(6, request.getParameter("phone"));
            ps.setDouble(7, Double.parseDouble(request.getParameter("salary")));
            ps.setInt(8, id);

            ps.executeUpdate();

            response.sendRedirect("employee.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}