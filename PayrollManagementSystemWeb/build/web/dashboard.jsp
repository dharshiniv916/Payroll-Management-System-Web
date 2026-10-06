<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.payroll.util.DBConnection"%>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {
    response.sendRedirect("login.jsp");
    return;
}

String user = (String) session.getAttribute("user");

int employees = 0;
double payroll = 0;
int slips = 0;

Connection con = null;

try {

    con = DBConnection.getConnection();

    if (con == null) {
        throw new Exception("Database connection is NULL");
    }

    // Total Employees
    Statement st1 = con.createStatement();

    ResultSet r1 = st1.executeQuery(
        "SELECT COUNT(*) FROM employee"
    );

    if (r1.next()) {
        employees = r1.getInt(1);
    }

    // Total Payroll
    Statement st2 = con.createStatement();

    ResultSet r2 = st2.executeQuery(
        "SELECT IFNULL(SUM(net_salary),0) FROM salary"
    );

    if (r2.next()) {
        payroll = r2.getDouble(1);
    }

    // Total Payslips
    Statement st3 = con.createStatement();

    ResultSet r3 = st3.executeQuery(
        "SELECT COUNT(*) FROM payslip"
    );

    if (r3.next()) {
        slips = r3.getInt(1);
    }

} catch (Exception e) {

    out.println("<div style='background:#f8d7da;color:#842029;padding:20px;margin:20px;border:1px solid #f5c2c7;'>");
    out.println("<h3>Dashboard Database Error</h3>");
    out.println("<p>" + e.getMessage() + "</p>");
    out.println("</div>");

}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="wrapper">

    <!-- SIDEBAR -->

    <div class="sidebar">

        <h3>Payroll</h3>

        <a href="dashboard.jsp">Dashboard</a>

        <a href="employee.jsp">Employee</a>

        <a href="salary.jsp">Salary</a>

        <a href="allowance.jsp">Allowance</a>

        <a href="deduction.jsp">Deduction</a>

        <a href="payslip.jsp">Payslip</a>

        <a href="report.jsp">Reports</a>

        <a href="settings.jsp">Settings</a>

        <a href="LogoutServlet">Logout</a>

    </div>


    <!-- MAIN -->

    <div class="main">

        <div class="d-flex justify-content-between align-items-center">

            <h2>Admin Dashboard</h2>

            <div>
                Welcome, <b><%= user %></b>
            </div>

        </div>


        <!-- SUMMARY CARDS -->

        <div class="row mt-4">

            <div class="col-md-4">

                <div class="card bg-primary text-white p-3">

                    <h5>Total Employees</h5>

                    <h2><%= employees %></h2>

                </div>

            </div>


            <div class="col-md-4">

                <div class="card bg-success text-white p-3">

                    <h5>Total Payroll</h5>

                    <h2>₹<%= payroll %></h2>

                </div>

            </div>


            <div class="col-md-4">

                <div class="card bg-warning text-dark p-3">

                    <h5>Payslips</h5>

                    <h2><%= slips %></h2>

                </div>

            </div>

        </div>


        <!-- RECENT EMPLOYEES -->

        <div class="card mt-4 p-3">

            <h4>Recent Employees</h4>

            <table class="table table-bordered">

                <tr class="table-dark">

                    <th>ID</th>
                    <th>Name</th>
                    <th>Department</th>

                </tr>

                <%
                try {

                    Statement st = con.createStatement();

                    ResultSet rs = st.executeQuery(
                        "SELECT emp_code,name,department " +
                        "FROM employee " +
                        "ORDER BY emp_id DESC LIMIT 5"
                    );

                    while (rs.next()) {
                %>

                <tr>

                    <td>
                        <%= rs.getString("emp_code") %>
                    </td>

                    <td>
                        <%= rs.getString("name") %>
                    </td>

                    <td>
                        <%= rs.getString("department") %>
                    </td>

                </tr>

                <%
                    }

                } catch (Exception e) {

                    out.println(
                        "<tr><td colspan='3'>Employee data error: "
                        + e.getMessage()
                        + "</td></tr>"
                    );

                }
                %>

            </table>

        </div>

    </div>

</div>

</body>

</html>