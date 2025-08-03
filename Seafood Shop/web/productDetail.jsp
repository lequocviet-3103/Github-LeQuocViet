<%-- 
    Document   : productDetail
    Created on : Mar 12, 2025, 12:52:24 PM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Details</title>
        <link rel="stylesheet" type="text/css" href="css/productDetail.css"> 
    </head>
    <body>
        <jsp:include page="/menu_1.jsp" flush="true" />

        <div class="container">
            <h1>Product Details</h1>         

            <div class="product-details">
                <p><strong>Product ID:</strong> ${requestScope.object.id}</p>
                <p><strong>Product Name:</strong> ${requestScope.object.name}</p>
                <p><strong>Price:</strong> ${requestScope.object.formattedPrice}</p>
                <p><strong>Description:</strong> ${requestScope.object.description}</p>
            </div>
            
            <div class="product-image">
                <strong>Image:</strong>
                <img src="${requestScope.object.imageURL}" width="200" alt="Product Image">
            </div>
            
            <div class="form-actions">
                <form action="ProductController">
                    <input type="hidden" name="id" value="${requestScope.object.id}">
                    <input type="hidden" name="action" value="edit">
                    <input type="submit" value="Edit" class="btn btn-primary">
                    <input type="button" value="Cancel" class="btn btn-secondary" onclick="window.history.back();" />
                </form>
            </div>
        </div>
    </body>
</html>
