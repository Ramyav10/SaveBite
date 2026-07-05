<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.model.Order"%>
<%@ page import="com.savebite_cag.model.Restaurant"%>
<%@ page import="com.savebite_cag.model.Donation"%>
<%@ page import="com.savebite_cag.daoimpl.UserDAOImpl"%>
<%@ page import="com.savebite_cag.daoimpl.RestaurantDAOImpl"%>
<%@ page import="com.savebite_cag.daoimpl.OrderDAOImpl"%>
<%@ page import="com.savebite_cag.daoimpl.DonationDAOImpl"%>

<%
User user = (User) session.getAttribute("user");
if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
}

UserDAOImpl userDao = new UserDAOImpl();
RestaurantDAOImpl restaurantDao = new RestaurantDAOImpl();
OrderDAOImpl orderDao = new OrderDAOImpl();
DonationDAOImpl donationDao = new DonationDAOImpl();

int totalUsers = userDao.getUserCount();
int totalRestaurants = restaurantDao.getRestaurantCount();
int totalOrders = orderDao.getOrderCount();
int totalDonations = donationDao.getDonationCount();

List<User> allUsers = userDao.getAllUsers();
List<Order> allOrders = orderDao.getAllOrders();
List<Restaurant> allRestaurants = restaurantDao.getAllRestaurants();
List<Donation> allDonations = donationDao.getAllDonations();

String activeTab = request.getParameter("tab");
if (activeTab == null) activeTab = "overview";

