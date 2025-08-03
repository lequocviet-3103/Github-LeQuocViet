<%-- 
    Document   : checkout
    Created on : Mar 15, 2025, 11:10:38 PM
    Author     : Lê Quốc Việt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>

<%@page import="CustomersController.Product.ProductDTO"%>
<%@page import="CustomersController.Product.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check out</title>
        <link rel="stylesheet" href="css/checkout.css">
    </head>
    <body>
        <%@include file="menu.jsp" %>
        <table border="1">
            <thead>
                <tr>
                    <th>Customer Name</th>
                    <th>Phone</th>
                    <th>Shipping address</th>
                    <th>Product name</th>
                    <th>Price</th>
                    <th>Weight</th>
                    <th>Total amount</th>
                    <th>Image</th>
                    <th>Payment</th>
                </tr>
            </thead>
            <tbody>
            
            
                <c:forEach var="buy" items="${buyPro}">
                    
                <tr>
                    <td>${customer.getFullname()}</td>
                    <td>${customer.getPhone()}</td>
                    <td>${customer.getAddress()}</td>
                    <td>${buy.productName}</td>
                    <td>${buy.price}</td>
                    <td>${buy.stockWeight}</td>
                    <td>${buy.price * buy.stockWeight}</td>
                    
                    <td><img src="${buy.image}" width="50"></td>

                    <td>
                    <form action="paymentBuynow" method="post">
                        <select name="paymentMethod">
                            <option value="Cash">Cash</option>
                            <option value="Credit">Credit</option>
                        </select>
                        <input type="hidden" name="action" value="payment">
                        <input type="hidden" name="customerId" value="${customer.getCustomerId()}">
                        <input type="hidden" name="productId" value="${buy.productId}">
                        <input type="hidden" name="customerName" value="${customer.getFullname()}">
                        <input type="hidden" name="customerAddress" value="${customer.getAddress()}">
                        <input type="hidden" name="productName" value="${buy.productName}">
                        <input type="hidden" name="price" value="${buy.price}">
                        <input type="hidden" name="image" value="${buy.image}">
                        <input type="hidden" name="weight" value="${buy.stockWeight}">
                        
                        <input type="submit" value="Pay Now">
                    </form>             
                    </td>
                    
                </tr>
            </c:forEach>      
            
            </tbody>
        </table>
                    
    </body>
</html>
