<%@page import="CustomersController.Customers.CustomerDTO"%>
<%@page import="CustomersController.Product.ProductDTO"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Seafood Shop</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>

        <!-- Header -->
        <%@include file="menu.jsp" %>

        <!-- Banner -->
        <section class="banner">
            <img src="img/banner.jpg" alt="Seafood Banner">
        </section>
        <!-- About Section -->
        <section class="about" id="about">
            <h2>About Us</h2>
            <div class="about-content">
                <div class="about-text">
                    <h1>Seafood Shop</h1>
                    <p>
                        Our restaurant always puts customers first, dedicated to serving and bringing customers the best experiences.
                        Exclusive recipes will bring new flavors to diners. Seafood Shop sincerely thanks you!
                    </p>
                </div>
                <div class="about-images">
                    <img src="img/dish 1.jpg" alt="Dish 1">
                    <img src="img/dish 2.jpg" alt="Dish 2">
                </div>
            </div>
        </section>

        <!-- Menu Section -->
        <!--        <section id="menu" class="featured-dishes">
                    <h2>Our Menu</h2>
                    <div class="dish-container">-->
        <%--<c:forEach var="product" items="${productlist}">
            <div class="dish-card">
                <img src="${product.image}" alt="${product.productName}">
            </div>
        </c:forEach>--%>

<!--    </div>
</section>-->

<!-- Product Listing -->
<section id="products" class="product-section">
    <h2>Our Products</h2>
    <div class="product-container">
        <div class="product-grid">
            <c:forEach var="product" items="${productlist}">
                <div class="product-card">
                    <img src="${product.image}" alt="${product.productName}">
                    <a class="product-name" href="SeafoodController?action=details&id=${product.productId}">
                        ${product.productName}
                    </a>
                    <p class="product-price">Price: ${product.price} VND</p>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="pagination" id="pagination">
        <c:if test="${currentPage > 1}">
            <a href="SeafoodController?action=list&page=${currentPage - 1}&keyword=${keyword}#pagination">Previous</a>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="current-page">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="SeafoodController?action=list&page=${i}&keyword=${keyword}#pagination">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a href="SeafoodController?action=list&page=${currentPage + 1}&keyword=${keyword}#pagination">Next</a>
        </c:if>
    </div>


</section>
<!-- Contact Section -->
<section id="contact" class="contact-section">
    <h2>Contact Us</h2>
    <p>Email: contact@example.com</p>
    <p>Phone: +123456789</p>
    <p>Address: 123 Street, City</p>
</section>

<!-- Footer -->
<footer class="footer">
    <h3>Follow Us</h3>
    <div class="social-icons">
        <a href="#"><i class="fab fa-facebook"></i> Facebook</a>
        <a href="#"><i class="fab fa-linkedin"></i> LinkedIn</a>
        <a href="#"><i class="fab fa-instagram"></i> Instagram</a>
    </div>
</footer>

</body>
</html>
