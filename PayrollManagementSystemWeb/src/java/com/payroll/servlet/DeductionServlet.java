package com.payroll.servlet;

import com.payroll.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DeductionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int empId = Integer.parseInt(request.getParameter("empId"));
            double pf = Double.parseDouble(request.getParameter("pf"));
            double tax = Double.parseDouble(request.getParameter("tax"));
            double insurance = Double.parseDouble(request.getParameter("insurance"));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO deduction(emp_id,pf,tax,insurance) VALUES(?,?,?,?)");

            ps.setInt(1, empId);
            ps.setDouble(2, pf);
            ps.setDouble(3, tax);
            ps.setDouble(4, insurance);

            ps.executeUpdate();

            response.sendRedirect("deduction.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Deduction Error : " + e);
        }
    }
}