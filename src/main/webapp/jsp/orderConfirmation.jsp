<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

Integer orderId = (Integer) session.getAttribute("orderId");
Integer finalTotal = (Integer) session.getAttribute("finalTotal");
String paymentMethod = (String) session.getAttribute("paymentMethod");
String deliveryAddress = (String) session.getAttribute("deliveryAddress");

// Clear session attributes after showing
session.removeAttribute("orderId");
session.removeAttribute("finalTotal");
session.removeAttribute("paymentMethod");
session.removeAttribute("deliveryAddress");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Confirmed - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>

<!-- NAVBAR -->
<%@ page import="com.savebite_cag.model.User"%>
<%
User navUser = (User) session.getAttribute("user");
%>
<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
     
        <a href="<%=request.getContextPath()%>/jsp/orders.jsp">My Orders</a>
        <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username">👤
    <%=navUser != null ? navUser.getFullName() : ""%>
</a>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="confirm-wrapper">

    <!-- Success Icon -->
    <div class="confirm-icon">✅</div>

    <h1 class="confirm-title">Order Placed Successfully!</h1>
    <p class="confirm-subtitle">
        Thank you, <%=user.getFullName()%>! Your order has been confirmed.
    </p>

    <!-- Order Details Card -->
    <div class="confirm-card">

        <div class="confirm-row">
            <span>Order ID</span>
            <span class="confirm-value">#<%=orderId != null ? orderId : "N/A"%></span>
        </div>

        <div class="confirm-row">
            <span>Amount Paid</span>
            <span class="confirm-value orange">₹<%=finalTotal != null ? finalTotal : 0%></span>
        </div>

        <div class="confirm-row">
            <span>Payment Method</span>
            <span class="confirm-value"><%=paymentMethod != null ? paymentMethod : "COD"%></span>
        </div>

        <div class="confirm-row">
            <span>Delivery Address</span>
            <span class="confirm-value"><%=deliveryAddress != null ? deliveryAddress : user.getAddress()%></span>
        </div>

        <div class="confirm-row">
            <span>Order Status</span>
            <span class="confirm-badge">🟢 Placed</span>
        </div>

        <div class="confirm-row">
            <span>Estimated Delivery</span>
            <span class="confirm-value">30 - 45 minutes</span>
        </div>

    </div>

    <!-- Actions -->
    <div class="confirm-actions">
        <a href="<%=request.getContextPath()%>/jsp/orderHistory.jsp" class="checkout-btn">
            View My Orders
        </a>
        <a href="<%=request.getContextPath()%>/RestaurantServlet" class="continue-btn">
            Order More Food
        </a>
    </div>

</div>

</body>
</html>