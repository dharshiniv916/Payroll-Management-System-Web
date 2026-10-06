package com.payroll.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet{

protected void doGet(HttpServletRequest request,
HttpServletResponse response)
throws ServletException,IOException{

request.getSession().invalidate();

response.sendRedirect("login.jsp?logout=success");

}
}