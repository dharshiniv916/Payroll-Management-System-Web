<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.payroll.util.DBConnection"%>
<%
String role = (String)session.getAttribute("role");

if(role==null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
%>
<%
Connection con = DBConnection.getConnection();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deduction Management</title>

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

<h2>Deduction Management</h2>

<div class="card p-4 mt-3">

<h4>Add Deduction</h4>

<form action="DeductionServlet" method="post">

<div class="row">

<div class="col-md-6 mb-3">
<label>Employee</label>

<select name="empId" class="form-control">

<%
Statement st = con.createStatement();
ResultSet emp = st.executeQuery("SELECT * FROM employee");

while(emp.next()){
%>

<option value="<%=emp.getInt("emp_id")%>">
<%=emp.getString("emp_code")%> - <%=emp.getString("name")%>
</option>

<%
}
%>

</select>

</div>

<div class="col-md-6 mb-3">
<label>PF</label>
<input type="number" name="pf" class="form-control" value="0" required>
</div>

<div class="col-md-6 mb-3">
<label>Tax</label>
<input type="number" name="tax" class="form-control" value="0" required>
</div>

<div class="col-md-6 mb-3">
<label>Insurance</label>
<input type="number" name="insurance" class="form-control" value="0" required>
</div>

</div>

<button class="btn btn-danger">Save Deduction</button>

</form>

</div>

<div class="card p-3 mt-4">

<h4>Deduction List</h4>

<table class="table table-bordered">

<thead class="table-dark">

<tr>
<th>Employee</th>
<th>PF</th>
<th>Tax</th>
<th>Insurance</th>
</tr>

</thead>

<tbody>

<%
PreparedStatement ps = con.prepareStatement(
"SELECT e.name,d.* FROM deduction d JOIN employee e ON d.emp_id=e.emp_id");

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%=rs.getString("name")%></td>
<td>&#8377;<%=rs.getDouble("pf")%></td>
<td>&#8377;<%=rs.getDouble("tax")%></td>
<td>&#8377;<%=rs.getDouble("insurance")%></td>
</tr>

<%
}
%>

</tbody>

</table>

</div>

</div>

</div>

</body>
</html>