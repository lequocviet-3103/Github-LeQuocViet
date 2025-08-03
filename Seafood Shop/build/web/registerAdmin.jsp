<%-- 
    Document   : registerAdmin.jsp
    Created on : Mar 23, 2025, 9:05:09 PM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/loginsignup.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body class="signup">
        <div class="login-container">
        <form action="LoginAdminController" method="post" class="signup-form">
            <input type="hidden" name="action" value="register">

            <h1>SIGN UP</h1>
            
            <div class="input-box">
            <input type="text" name="fullName" required placeholder="Fullname"><br>
            </div>
            
            <div class="input-box">
            <input type="text" name="userName" required placeholder="Username"><br>
            </div>
            
            <div class="input-box">
            <input type="text" name="phone" required placeholder="Phone"><br>
            </div>
            <div class="input-box">
            <input type="text" name="address" required placeholder="Address"><br>
            </div>
            <div class="input-box">
                <input type="password" name="password" required placeholder="Password"><br>
            </div>
            
            
            <input type="submit" value="Sign Up" class="signup-btn">
        </form>
            </div>
    </body>
</html>
