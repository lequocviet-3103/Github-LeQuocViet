<%-- 
    Document   : cart
    Created on : Mar 13, 2025, 10:22:19 PM
    Author     : Lê Quốc Việt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel="stylesheet" href="css/logout.css">
    </head>
    <body class="logout">
        <%@include file="menu.jsp" %>
        <div class="logout-container">
            <form action="payment" method="post">
                <table border="1" width="700" cellspacing="1" class="table-cart">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Weight</th>
                            <th>Price * Weight</th>
                            <th>Total</th>
                            <th>Action</th>
                            <th>Select</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart}">
                            <tr>
                                <td><img src="${item.image}" width="50"></td>
                                <td>${item.productName}</td>
                                <td>${item.price}</td>
                                <td>${item.stockWeight}</td>
                                <td>${item.price} * ${item.stockWeight}</td>
                                <td>${item.price * item.stockWeight}</td>
                                <td>
                                    <form action="cart" method="post">
                                        <input type="hidden" name="id" value="${item.productId}"/>
                                        <input type="hidden" name="action" value="removeCart"/>
                                        <input type="submit" value="Remove"/>
                                    </form>

                                </td>
                                <td>
                                    <input type="checkbox" name="selectedItems" value="${item.productId}">
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table>
                <select name="paymentMethod">
                    <option value="Cash">Cash</option>
                    <option value="Credit">Credit</option>
                </select>

                <input type="hidden" name="action" value="payment">
                <input type="hidden" name="customerId" value="${customer.getCustomerId()}">
                <input type="hidden" name="productId" value="${item.productId}">
                <input type="hidden" name="customerName" value="${customer.getFullname()}">
                <input type="hidden" name="customerAddress" value="${customer.getAddress()}">
                <input type="hidden" name="productName" value="${item.productName}">
                <input type="hidden" name="price" value="${item.price}">
                <input type="hidden" name="weight" value="${item.stockWeight}">
                <input type="hidden" name="image" value="${item.image}">
                <input type="submit" value="Pay Now">
            </form> 
        </div>
    </body>
</html>
