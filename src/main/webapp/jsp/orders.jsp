<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Order"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.daoimpl.OrderDAOImpl"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

OrderDAOImpl dao = new OrderDAOImpl();
List<Order> orders = dao.getOrdersByUser(user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders - SaveBite</title>
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
      
        <a href="<%=request.getContextPath()%>/jsp/cart.jsp" class="cart-link">&#128722;</a>
        <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username">👤
    <%=navUser != null ? navUser.getFullName() : ""%>
</a>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="orders-wrapper">

    <h1 class="orders-title">My Orders</h1>
    <p class="orders-subtitle">Track and manage all your past orders</p>

    <% if (orders == null || orders.isEmpty()) { %>
        <div class="orders-empty">
            <p>📦 You haven't placed any orders yet!</p>
            <a href="/savebite_cag/RestaurantServlet" class="btn">Start Ordering</a>
        </div>
    <% } else { %>

    <div class="orders-list">
    <%
    for (Order order : orders) {
        if (order.getTotalAmount() <= 0) continue;

        String paymentStatus = order.getPaymentStatus();
        String orderStatus = order.getOrderStatus();
        String trackingStatus = order.getTrackingStatus();

        String paymentBadgeClass = "Paid".equalsIgnoreCase(paymentStatus) ? "badge-success" : "badge-pending";
        String statusBadgeClass;
        if ("Delivered".equalsIgnoreCase(orderStatus)) {
            statusBadgeClass = "badge-success";
        } else if ("Cancelled".equalsIgnoreCase(orderStatus)) {
            statusBadgeClass = "badge-danger";
        } else {
            statusBadgeClass = "badge-info";
        }
    %>
        <div class="order-card">

            <div class="order-card-header">
                <div class="order-id-group">
                    <span class="order-id-label">ORDER ID</span>
                    <span class="order-id-value">#<%=order.getOrderId()%></span>
                </div>
                <div class="order-date">
                    <%=order.getOrderDate()%>
                </div>
            </div>

            <div class="order-card-body">

                <div class="order-detail">
                    <span class="order-detail-label">Total Amount</span>
                    <span class="order-amount">₹<%=String.format("%.2f", order.getTotalAmount())%></span>
                </div>

                <div class="order-detail">
                    <span class="order-detail-label">Payment Status</span>
                    <span class="badge <%=paymentBadgeClass%>">
                        <%="Paid".equalsIgnoreCase(paymentStatus) ? "✓ Paid" : "⏳ Pending"%>
                    </span>
                </div>

                <div class="order-detail">
                    <span class="order-detail-label">Order Status</span>
                    <span class="badge <%=statusBadgeClass%>">
                        <%=orderStatus != null ? orderStatus : "Placed"%>
                    </span>
                </div>

                <% if (trackingStatus != null && !trackingStatus.isEmpty()) { %>
                <div class="order-detail">
                    <span class="order-detail-label">Tracking</span>
                    <span class="badge badge-info">📍 <%=trackingStatus%></span>
                </div>
                <% } %>

            </div>

            <div class="order-card-footer">
                <a href="<%=request.getContextPath()%>/OrderTrackingServlet?orderId=<%=order.getOrderId()%>"
   class="track-btn">
    Track Order →
</a>
            </div>

        </div>
    <% } %>
    </div>

    <% } %>

</div>

</body>
</html>