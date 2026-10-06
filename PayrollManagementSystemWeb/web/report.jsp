<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.payroll.util.DBConnection" %>
<%
String role = (String)session.getAttribute("role");

if(role==null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
%>
<%
Connection con = DBConnection.getConnection();

// Total Employees
Statement st1 = con.createStatement();
ResultSet emp = st1.executeQuery(
"SELECT COUNT(*) FROM employee");
emp.next();
int totalEmployees = emp.getInt(1);

// Total Payroll
Statement st2 = con.createStatement();
ResultSet pay = st2.executeQuery(
"SELECT SUM(net_salary) FROM salary");
pay.next();
double totalPayroll = pay.getDouble(1);

// Total Departments
Statement st3 = con.createStatement();
ResultSet dept = st3.executeQuery(
"SELECT COUNT(DISTINCT department) FROM employee");
dept.next();
int totalDepartments = dept.getInt(1);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payroll Reports</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="wrapper">

    <!-- Sidebar -->

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

    <!-- Main -->

    <div class="main">

        <h2>Payroll Reports</h2>

        <!-- Summary Cards -->

        <div class="row mt-3">

            <div class="col-md-4">
                <div class="card bg-primary text-white p-3">
                    <h5>Total Employees</h5>
                    <h2><%= totalEmployees %></h2>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card bg-success text-white p-3">
                    <h5>Total Payroll</h5>
                    <h2>₹<%= totalPayroll %></h2>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card bg-warning text-dark p-3">
                    <h5>Departments</h5>
                    <h2><%= totalDepartments %></h2>
                </div>
            </div>

        </div>


        <!-- Search -->

<div class="card p-3 mt-4">

    <h4>Search Report</h4>

    <form method="get">

        <div class="row">

            <div class="col-md-4">
                <input type="month" name="month" class="form-control" required>
            </div>

            <div class="col-md-4">
                <button class="btn btn-primary w-100">
                    Search
                </button>
            </div>

        </div>

    </form>

</div>

        <!-- Report Table -->

        <div class="card p-3 mt-4">

            <h4>Monthly Salary Report</h4>

            <table class="table table-bordered table-hover">

    <thead class="table-dark">

        <tr>
            <th>Employee</th>
            <th>Department</th>
            <th>Month</th>
            <th>Net Salary</th>
        </tr>

    </thead>

    <tbody>

    <%
String month = request.getParameter("month");
PreparedStatement ps;

if(month != null && !month.equals("")){

    String[] p = month.split("-");

    String[] mon = {"Jan","Feb","Mar","Apr","May","Jun",
                    "Jul","Aug","Sep","Oct","Nov","Dec"};

    String dbMonth = mon[Integer.parseInt(p[1])-1] + " " + p[0];

    ps = con.prepareStatement(
    "SELECT e.name,e.department,s.salary_month,s.net_salary FROM employee e JOIN salary s ON e.emp_id=s.emp_id WHERE s.salary_month=?");

    ps.setString(1, dbMonth);

}else{

    ps = con.prepareStatement(
    "SELECT e.name,e.department,s.salary_month,s.net_salary FROM employee e JOIN salary s ON e.emp_id=s.emp_id");

}

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("department")%></td>
<td><%=rs.getString("salary_month")%></td>
<td>&#8377;<%=rs.getDouble("net_salary")%></td>
</tr>

<% } %>



    </tbody>

</table>

            <div class="text-end">

                <button class="btn btn-success" onclick="window.print()">

                    Print Report

                </button>

            </div>

        </div>

    </div>

</div>

</body>
</html>