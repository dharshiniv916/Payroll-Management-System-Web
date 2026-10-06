package com.payroll.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.payroll.util.DBConnection;

public class DeleteEmployeeServlet extends HttpServlet{

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        int id = Integer.parseInt(request.getParameter("id"));

        try{

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement("DELETE FROM employee WHERE emp_id=?");

            ps.setInt(1,id);

            ps.executeUpdate();

        }catch(Exception e){

            e.printStackTrace();

        }

        response.sendRedirect("employee.jsp");

    }

}