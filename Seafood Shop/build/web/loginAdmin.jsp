<%-- 
    Document   : loginAdmin
    Created on : Mar 12, 2025, 9:50:08 AM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/loginsignup.css">
        <title>Login Admin</title>
    </head>
    <body class="login">
         <div class="login-container">
            
                <h1>Login Admin</h1>
                <form action="./LoginAdminController" method="POST" class="login-form">
                    <div class="input-box">
                        <input type="text" name="username" placeholder="Username" required /> <br>
                    </div>
                    
                    <div class="input-box">
                    <input type="password" name="password" placeholder="Password" required /> <br>
                    </div>
                    <input type="hidden" name="action" value="Login" />
                    <input type="submit" value="Login" class="login-btn"/>
                </form>
                <br>
         <br>
          <br>
                <% String error = (String) request.getAttribute("error");
                if (error != null) {%>
                <p class="error-message"><%= error%></p>
                <% }%>
                
            
                <div class="signup-link">
            <p>New to Seafood Shop? <a href="registerAdmin.jsp">Create an account.</a></p>
        </div>
        </div>
    </body>

</html>
