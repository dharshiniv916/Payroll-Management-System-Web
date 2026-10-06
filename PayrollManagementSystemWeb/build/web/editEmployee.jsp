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
int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM employee WHERE emp_id=?");

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

rs.next();
%>

<!DOCTYPE html>

<html>

<head>

<title>Edit Employee</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="container mt-5">

<h2>Edit Employee</h2>

<form action="UpdateEmployeeServlet" method="post">

<input type="hidden" name="id"
value="<%=rs.getInt("emp_id")%>">

<label>Employee Code</label>

<input type="text" name="code"
class="form-control"
value="<%=rs.getString("emp_code")%>">

<label>Name</label>

<input type="text" name="name"
class="form-control"
value="<%=rs.getString("name")%>">

<label>Department</label>

<input type="text" name="department"
class="form-control"
value="<%=rs.getString("department")%>">

<label>Designation</label>

<input type="text" name="designation"
class="form-control"
value="<%=rs.getString("designation")%>">

<label>Email</label>

<input type="email" name="email"
class="form-control"
value="<%=rs.getString("email")%>">

<label>Phone</label>

<input type="text" name="phone"
class="form-control"
value="<%=rs.getString("phone")%>">

<label>Salary</label>

<input type="number" name="salary"
class="form-control"
value="₹<%=rs.getDouble("basic_salary")%>">

<br>

<button class="btn btn-success">
Update Employee
</button>

</form>

</body>

</html>