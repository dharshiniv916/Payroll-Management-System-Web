package com.payroll.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.payroll.dao.EmployeeDAO;

public class EmployeeServlet extends HttpServlet{

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,IOException{

        String code=request.getParameter("code");
        String name=request.getParameter("name");
        String gender=request.getParameter("gender");
        String dept=request.getParameter("department");
        String desig=request.getParameter("designation");
        String email=request.getParameter("email");
        String phone=request.getParameter("phone");
        double salary=Double.parseDouble(request.getParameter("salary"));
        String date=request.getParameter("date");

        EmployeeDAO dao=new EmployeeDAO();

        if(dao.saveEmployee(code,name,gender,dept,desig,email,phone,salary,date)){

            response.sendRedirect("employee.jsp");

        }else{

            response.getWriter().println("Insert Failed");

        }

    }

}