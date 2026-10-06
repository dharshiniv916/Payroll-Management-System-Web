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

if(con == null){
    out.println("<h3>Database connection failed</h3>");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salary Management</title>

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

        <h2>Salary Management</h2>

        <div class="card p-4 mt-3">

            <h4>Generate Salary</h4>
            <form action="SalaryServlet" method="post">

            <div class="row">

                <div class="col-md-6 mb-3">
                    <label>Employee</label>
                    <select name="empId" class="form-control">

<%
Statement empSt = con.createStatement();
ResultSet empRs = empSt.executeQuery("SELECT * FROM employee");

while(empRs.next()){
%>

<option value="<%=empRs.getInt("emp_id")%>">
<%=empRs.getString("emp_code")%> -
<%=empRs.getString("name")%>
</option>

<%
}
%>

</select>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Salary Month</label>
                    <input type="month" name="month" class="form-control" required="">
                </div>

                <div class="col-md-6 mb-3">
                    <label>Overtime Hours</label>
                    <input type="number" name="overtime" class="form-control" value="0"
           min="0"
           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Bonus</label>
                    <input type="number" name="bonus" class="form-control" value="0" min="0" required8>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Gross Salary</label>
                    <input type="text" class="form-control" value="Calculated Automatically" readonly>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Net Salary</label>
                    <input type="text" class="form-control" value="Calculated Automatically" readonly>
                </div>

            </div>

            <button class="btn btn-success">
                Generate Salary
            </button>
            </form>
        </div>

        <!-- Salary Table -->

        <div class="card p-3 mt-4">

            <h4>Salary Records</h4>
            
            

            <table class="table table-bordered table-hover">

                <thead class="table-dark">

                    <tr>
                        <th>Employee</th>
                        <th>Month</th>
                        <th>Bonus</th>
                        <th>Gross</th>
                        <th>Net</th>
                    </tr>

                </thead>

               <tbody>

<%
Statement st = con.createStatement();

ResultSet rs = st.executeQuery(
"SELECT s.*, e.name FROM salary s JOIN employee e ON s.emp_id = e.emp_id");

while(rs.next()){
%>

<tr>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("salary_month") %></td>
    <td>&#8377;<%= rs.getDouble("bonus") %></td>
    <td>&#8377;<%= rs.getDouble("gross_salary") %></td>
    <td>&#8377;<%= rs.getDouble("net_salary") %></td>
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