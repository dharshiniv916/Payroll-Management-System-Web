<%@ page contentType="text/html;charset=UTF-8"%>

<%
String role=(String)session.getAttribute("role");

if(role==null || !role.equals("employee")){
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Settings</title>

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

<div class="card p-4">

<h3>Change Password</h3>

<form action="EmployeePasswordServlet" method="post">

<label>Current Password</label>
<input type="password" name="old" class="form-control" required>

<label class="mt-3">New Password</label>
<input type="password" name="new" class="form-control" required>

<button class="btn btn-primary mt-3">
Update Password
</button>

</form>

</div>

</div>

</div>

</body>
</html>