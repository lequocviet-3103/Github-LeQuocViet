<%-- 
    Document   : customerEdit
    Created on : Mar 13, 2025, 8:42:25 AM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/customerEdit.css"> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Edit</title>
    </head>
    <body>
        <jsp:include page="/menu_1.jsp" flush="true" /> 

        <h1>Customer Edit</h1>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
        <h2 style="color: red;"><%= errorMessage%></h2>
        <% }%>

        <form action="CustomersController" method="POST">
            <table>
                <tr><td>CustomerID:</td><td> <input name="id" value="${requestScope.object.cusID}" /> </td></tr>
                <tr><td>Customer Name:</td><td> <input  name="name" value="${requestScope.object.fullName}" /> </td></tr>
                <tr><td>Phone:</td><td> <input name="phone" value="${requestScope.object.phone}" /> </td></tr>
                <tr><td>Address:</td><td> <input name="address" value="${requestScope.object.address}" /> </td></tr>
                    
                <tr>
                    <td colspan="2">
                        <input type="hidden" name="action" value="${requestScope.nextaction}" />
                        <input type="submit" value="Save" />
                        <input type="button" value="Cancel" onclick="window.history.back();" />
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
