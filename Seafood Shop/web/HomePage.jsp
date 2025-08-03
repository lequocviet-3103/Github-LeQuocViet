<%-- 
    Document   : HomePage
    Created on : Mar 20, 2025, 8:39:41 PM
    Author     : Admins
--%>

<%@page import="AdminController.Home.HomeDTO"%>
<%@page import="AdminController.Controller.CustomersController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/HomePage.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOME</title>
    </head>
    <body>
        <header>
            <div class="nav-container">
                <div class="logo">
                    <img src="img/logo.png" alt="Logo">
                    <span>Seafood Shop</span>
                </div>
                <nav>
                    <ul>
                        <li><a href="#">Home</a></li>
                        <li><a href="#menu">Menu</a></li> 
                        <li><a href="#about">About</a></li> 
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </nav>


                <div class="icons">
                    <input type="text" placeholder="Search">
                    <i class="fas fa-search"></i>
                    <i class="fas fa-shopping-cart"></i>
                    <i class="fas fa-user-circle"></i>
                </div>
            </div>
        </header>

        <%@include file="menu_1.jsp" %>
        <% HomeDTO homeData = (HomeDTO) request.getAttribute("info");
            String totalRevenue = (String) request.getAttribute("formattedRevenue");
        %>

        <div class="content">
            <div class="dashboard">
                <div class="box total-customer">TOTAL CUSTOMER <br> <%= homeData.getTotalCustomers()%></div>
                <div class="box total-order">TOTAL ORDER <br> <%= homeData.getTotalOrders()%></div>
                <div class="box total-product">TOTAL PRODUCT <br> <%= homeData.getTotalProducts()%></div>
                <div class="box total-price">TOTAL PRICE <br> <%= totalRevenue%> VND</div>
            </div>
        </div>

    </body>
</html>
