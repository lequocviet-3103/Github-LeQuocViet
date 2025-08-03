
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/checkout.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <div class="payment-success">
            <span class="checkmark">✔</span>
            <p>Payment successfully! This is your bill. Thank you very much!</p>
        </div>

        <table class="payment-table">
            <tr>
                <th class="table-header">Customer Name</th>
                <td class="table-data">${customer.fullname}</td>
            </tr>
            <tr>
                <th class="table-header">Phone</th>
                <td class="table-data">${customer.phone}</td>
            </tr>
            <tr>
                <th class="table-header">Shipping Address</th>
                <td class="table-data">${customer.address}</td>
            </tr>

            <c:forEach var="item" items="${selectedProducts}">
                <tr>
                    <th class="table-header">ID</th>
                    <td class="table-data">${item.productId}</td>
                </tr>
                <tr>
                    <th class="table-header">Product Name</th>
                    <td class="table-data">${item.productName}</td>
                </tr>
                <tr>
                    <th class="table-header">Price</th>
                    <td class="table-data">${item.price} VND</td>
                </tr>
                <tr>
                    <th class="table-header">Weight</th>
                    <td class="table-data">${item.stockWeight} kg</td>
                </tr>
                <tr>
                    <th class="table-header">Total</th>
                    <td class="table-data">${item.price * item.stockWeight} VND</td>
                </tr>
            </c:forEach>
            <tr>
                <th class="table-header">Grand Total</th>
                <td class="table-data">${totalAmount} VND</td>
            </tr>
        </table>
    </body>
</html>
