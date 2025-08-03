<%-- 
    Document   : productEdit
    Created on : Mar 12, 2025, 1:10:31 PM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Edit</title>
        <link rel="stylesheet" type="text/css" href=""> 
        <link rel="stylesheet" type="text/css" href="css/productEdit.css"> 
        
    </head>
    <body>
        <jsp:include page="/menu_1.jsp" flush="true" /> 

        <div class="container">
            <h1>Product Edit</h1>

            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null && !errorMessage.isEmpty()) {%>
            <h2 class="error-message"><%= errorMessage%></h2>
            <% }%>

            <form action="ProductController" method="GET" class="product-form">
                <div class="form-group">
                    <label for="id">Product ID:</label>
                    <input type="text" id="id" name="id" value="${requestScope.object.id}" />
                </div>

                <div class="form-group">
                    <label for="name">Product Name:</label>
                    <input type="text" id="name" name="name" value="${requestScope.object.name}" />
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="text" id="price" name="price" value="${requestScope.object.price}" />
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <input type="text" id="description" name="description" value="${requestScope.object.description}" />
                </div>

                <div class="form-group">
                    <label for="imageURL">Image URL:</label>
                    <input type="text" id="imageURL" name="imageURL" value="${requestScope.object.imageURL}" />
                </div>

                <input type="hidden" name="action" value="${requestScope.nextaction}" />

                <div class="form-actions">
                    <input type="submit" value="Save" class="btn btn-primary" />
                    <input type="button" value="Cancel" class="btn btn-secondary" onclick="window.history.back();" />
                </div>
            </form>
        </div>
    </body>
</html>
