package com.payroll.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.payroll.util.DBConnection;

public class SalaryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int empId = Integer.parseInt(request.getParameter("empId"));

            String m = request.getParameter("month");

            if (m == null || m.isEmpty()) {
                response.getWriter().println("Please select Salary Month");
                return;
            }

            String[] p = m.split("-");

            String[] mon = {"Jan","Feb","Mar","Apr","May","Jun",
                            "Jul","Aug","Sep","Oct","Nov","Dec"};

            String month = mon[Integer.parseInt(p[1]) - 1] + " " + p[0];

            String overtimeStr = request.getParameter("overtime");
String bonusStr = request.getParameter("bonus");

int overtime = (overtimeStr == null || overtimeStr.isEmpty())
        ? 0
        : Integer.parseInt(overtimeStr);

double bonus = (bonusStr == null || bonusStr.isEmpty())
        ? 0
        : Double.parseDouble(bonusStr);
            Connection con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println("Database Connection Failed");
                return;
            }

            double basic = 0, hra = 0, da = 0, travel = 0, medical = 0;
            double pf = 0, tax = 0, insurance = 0;

            PreparedStatement ps1 = con.prepareStatement(
                "SELECT basic_salary FROM employee WHERE emp_id=?");
            ps1.setInt(1, empId);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) basic = rs1.getDouble("basic_salary");

            PreparedStatement ps2 = con.prepareStatement(
                "SELECT * FROM allowance WHERE emp_id=?");
            ps2.setInt(1, empId);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                hra = rs2.getDouble("hra");
                da = rs2.getDouble("da");
                travel = rs2.getDouble("travel");
                medical = rs2.getDouble("medical");
            }

            PreparedStatement ps3 = con.prepareStatement(
                "SELECT * FROM deduction WHERE emp_id=?");
            ps3.setInt(1, empId);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                pf = rs3.getDouble("pf");
                tax = rs3.getDouble("tax");
                insurance = rs3.getDouble("insurance");
            }

            double overtimePay = overtime * 200;
            double gross = basic + hra + da + travel + medical + bonus + overtimePay;
            double net = gross - (pf + tax + insurance);

            PreparedStatement save = con.prepareStatement(
                "INSERT INTO salary(emp_id,salary_month,overtime_hours,bonus,gross_salary,net_salary) VALUES(?,?,?,?,?,?)");

            save.setInt(1, empId);
            save.setString(2, month);
            save.setInt(3, overtime);
            save.setDouble(4, bonus);
            save.setDouble(5, gross);
            save.setDouble(6, net);

            save.executeUpdate();

            response.sendRedirect("salary.jsp");

        } catch (Exception e) {

            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().println("Salary Error:");
            response.getWriter().println(e.toString());

        }
    }
}