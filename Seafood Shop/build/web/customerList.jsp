<%@page import="AdminController.Customers.CustomerDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer List</title>
        <link rel="stylesheet" type="text/css" href="styles.css"> 
        <link rel="stylesheet" href="css/customerPage.css">
    </head>
    <body>
        <div class="container">
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
        
        <div class="container">
            <h1>WELCOME TO CUSTOMER LIST</h1>
            
            <div class="form-actions">
                <form action="CustomersController" method="POST" class="search-form"> 
                    <input type="text" name="search" value="<%=request.getParameter("search") != null ? request.getParameter("search") : ""%>" placeholder="Name/Phone">
                    <input type="hidden" name="action" value="search" />
                    <input type="submit" value="Search">
                </form>
                
<!--                <form action="CustomersController" method="POST" class="create-form"> 
                    <input type="hidden" name="action" value="create" />
                    <input type="submit" value="Create">
                </form>-->
            </div>
            
            <table class="customer-table" border="1">
                <thead>
                    <tr>
                        <th>CustomerID</th>
                        <th>Full Name</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<CustomerDTO> list = (List<CustomerDTO>) request.getAttribute("customerList");
                        for (CustomerDTO cus : list) {
                            pageContext.setAttribute("see", cus);
                    %>
                    <tr>
                        <td>${see.cusID}</td>
                        <td>${see.fullName}</td>
                        <td>${see.phone}</td>
                        <td>${see.address}</td>
                        <td class="action-buttons">
                            <form action="CustomersController" method="POST" class="details-form">
                                <input type="hidden" name="action" value="details" />
                                <input type="hidden" name="id" value="${see.cusID}" />
                                <input type="submit" value="Details">
                            </form>
                            
                            <form action="CustomersController" method="POST" class="delete-form">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="id" value="${see.cusID}" />
                                <input type="submit" value="Delete">
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>
