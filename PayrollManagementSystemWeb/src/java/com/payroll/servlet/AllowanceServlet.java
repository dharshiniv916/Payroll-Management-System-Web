package com.payroll.servlet;

import com.payroll.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AllowanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int empId = Integer.parseInt(request.getParameter("empId"));
            double hra = Double.parseDouble(request.getParameter("hra"));
            double da = Double.parseDouble(request.getParameter("da"));
            double travel = Double.parseDouble(request.getParameter("travel"));
            double medical = Double.parseDouble(request.getParameter("medical"));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO allowance(emp_id,hra,da,travel,medical) VALUES(?,?,?,?,?)");

            ps.setInt(1, empId);
            ps.setDouble(2, hra);
            ps.setDouble(3, da);
            ps.setDouble(4, travel);
            ps.setDouble(5, medical);

            ps.executeUpdate();

            response.sendRedirect("allowance.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Allowance Error: " + e);
        }
    }
}