package com.payroll.servlet;

import com.payroll.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            if(role.equals("admin")){

                PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM admin WHERE username=? AND password=?");

                ps.setString(1, username);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if(rs.next()){

                    HttpSession session = request.getSession();

                    session.setAttribute("user", username);
                    session.setAttribute("role", "admin");

                    response.sendRedirect("dashboard.jsp");

                }else{

                    response.sendRedirect("login.jsp");

                }

            }else{

                PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM employee_login WHERE username=? AND password=?");

                ps.setString(1, username);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if(rs.next()){

                    HttpSession session = request.getSession();

                    session.setAttribute("user", username);
                    session.setAttribute("empId", rs.getInt("emp_id"));
                    session.setAttribute("role", "employee");

                    response.sendRedirect("employee_dashboard.jsp");

                }else{

                    response.sendRedirect("login.jsp");

                }

            }

        }catch(Exception e){

            e.printStackTrace();

        }

    }

}