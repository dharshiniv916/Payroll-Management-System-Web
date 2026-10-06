<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.payroll.util.DBConnection"%>

<%
String role = (String)session.getAttribute("role");

if(role==null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}

String user = (String)session.getAttribute("user");
String msg = request.getParameter("msg");

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM admin WHERE username=?");

ps.setString(1, user);

ResultSet rs = ps.executeQuery();
rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Settings</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="wrapper">

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

<div class="main">

<h2>Account Settings</h2>

<div class="card p-4 mt-3">

<h4>Profile</h4>

<p><b>Name :</b> <%=rs.getString("full_name")%></p>

<p><b>Username :</b> <%=rs.getString("username")%></p>

<hr>

<% if("success".equals(msg)){ %>

<div class="alert alert-success">
Password updated successfully.
</div>

<% } %>

<% if("wrong".equals(msg)){ %>

<div class="alert alert-danger">
Current password is incorrect.
</div>

<% } %>

<h4>Change Password</h4>

<form action="AdminPasswordServlet" method="post">

<label>Current Password</label>

<input type="password"
name="old"
class="form-control"
required>

<label class="mt-3">New Password</label>

<input type="password"
name="new"
class="form-control"
required>

<button class="btn btn-primary mt-3">
Update Password
</button>

</form>

</div>

</div>

</div>

</body>
</html>