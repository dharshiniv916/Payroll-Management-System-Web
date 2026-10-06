<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String role = (String) session.getAttribute("role");

if(role != null){
    if(role.equals("admin")){
        response.sendRedirect("dashboard.jsp");
        return;
    }else if(role.equals("employee")){
        response.sendRedirect("employee_dashboard.jsp");
        return;
    }
}
%>

<%
String msg=request.getParameter("logout");

if("success".equals(msg)){
%>

<div class="alert alert-success">
Logged out successfully!
</div>

<%
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payroll Management System</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<div class="login-container">

    <div class="login-card">

        <h2>Payroll Management</h2>
        <p class="sub">Administrator Login</p>

        <form action="LoginServlet" method="post">

<label>Login As</label>
<select name="role" class="form-control" required>
    <option value="admin">Admin</option>
    <option value="employee">Employee</option>
</select>

<label class="mt-3">Username</label>
<input type="text" name="username" class="form-control" required>

<label class="mt-3">Password</label>
<input type="password" name="password" class="form-control" required>

<button class="btn btn-primary w-100 mt-4">
    Login
</button>

</form>

    </div>

</div>

</body>
</html>