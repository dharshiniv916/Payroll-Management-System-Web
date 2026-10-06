<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.payroll.util.DBConnection"%>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("employee")){
    response.sendRedirect("login.jsp");
    return;
}

int empId=(Integer)session.getAttribute("empId");
%>
<%

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
<title>Employee Dashboard</title>

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

<h2>Welcome, <%=rs.getString("name")%></h2>

<div class="row mt-4">

<div class="col-md-4">
<div class="card bg-primary text-white p-3">
<h5>Department</h5>
<h3><%=rs.getString("department")%></h3>
</div>
</div>

<div class="col-md-4">
<div class="card bg-success text-white p-3">
<h5>Designation</h5>
<h3><%=rs.getString("designation")%></h3>
</div>
</div>

<div class="col-md-4">
<div class="card bg-warning p-3">
<h5>Basic Salary</h5>
<h3>&#8377;<%=rs.getDouble("basic_salary")%></h3>
</div>
</div>

</div>

</div>

</div>

</body>
</html>