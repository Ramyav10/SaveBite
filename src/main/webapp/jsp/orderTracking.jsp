<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.Order"%>
<%@ page import="com.savebite_cag.model.User"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

Order order = (Order) request.getAttribute("order");
if (order == null) {
    response.sendRedirect(request.getContextPath() + "/jsp/orders.jsp");
    return;
}

String tracking = order.getTrackingStatus();
if (tracking == null || tracking.isEmpty()) tracking = "PLACED";

// Define step order
String[] steps = {"PLACED", "CONFIRMED", "PREPARING", "OUT_FOR_DELIVERY", "DELIVERED"};
int currentStep = 0;
for (int i = 0; i < steps.length; i++) {
    if (steps[i].equalsIgnoreCase(tracking)) {
        currentStep = i;
        break;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Track Order #<%=order.getOrderId()%> - SaveBite</title>
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

<div class="tracking-wrapper">

    <a href="<%=request.getContextPath()%>/jsp/orders.jsp" class="back-link">← Back to My Orders</a>

    <h1 class="tracking-title">Track Your Order</h1>
    <p class="tracking-subtitle">Order #<%=order.getOrderId()%></p>

    <!-- ORDER STATUS CARD -->
    <div class="tracking-card">

        <% if (currentStep == steps.length - 1) { %>
            <div class="tracking-delivered">
                <span class="tracking-delivered-icon">✅</span>
                <p>Your order has been delivered!</p>
            </div>
        <% } else { %>
            <div class="tracking-eta">
                🕐 Estimated Delivery: <strong>30 - 45 minutes</strong>
            </div>
        <% } %>

        <!-- PROGRESS TRACKER -->
        <div class="tracking-steps">

            <div class="tracking-step <%=currentStep >= 0 ? "active" : ""%>">
                <div class="step-icon">📝</div>
                <div class="step-label">Order Placed</div>
            </div>

            <div class="tracking-line <%=currentStep >= 1 ? "active" : ""%>"></div>

            <div class="tracking-step <%=currentStep >= 1 ? "active" : ""%>">
                <div class="step-icon">✅</div>
                <div class="step-label">Confirmed</div>
            </div>

            <div class="tracking-line <%=currentStep >= 2 ? "active" : ""%>"></div>

            <div class="tracking-step <%=currentStep >= 2 ? "active" : ""%>">
                <div class="step-icon">👨‍🍳</div>
                <div class="step-label">Preparing</div>
            </div>

            <div class="tracking-line <%=currentStep >= 3 ? "active" : ""%>"></div>

            <div class="tracking-step <%=currentStep >= 3 ? "active" : ""%>">
                <div class="step-icon">🛵</div>
                <div class="step-label">Out for Delivery</div>
            </div>

            <div class="tracking-line <%=currentStep >= 4 ? "active" : ""%>"></div>

            <div class="tracking-step <%=currentStep >= 4 ? "active" : ""%>">
                <div class="step-icon">📦</div>
                <div class="step-label">Delivered</div>
            </div>

        </div>

    </div>

    <!-- ORDER INFO -->
    <div class="tracking-info-card">
        <h2>📋 Order Information</h2>

        <div class="tracking-info-row">
            <span>Order ID</span>
            <span>#<%=order.getOrderId()%></span>
        </div>
        <div class="tracking-info-row">
            <span>Order Date</span>
            <span><%=order.getOrderDate()%></span>
        </div>
        <div class="tracking-info-row">
            <span>Total Amount</span>
            <span class="amount-highlight">₹<%=String.format("%.2f", order.getTotalAmount())%></span>
        </div>
        <div class="tracking-info-row">
            <span>Payment Status</span>
            <span class="badge <%="Paid".equalsIgnoreCase(order.getPaymentStatus()) ? "badge-success" : "badge-pending"%>">
                <%=order.getPaymentStatus()%>
            </span>
        </div>
        <div class="tracking-info-row">
            <span>Delivery Address</span>
            <span><%=order.getDeliveryAddress()%></span>
        </div>
    </div>

</div>

</body>
</html>