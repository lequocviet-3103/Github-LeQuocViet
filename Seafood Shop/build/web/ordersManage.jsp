<%@page import="AdminController.Orders.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders Management</title>
        <link rel="stylesheet" href="css/orderPage.css">
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
            <h1>ORDERS MANAGEMENT</h1>
            <table border="1">
                <tr>
                    <th>Order ID</th>
                    <th>Order Name</th>
                    <th>Customer</th>
                    <th>Phone</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Actions</th>
                </tr>
                <%
                    List<OrderDTO> list = (List<OrderDTO>) request.getAttribute("ordersManage");
                    for (OrderDTO order : list) {
                        String statusClass = "";
                        if ("Pending".equals(order.getStatus())) {
                            statusClass = "pending";
                        } else if ("Delivered".equals(order.getStatus())) {
                            statusClass = "delivered";
                        } else if ("Cancelled".equals(order.getStatus())) {
                            statusClass = "cancelled";
                        }
                %>
                <tr>
                    <td><%= order.getOrderID()%></td>
                    <td><%= order.getOrderName()%></td>
                    <td><%= order.getCustomerName()%></td>
                    <td><%= order.getCustomerPhone()%></td>
                    <td><%= order.getTotal()%></td>
                    <td class="<%= statusClass%>"><%= order.getStatus()%></td>
                    <td><%= order.getOrderDate()%></td>
                    <td>
                        <form action="InvoiceController" method="post"><input type="hidden" name="orderId" value="<%= order.getOrderID()%>">
                            <button type="submit" name="action" value="update" 
                                    onclick="this.form.status.value = 'Delivered'">
                                Complete
                            </button>
                            <button type="submit" name="action" value="update" 
                                    onclick="this.form.status.value = 'Cancelled'">
                                Cancel
                            </button>
                            <input type="hidden" name="status" value="">
                        </form>
                    </td>
                </tr>
                <% }%>
            </table>
        </div>
    </body>
</html>