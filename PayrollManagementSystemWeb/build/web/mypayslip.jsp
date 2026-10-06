<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.payroll.util.DBConnection"%>

<%
String role=(String)session.getAttribute("role");

if(role==null || !role.equals("employee")){
    response.sendRedirect("login.jsp");
    return;
}

int empId=(Integer)session.getAttribute("empId");

Connection con=DBConnection.getConnection();

PreparedStatement emp=con.prepareStatement(
"SELECT * FROM employee WHERE emp_id=?");
emp.setInt(1,empId);
ResultSet e=emp.executeQuery();
e.next();

PreparedStatement al=con.prepareStatement(
"SELECT * FROM allowance WHERE emp_id=?");
al.setInt(1,empId);
ResultSet a=al.executeQuery();
a.next();

PreparedStatement de=con.prepareStatement(
"SELECT * FROM deduction WHERE emp_id=?");
de.setInt(1,empId);
ResultSet d=de.executeQuery();
d.next();

PreparedStatement sa=con.prepareStatement(
"SELECT * FROM salary WHERE emp_id=? ORDER BY salary_id DESC LIMIT 1");
sa.setInt(1,empId);
ResultSet s=sa.executeQuery();
s.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Payslip</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="wrapper">

<div class="sidebar">
<h3>Employee</h3>

<a href="employee_dashboard.jsp">Dashboard</a>
<a href="myprofile.jsp">My Profile</a>
<a href="mypayslip.jsp">My Payslip</a>
<a href="settings.jsp">Settings</a>
<a href="LogoutServlet">Logout</a>
</div>

<div class="main">

<h2>My Salary Payslip</h2>

<div class="card p-4 mt-3">

<div class="text-center">

<h3>ABC TECHNOLOGIES</h3>

<p>Employee Salary Slip</p>

<hr>

</div>

<div class="row">

<div class="col-md-6">
<b>Name :</b> <%=e.getString("name")%><br>
<b>Department :</b> <%=e.getString("department")%><br>
<b>Designation :</b> <%=e.getString("designation")%>
</div>

<div class="col-md-6 text-end">
<b>Employee ID :</b> <%=e.getString("emp_code")%><br>
<b>Month :</b> <%=s.getString("salary_month")%>
</div>

</div>

<hr>

<table class="table table-bordered">

<tr><td>Basic Salary</td><td>&#8377;<%=e.getDouble("basic_salary")%></td></tr>

<tr><td>HRA</td><td>&#8377;<%=a.getDouble("hra")%></td></tr>

<tr><td>DA</td><td>&#8377;<%=a.getDouble("da")%></td></tr>

<tr><td>Travel</td><td>&#8377;<%=a.getDouble("travel")%></td></tr>

<tr><td>Medical</td><td>&#8377;<%=a.getDouble("medical")%></td></tr>

<tr><td>Bonus</td><td>&#8377;<%=s.getDouble("bonus")%></td></tr>

<tr><td>PF</td><td class="text-danger">- &#8377;<%=d.getDouble("pf")%></td></tr>

<tr><td>Tax</td><td class="text-danger">- &#8377;<%=d.getDouble("tax")%></td></tr>

<tr><td>Insurance</td><td class="text-danger">- &#8377;<%=d.getDouble("insurance")%></td></tr>

<tr class="table-success">
<th>Net Salary</th>
<th>&#8377;<%=s.getDouble("net_salary")%></th>
</tr>

</table>

<div class="text-center mt-3">
<button class="btn btn-primary" onclick="window.print()">
Print Payslip
</button>
</div>

</div>

</div>

</div>

</body>
</html>