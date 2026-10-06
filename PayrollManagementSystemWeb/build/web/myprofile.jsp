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

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM employee WHERE emp_id=?");

ps.setInt(1,empId);

ResultSet rs=ps.executeQuery();
rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>

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
<a href="employee_settings.jsp">Settings</a>
<a href="LogoutServlet">Logout</a>

</div>

<div class="main">

<h2>My Profile</h2>

<div class="card p-4 mt-3">

<table class="table">

<tr><th>Employee Code</th><td><%=rs.getString("emp_code")%></td></tr>
<tr><th>Name</th><td><%=rs.getString("name")%></td></tr>
<tr><th>Department</th><td><%=rs.getString("department")%></td></tr>
<tr><th>Designation</th><td><%=rs.getString("designation")%></td></tr>
<tr><th>Email</th><td><%=rs.getString("email")%></td></tr>
<tr><th>Phone</th><td><%=rs.getString("phone")%></td></tr>

</table>

</div>

</div>

</div>

</body>
</html>