<%-- 
    Document   : logout
    Created on : Mar 18, 2025, 6:13:21 PM
    Author     : LE BA LOC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/loginsignup.css">
</head>
<body class="login">

    <div class="login-container">
        
       
             <form action="login" method="post" class="login-form">
                <h1>LOGIN</h1>
                <div class="input-box">
                    <!-- <label for="username">Username</label> -->
                    <input name="username" type="text" placeholder="Username" required>
                </div>
                <div class="input-box">
                    <!-- <label for="password">Password</label> -->
                    <input name="password" type="password" placeholder="Password" required>
                </div>
                
                    <input type="submit" value="Login" class="login-btn">
              
                
            </form>
        
        <br>
         <br>
          <br>
        <% String error = (String) request.getAttribute("error"); 
            if(error!=null){
        %>
        <h3 style="color: red"><%= error%></h3>
        <% }
        
        %>
        
        <div class="signup-link">
            <p>New to Seafood Shop? <a href="signup.jsp">Create an account.</a></p>
        </div>
        
        
        
    </div>
    
    
</body>
</html>
