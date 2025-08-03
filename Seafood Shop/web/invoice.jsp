<%-- 
    Document   : invoice
    Created on : Mar 18, 2025, 5:34:10 PM
    Author     : LE BA LOC
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice</title>
</head>
<body>
    
    <h2>Order Invoice</h2>
    
    <%
        HttpSession sessionObj = request.getSession();
        String message = (String) sessionObj.getAttribute("message");
        if (message != null) {
            out.println("<p style='color:green;'>" + message + "</p>");
            sessionObj.removeAttribute("message");
        }
    %>

    <a href="home.jsp">Return to Home</a>
</body>
</html>
