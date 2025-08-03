<%-- 
    Document   : signup
    Created on : Mar 10, 2025, 10:59:13 PM
    Author     : Lê Quốc Việt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/loginsignup.css">
</head>
<body class="signup">

    <div class="login-container">
        
       
             <form action="signup" method="post" class="signup-form">
                 <input type="hidden" name="action" value="signup.jsp" >

                <h1>SIGN UP</h1>

                <div class="input-box">
                    <input name="fullname" type="text" placeholder="Fullname" required>
                </div>
                
                <div class="input-box">
                    <input name="username" type="text" placeholder="Username" required>
                    <h3 style="color: red">${errorUsername}</h3>
                </div>
                <div class="input-box">
                    <input name="phone" type="number" placeholder="Phone" required>
                    <h3 style="color: red">${errorPhone}</h3>
                </div>
                <div class="input-box">
                    <input name="address" type="text" placeholder="Address" required>
                </div>
                <div class="input-box">
                    <input name="password" type="password" placeholder="Password" required>
                </div>
                <input type="submit" value="Sign Up" class="signup-btn">
                
                              
            </form>
        
        
    </div>
</body>
</html>