String successMsg = request.getParameter("success");
String errorMsg = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - SaveBite</title>
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
        <a href="<%=request.getContextPath()%>/jsp/adminDashboard.jsp">Dashboard</a>
        
        <span class="nav-username">👑 <%=navUser != null ? navUser.getFullName() : ""%></span>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="rdash-wrapper">

    <!-- SIDEBAR -->
    <div class="rdash-sidebar">
        <div class="rdash-restaurant-info">
            <div style="font-size:48px; margin-bottom:12px;">👑</div>
            <h3><%=user.getFullName()%></h3>
            <span class="rdash-status-badge rdash-active">ADMIN</span>
        </div>

        <nav class="rdash-nav">
            <a href="?tab=overview"
               class="rdash-nav-item <%="overview".equals(activeTab) ? "rdash-nav-active" : ""%>">
                📊 Overview
            </a>
            <a href="?tab=users"
               class="rdash-nav-item <%="users".equals(activeTab) ? "rdash-nav-active" : ""%>">
                👥 Users
                <span class="rdash-orders-badge"><%=totalUsers%></span>
            </a>
            <a href="?tab=restaurants"
               class="rdash-nav-item <%="restaurants".equals(activeTab) ? "rdash-nav-active" : ""%>">
                🏪 Restaurants
                <span class="rdash-orders-badge"><%=totalRestaurants%></span>
            </a>
            <a href="?tab=orders"
               class="rdash-nav-item <%="orders".equals(activeTab) ? "rdash-nav-active" : ""%>">
                📦 Orders
                <span class="rdash-orders-badge"><%=totalOrders%></span>
            </a>
            <a href="?tab=donations"
               class="rdash-nav-item <%="donations".equals(activeTab) ? "rdash-nav-active" : ""%>">
                🤝 Donations
                <span class="rdash-orders-badge"><%=totalDonations%></span>
            </a>
        </nav>
    </div>

    <!-- MAIN CONTENT -->
    <div class="rdash-main">

        <!-- SUCCESS/ERROR MESSAGES -->
        <% if (successMsg != null) { %>
            <div class="auth-success" style="margin-bottom:20px;">✅ <%=successMsg%></div>
        <% } %>
        <% if (errorMsg != null) { %>
            <div class="auth-error" style="margin-bottom:20px;">❌ <%=errorMsg%></div>
        <% } %>

        <!-- OVERVIEW TAB -->
        <% if ("overview".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">Admin Dashboard 👑</h1>
            <p class="rdash-subtitle">Welcome back, <%=user.getFullName()%>! Here's the SaveBite platform overview.</p>

            <div class="rdash-stats">
                <div class="rdash-stat-card">
                    <span class="rdash-stat-icon">👥</span>
                    <div>
                        <p class="rdash-stat-value"><%=totalUsers%></p>
                        <p class="rdash-stat-label">Total Users</p>
                    </div>
                </div>
                <div class="rdash-stat-card">
                    <span class="rdash-stat-icon">🏪</span>
                    <div>
                        <p class="rdash-stat-value"><%=totalRestaurants%></p>
                        <p class="rdash-stat-label">Restaurants</p>
                    </div>
                </div>
                <div class="rdash-stat-card">
                    <span class="rdash-stat-icon">📦</span>
                    <div>
                        <p class="rdash-stat-value"><%=totalOrders%></p>
                        <p class="rdash-stat-label">Total Orders</p>
                    </div>
                </div>
                <div class="rdash-stat-card">
                    <span class="rdash-stat-icon">🤝</span>
                    <div>
                        <p class="rdash-stat-value"><%=totalDonations%></p>
                        <p class="rdash-stat-label">Donations</p>
                    </div>
                </div>
            </div>

            <!-- Recent Users -->
            <div class="rdash-box">
                <div class="rdash-box-header">
                    <h2>Recent Users</h2>
                    <a href="?tab=users" class="rdash-link">View All →</a>
                </div>
                <% if (allUsers != null) {
                    int count = 0;
                    for (User u : allUsers) {
                        if (count >= 5) break;
                %>
                <div class="admin-user-row">
                    <div class="admin-user-avatar"><%=u.getFullName().substring(0,1).toUpperCase()%></div>
                    <div class="admin-user-info">
                        <p class="admin-user-name"><%=u.getFullName()%></p>
                        <p class="admin-user-email"><%=u.getEmail()%></p>
                    </div>
                    <span class="badge <%="CUSTOMER".equals(u.getRole()) ? "badge-info" : "RESTAURANT".equals(u.getRole()) ? "badge-pending" : "ADMIN".equals(u.getRole()) ? "badge-danger" : "badge-success"%>">
                        <%=u.getRole()%>
                    </span>
                </div>
                <%
                        count++;
                    }
                } %>
            </div>

            <!-- Recent Orders -->
            <div class="rdash-box">
                <div class="rdash-box-header">
                    <h2>Recent Orders</h2>
                    <a href="?tab=orders" class="rdash-link">View All →</a>
                </div>
                <% if (allOrders != null) {
                    int count = 0;
                    for (Order o : allOrders) {
                        if (count >= 5) break;
                        if (o.getTotalAmount() <= 0) continue;
                %>
                <div class="rdash-recent-order">
                    <span class="order-id-value">#<%=o.getOrderId()%></span>
                    <span style="color:#94a3b8; font-size:13px;">₹<%=String.format("%.2f", o.getTotalAmount())%></span>
                    <span class="badge <%="Paid".equalsIgnoreCase(o.getPaymentStatus()) ? "badge-success" : "badge-pending"%>">
                        <%=o.getPaymentStatus()%>
                    </span>
                    <span class="badge badge-info"><%=o.getOrderStatus()%></span>
                </div>
                <%
                        count++;
                    }
                } %>
            </div>
        </div>

        <!-- USERS TAB -->
        <% } else if ("users".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">All Users</h1>
            <p class="rdash-subtitle">Manage all registered users on SaveBite</p>

            <div class="rdash-box">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (allUsers != null) {
                        for (User u : allUsers) { %>
                        <tr>
                            <td>#<%=u.getUserId()%></td>
                            <td>
                                <div style="display:flex; align-items:center; gap:10px;">
                                    <div class="admin-user-avatar" style="width:32px; height:32px; font-size:13px;">
                                        <%=u.getFullName().substring(0,1).toUpperCase()%>
                                    </div>
                                    <%=u.getFullName()%>
                                </div>
                            </td>
                            <td><%=u.getEmail()%></td>
                            <td><%=u.getPhoneNumber() != null ? u.getPhoneNumber() : "N/A"%></td>
                            <td>
                                <span class="badge <%="CUSTOMER".equals(u.getRole()) ? "badge-info" : "RESTAURANT".equals(u.getRole()) ? "badge-pending" : "ADMIN".equals(u.getRole()) ? "badge-danger" : "badge-success"%>">
                                    <%=u.getRole()%>
                                </span>
                            </td>
                            <td>
                                <span class="badge <%="BLOCKED".equals(u.getStatus()) ? "badge-danger" : "badge-success"%>">
                                    <%=u.getStatus() != null ? u.getStatus() : "ACTIVE"%>
                                </span>
                            </td>
                            <td>
                                <% if (!"ADMIN".equals(u.getRole())) { %>
                                <div style="display:flex; gap:6px;">
                                    <a href="<%=request.getContextPath()%>/AdminBlockUserServlet?userId=<%=u.getUserId()%>&status=<%="BLOCKED".equals(u.getStatus()) ? "ACTIVE" : "BLOCKED"%>"
                                       class="<%="BLOCKED".equals(u.getStatus()) ? "rdash-edit-btn" : "rdash-toggle-food-btn"%>"
                                       style="font-size:12px; padding:4px 10px;">
                                       <%="BLOCKED".equals(u.getStatus()) ? "🟢 Unblock" : "🔴 Block"%>
                                    </a>
                                    <a href="<%=request.getContextPath()%>/AdminDeleteUserServlet?userId=<%=u.getUserId()%>"
                                       class="rdash-delete-btn"
                                       style="font-size:12px; padding:4px 10px;"
                                       onclick="return confirm('Delete user <%=u.getFullName()%>? This cannot be undone!')">
                                       🗑 Delete
                                    </a>
                                </div>
                                <% } else { %>
                                    <span style="color:#64748b; font-size:12px;">Protected</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- RESTAURANTS TAB -->
        <% } else if ("restaurants".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">All Restaurants</h1>
            <p class="rdash-subtitle">Manage all restaurants on SaveBite</p>

            <div style="display:flex; flex-direction:column; gap:14px;">
            <% if (allRestaurants != null) {
                for (Restaurant r : allRestaurants) { %>
                <div class="rdash-food-card">
                    <img src="<%=request.getContextPath()%>/<%=r.getImageUrl()%>"
                         alt="<%=r.getRestaurantName()%>"
                         onerror="this.src='<%=request.getContextPath()%>/images/default-food.jpg'">
                    <div class="rdash-food-info">
                        <h3><%=r.getRestaurantName()%></h3>
                        <p><%=r.getCuisineType()%> • <%=r.getDescription()%></p>
                        <div class="rdash-food-meta">
                            <span style="color:#94a3b8; font-size:13px;">⭐ <%=r.getRating()%></span>
                            <span style="color:#94a3b8; font-size:13px;">⏱ <%=r.getDeliveryTime()%> mins</span>
                            <span class="badge <%="ACTIVE".equals(r.getStatus()) ? "badge-success" : "badge-danger"%>">
                                <%=r.getStatus()%>
                            </span>
                        </div>
                    </div>
                    <div class="rdash-food-actions">
                        <a href="<%=request.getContextPath()%>/AdminToggleRestaurantServlet?restaurantId=<%=r.getRestaurantId()%>&status=<%="ACTIVE".equals(r.getStatus()) ? "INACTIVE" : "ACTIVE"%>"
                           class="<%="ACTIVE".equals(r.getStatus()) ? "rdash-delete-btn" : "rdash-edit-btn"%>">
                            <%="ACTIVE".equals(r.getStatus()) ? "🔴 Deactivate" : "🟢 Activate"%>
                        </a>
                    </div>
                </div>
            <% } } %>
            </div>
        </div>

        <!-- ORDERS TAB -->
        <% } else if ("orders".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">All Orders</h1>
            <p class="rdash-subtitle">View and manage all orders placed on SaveBite</p>

            <div class="rdash-box">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Amount</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th>Tracking</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (allOrders != null) {
                        for (Order o : allOrders) {
                            if (o.getTotalAmount() <= 0) continue;
                    %>
                        <tr>
                            <td>#<%=o.getOrderId()%></td>
                            <td class="order-amount">₹<%=String.format("%.2f", o.getTotalAmount())%></td>
                            <td>
                                <span class="badge <%="Paid".equalsIgnoreCase(o.getPaymentStatus()) ? "badge-success" : "badge-pending"%>">
                                    <%=o.getPaymentStatus()%>
                                </span>
                            </td>
                            <td>
                                <span class="badge <%="Cancelled".equalsIgnoreCase(o.getOrderStatus()) ? "badge-danger" : "badge-info"%>">
                                    <%=o.getOrderStatus()%>
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-info">
                                    <%=o.getTrackingStatus() != null ? o.getTrackingStatus() : "PLACED"%>
                                </span>
                            </td>
                            <td style="color:#94a3b8; font-size:13px;"><%=o.getOrderDate()%></td>
                            <td>
                                <% if (!"Cancelled".equalsIgnoreCase(o.getOrderStatus())) { %>
                                    <a href="<%=request.getContextPath()%>/AdminCancelOrderServlet?orderId=<%=o.getOrderId()%>"
                                       class="rdash-delete-btn"
                                       style="font-size:12px; padding:4px 10px;"
                                       onclick="return confirm('Cancel order #<%=o.getOrderId()%>?')">
                                       ✕ Cancel
                                    </a>
                                <% } else { %>
                                    <span style="color:#64748b; font-size:12px;">Cancelled</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- DONATIONS TAB -->
        <% } else if ("donations".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">All Donations</h1>
            <p class="rdash-subtitle">View and manage all food donations on SaveBite</p>

            <div class="rdash-box">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Food Name</th>
                            <th>Restaurant</th>
                            <th>Quantity</th>
                            <th>Expiry</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (allDonations != null) {
                        for (Donation d : allDonations) { %>
                        <tr>
                            <td>#<%=d.getDonationId()%></td>
                            <td style="color:white; font-weight:600;"><%=d.getFoodName()%></td>
                            <td style="color:#f97316;"><%=d.getRestaurantName()%></td>
                            <td><%=d.getQuantity()%> servings</td>
                            <td style="color:#eab308; font-size:13px;"><%=d.getExpiryTime()%></td>
                            <td>
                                <span class="badge <%="COLLECTED".equals(d.getDonationStatus()) ? "badge-success" : "badge-info"%>">
                                    <%=d.getDonationStatus()%>
                                </span>
                            </td>
                            <td>
                                <a href="<%=request.getContextPath()%>/AdminDeleteDonationServlet?donationId=<%=d.getDonationId()%>"
                                   class="rdash-delete-btn"
                                   style="font-size:12px; padding:4px 10px;"
                                   onclick="return confirm('Delete donation #<%=d.getDonationId()%>?')">
                                   🗑 Delete
                                </a>
                            </td>
                        </tr>
                    <% } } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>

    </div>
</div>

</body>
</html>