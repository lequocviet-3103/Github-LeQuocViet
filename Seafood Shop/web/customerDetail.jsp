<%-- 
    Document   : customerDetail
    Created on : Mar 13, 2025, 8:42:08 AM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/customerDetail.css"> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Details</title>
    </head>
    <body>
        <jsp:include page="/menu_1.jsp" flush="true" />
        <h1>Customer Details </h1>         
        
        <table>
            <tr><td>CustomerID: </td><td>${requestScope.object.cusID}</td></tr>
            <tr><td>Customer Name: </td><td>${requestScope.object.fullName}</td></tr>
            <tr><td>Phone </td><td>${requestScope.object.phone}</td></tr>		 
            <tr><td>Address </td><td>${requestScope.object.address}</td></tr>		 
           	 
        </table>

        <form action="CustomersController">
            <input type=hidden name="id" value="${requestScope.object.cusID}">
            <input type=hidden name="action" value="edit">
            <input type=submit value="Edit">
        </form>
    </body>
</html>
