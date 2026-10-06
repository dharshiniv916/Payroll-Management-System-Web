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

String idParam = request.getParameter("id");

int empId;

if(idParam == null || idParam.equals("")){
    Statement first = con.createStatement();
    ResultSet r = first.executeQuery(
    "SELECT emp_id FROM employee LIMIT 1");
    r.next();
    empId = r.getInt("emp_id");
}else{
    empId = Integer.parseInt(idParam);
}
PreparedStatement emp = con.prepareStatement(
"SELECT * FROM employee WHERE emp_id=?");
emp.setInt(1, empId);
ResultSet e = emp.executeQuery();
e.next();

PreparedStatement al = con.prepareStatement(
"SELECT * FROM allowance WHERE emp_id=?");
al.setInt(1, empId);
ResultSet a = al.executeQuery();
a.next();

PreparedStatement de = con.prepareStatement(
"SELECT * FROM deduction WHERE emp_id=?");
de.setInt(1, empId);
ResultSet d = de.executeQuery();
d.next();

PreparedStatement sa = con.prepareStatement(
"SELECT * FROM salary WHERE emp_id=? ORDER BY salary_id DESC LIMIT 1");
sa.setInt(1, empId);
ResultSet s = sa.executeQuery();
s.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payslip</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">

<style>
.payslip{
    background:white;
    padding:35px;
    border-radius:10px;
}
</style>

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
    <form method="get" class="row mb-3">

    <div class="col-md-6">

        <select name="id" class="form-control">

            <%
            Statement st = con.createStatement();
            ResultSet list = st.executeQuery(
            "SELECT emp_id, emp_code, name FROM employee");

            while(list.next()){
            %>

            <option value="<%=list.getInt("emp_id")%>"
                <%= (list.getInt("emp_id")==empId) ? "selected" : "" %>>

                <%=list.getString("emp_code")%> -
                <%=list.getString("name")%>

            </option>

            <% } %>

        </select>

    </div>

    <div class="col-md-3">

        <button class="btn btn-primary w-100">
            View Payslip
        </button>

    </div>

</form>

<div class="payslip">

<div class="text-center">

<h2>ABC TECHNOLOGIES</h2>

<p>Payroll Management System</p>

<h4>Salary Payslip</h4>

<hr>

</div>

<div class="row">

<div class="col-md-6">

<b>Employee :</b> <%=e.getString("name")%><br>

<b>Department :</b> <%=e.getString("department")%><br>

<b>Designation :</b> <%=e.getString("designation")%>

</div>

<div class="col-md-6 text-end">

<b>Month :</b> <%=s.getString("salary_month")%><br>

<b>Employee ID :</b> <%=e.getString("emp_code")%>

</div>

</div>

<hr>

<table class="table">

<tr>
<td>Basic Salary</td>
<td class="text-end">&#8377;<%=e.getDouble("basic_salary")%></td>
</tr>

<tr>
<td>HRA</td>
<td class="text-end">&#8377;<%=a.getDouble("hra")%></td>
</tr>

<tr>
<td>DA</td>
<td class="text-end">&#8377;<%=a.getDouble("da")%></td>
</tr>

<tr>
<td>Travel</td>
<td class="text-end">&#8377;<%=a.getDouble("travel")%></td>
</tr>

<tr>
<td>Medical</td>
<td class="text-end">&#8377;<%=a.getDouble("medical")%></td>
</tr>

<tr>
<td>Bonus</td>
<td class="text-end">&#8377;<%=s.getDouble("bonus")%></td>
</tr>

<tr>
<td>PF</td>
<td class="text-end text-danger">- &#8377;<%=d.getDouble("pf")%></td>
</tr>

<tr>
<td>Tax</td>
<td class="text-end text-danger">- &#8377;<%=d.getDouble("tax")%></td>
</tr>

<tr>
<td>Insurance</td>
<td class="text-end text-danger">- &#8377;<%=d.getDouble("insurance")%></td>
</tr>

<tr class="table-success">

<th>Net Salary</th>

<th class="text-end">&#8377;<%=s.getDouble("net_salary")%></th>

</tr>

</table>

<div class="text-center">

<button class="btn btn-primary"
onclick="window.print()">

Print Payslip

</button>

</div>

</div>

</div>

</div>

</body>
</html>