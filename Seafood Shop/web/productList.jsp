
<%@page import="AdminController.Product.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/productList.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
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

            <h1>WELCOME TO PRODUCT LIST</h1>

            <div class="form-container">
                <form action="ProductController" method="POST" class="search-form"> 
                    <input type="text" name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" placeholder="Name of product">
                    <input type="hidden" name="action" value="search" />
                    <input type="submit" value="Search">
                </form>

                <form action="ProductController" method="POST" class="create-form"> 
                    <input type="hidden" name="action" value="create" />
                    <input type="submit" value="Create">
                </form>
            </div>

            <table class="product-table" border="1">
                <tr>
                    <th>ProductID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>

                <%
                    List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("productList");
                    if (list != null) {
                        for (ProductDTO product : list) {
                            pageContext.setAttribute("see", product);
                %>
                <tr>
                    <td>${see.id}</td>
                    <td>${see.name}</td>
                    <td>${see.formattedPrice}</td>
                    <td class="actions">
                        <form action="ProductController" method="POST" class="details-form">
                            <input type="hidden" name="action" value="details" />
                            <input type="hidden" name="id" value="${see.id}" />
                            <input type="submit" value="Details">
                        </form>

                        <form action="ProductController" method="POST" class="delete-form">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="id" value="${see.id}" />
                            <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="4">No products found.</td></tr>
                <% } %>
            </table>
        </div>
    </body>
</html>
