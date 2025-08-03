<%-- 
    Document   : menu
    Created on : Mar 22, 2025, 8:51:42 PM
    Author     : LE BA LOC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
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
                    <li><a href="SeafoodController">Home</a></li>
                    <li><a href="#about">About</a></li> 
                    <li><a href="#products">Products</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
            </nav>

            <div class="icons">
                <form action="SeafoodController#products" method="get">
                    <input type="text" name="keyword" placeholder="Search">
                    <input type="hidden" name="action" value="search">
                    <input type="submit" value="Search">
                </form>

                <a href="cart.jsp"><i class="fas fa-shopping-cart"></i></a>
                <div class="hiden-login">
                    <i class="fa-solid fa-user"></i>
                    <div class="nemu-login">
                <c:choose>
                    <c:when test="${not empty sessionScope.usersession}">

                        <a href="logout.jsp">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" class="user-icon">Login</a>
                        <a href="signup.jsp">Sign Up</a>
                    </c:otherwise>
                </c:choose>
                     </div>   
                </div>        
            </div>
            
        </div>
    </header>
    </body>
</html>
