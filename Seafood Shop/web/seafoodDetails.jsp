<%-- 
    Document   : seafoodDetails
    Created on : Mar 10, 2025, 10:59:51 PM
    Author     : Lê Quốc Việt
--%>

<%@page import="CustomersController.Customers.CustomerDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Details</title>
    <link rel="stylesheet" href="css/loginsignup.css">
   
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>
<body class="itemdetails">
    <%@include file="menu.jsp" %>
    <div class="container-details">
        <div class="img-item">
            <img src="${seafoodDetails.image}" alt="${seafoodDetails.productName}" >
        </div>
        <div class="details">
            <h1>${seafoodDetails.productName}</h1>
            <span class="product-detail">${seafoodDetails.description}</span>
            <p class="price">Price: ${seafoodDetails.price}</p>
            <div class="product-weight">

                <form action="details" method="post">
                        <input type="hidden" name="id" value="${seafoodDetails.productId}">
                    <label for="weight">Weight</label>
                    <button type="submit" name="action" value="decrease">−</button>
                    <input type="number" name="weight" value="${weight != null ? weight : 1}" min="1">
                    <button type="submit" name="action" value="increase">+</button>
                </form>

            </div>
            <div class="buy-product">
                <div class="add-cart">
                    <i class="fa-solid fa-cart-shopping icon-cart"></i>
                    
                    <form action="cart" method="get">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId"  value="${seafoodDetails.productId}"/>
                        <input type="hidden" name="productName" value="${seafoodDetails.productName}" />
                        <input type="hidden" name="price" value="${seafoodDetails.price}" />
                        <input type="hidden" name="image" value="${seafoodDetails.image}" />
                        <input type="hidden" name="weight" value="${weight != null ? weight : 1}" />
                        <input type="submit" value="Add to cart" class="btn add-to-cart"/>

                        
                    </form>
                </div>
                <div class="buy-now">
                    <form action="buynow" method="post">
                        <input type="hidden" name="action" value="buy"/>
                        <input type="hidden" name="productId"  value="${seafoodDetails.productId}"/>
                        <input type="hidden" name="productName" value="${seafoodDetails.productName}" />
                        <input type="hidden" name="image" value="${seafoodDetails.image}"/>
                        <input type="hidden" name="price" value="${seafoodDetails.price}"/>
                        <input type="hidden" name="weight" value="${weight}" min="1" />
                        <input type="submit" value="Buy now" class="btn buy-now"/>

                    </form>
        
                </div>
            </div>
            
        </div>
    </div>
</body>
</html>
