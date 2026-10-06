
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Management</title>

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

        <h2>Employee Management</h2>

        <!-- Add Employee Form -->

        <div class="card p-4 mt-3">

            <h4>Add Employee</h4>

            <!-- JDBC Form -->

            <form action="EmployeeServlet" method="post">

            <div class="row">

                <div class="col-md-6 mb-3">
                    <label>Employee Code</label>
                    <input type="text"
                           name="code"
                           class="form-control"
                           placeholder="EMP001"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Employee Name</label>
                    <input type="text"
                           name="name"
                           class="form-control"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Gender</label>

                    <select name="gender" class="form-control">

                        <option value="Female">Female</option>
                        <option value="Male">Male</option>

                    </select>

                </div>

                <div class="col-md-6 mb-3">
                    <label>Department</label>
                    <input type="text"
                           name="department"
                           class="form-control"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Designation</label>
                    <input type="text"
                           name="designation"
                           class="form-control"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Email</label>
                    <input type="email"
                           name="email"
                           class="form-control"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Phone</label>
                    <input type="text"
                           name="phone"
                           class="form-control"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Basic Salary</label>
                    <input type="number"
                           name="salary"
                           class="form-control"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Joining Date</label>
                    <input type="date"
                           name="date"
                           class="form-control"
                           required>
                </div>

            </div>

            <button type="submit" class="btn btn-success">
                Save Employee
            </button>

            </form>

        </div>

        <!-- Employee Table -->

        <div class="card p-3 mt-4">

            <h4>Employee List</h4>

            <table class="table table-bordered table-hover">

                <thead class="table-dark">

                    <tr>

                        <th>ID</th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Salary</th>
                        <th>Action</th>

                    </tr>

                </thead>

                <tbody>

<%
try{

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery("SELECT * FROM employee");

    while(rs.next()){
%>

<tr>

    <td><%= rs.getString("emp_code") %></td>

    <td><%= rs.getString("name") %></td>

    <td><%= rs.getString("department") %></td>

    <td>₹<%= rs.getDouble("basic_salary") %></td>

    <td>
    <a href="editEmployee.jsp?id=<%=rs.getInt("emp_id")%>"
class="btn btn-primary btn-sm">
Edit
</a>

    <a href="DeleteEmployeeServlet?id=<%= rs.getInt("emp_id") %>"
       class="btn btn-danger btn-sm">
       Delete
    </a>
       <a href="payslip.jsp?id=<%=rs.getInt("emp_id")%>"
class="btn btn-success btn-sm">
Payslip
</a>
</td>

</tr>

<%
    }

}catch(Exception e){

    out.println(e);

}
%>

</tbody>

            </table>

        </div>

    </div>

</div>

</body>

</html>