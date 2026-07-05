<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Restaurant"%>
<%@ page import="com.savebite_cag.model.FoodItem"%>
<%@ page import="com.savebite_cag.model.Order"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.model.Donation"%>

<%
User user = (User) session.getAttribute("user");
if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
}

Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
List<FoodItem> foodList = (List<FoodItem>) request.getAttribute("foodList");
List<Order> restaurantOrders = (List<Order>) request.getAttribute("restaurantOrders");
List<Donation> myDonations = (List<Donation>) request.getAttribute("myDonations");
int totalMenuItems = (Integer) request.getAttribute("totalMenuItems");
int totalOrders = request.getAttribute("totalOrders") != null ? (Integer) request.getAttribute("totalOrders") : 0;
int pendingOrders = request.getAttribute("pendingOrders") != null ? (Integer) request.getAttribute("pendingOrders") : 0;
int totalRevenue = request.getAttribute("totalRevenue") != null ? (Integer) request.getAttribute("totalRevenue") : 0;

String activeTab = request.getParameter("tab");
if (activeTab == null) activeTab = "overview";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Dashboard - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet">Dashboard</a>
     
        <span class="nav-username">🏪 <%=user != null ? user.getFullName() : ""%></span>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="rdash-wrapper">

    <!-- SIDEBAR -->
    <div class="rdash-sidebar">
        <div class="rdash-restaurant-info">
            <img src="<%=request.getContextPath()%>/<%=restaurant.getImageUrl()%>"
                 alt="<%=restaurant.getRestaurantName()%>"
                 onerror="this.src='<%=request.getContextPath()%>/images/default-food.jpg'">
            <h3><%=restaurant.getRestaurantName()%></h3>
            <span class="rdash-status-badge <%="ACTIVE".equals(restaurant.getStatus()) ? "rdash-active" : "rdash-inactive"%>">
                <%=restaurant.getStatus()%>
            </span>
        </div>

        <nav class="rdash-nav">
            <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=overview"
               class="rdash-nav-item <%="overview".equals(activeTab) ? "rdash-nav-active" : ""%>">
                📊 Overview
            </a>
            <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=menu"
               class="rdash-nav-item <%="menu".equals(activeTab) ? "rdash-nav-active" : ""%>">
                🍽 Menu Management
            </a>
            <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=orders"
               class="rdash-nav-item <%="orders".equals(activeTab) ? "rdash-nav-active" : ""%>">
                📦 Orders
                <% if (totalOrders > 0) { %>
                    <span class="rdash-orders-badge"><%=totalOrders%></span>
                <% } %>
            </a>
            <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=donations"
               class="rdash-nav-item <%="donations".equals(activeTab) ? "rdash-nav-active" : ""%>">
                🤝 Donations
            </a>
            <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=profile"
               class="rdash-nav-item <%="profile".equals(activeTab) ? "rdash-nav-active" : ""%>">
                ⚙️ Profile
            </a>
        </nav>
    </div>

    <!-- MAIN CONTENT -->
    <div class="rdash-main">

        <!-- OVERVIEW TAB -->
        <% if ("overview".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">Welcome back, <%=user.getFullName()%>! 👋</h1>
            <p class="rdash-subtitle">Here's what's happening at <%=restaurant.getRestaurantName()%> today.</p>

            <div class="rdash-stats">
                <div class="rdash-stat-card">
                    <span class="rdash-stat-icon">🍽</span>
                    <div>
                        <p class="rdash-stat-value"><%=totalMenuItems%></p>
                        <p class="rdash-stat-label">Menu Items</p>
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
                    <span class="rdash-stat-icon">⏳</span>
                    <div>
                        <p class="rdash-stat-value"><%=pendingOrders%></p>
                        <p class="rdash-stat-label">Pending Payments</p>
                    </div>
                </div>
                <div class="rdash-stat-card">
                    <span class="rdash-stat-icon">💰</span>
                    <div>
                        <p class="rdash-stat-value">₹<%=totalRevenue%></p>
                        <p class="rdash-stat-label">Total Revenue</p>
                    </div>
                </div>
            </div>

            <!-- Restaurant Status Toggle -->
            <div class="rdash-box">
                <h2>Restaurant Status</h2>
                <div class="rdash-status-row">
                    <div>
                        <p class="rdash-status-text">Your restaurant is currently
                            <strong class="<%="ACTIVE".equals(restaurant.getStatus()) ? "text-green" : "text-red"%>">
                                <%=restaurant.getStatus()%>
                            </strong>
                        </p>
                        <p class="rdash-status-desc">Customers <%="ACTIVE".equals(restaurant.getStatus()) ? "can" : "cannot"%> place orders from your restaurant.</p>
                    </div>
                    <a href="<%=request.getContextPath()%>/RestaurantStatusServlet?status=<%="ACTIVE".equals(restaurant.getStatus()) ? "INACTIVE" : "ACTIVE"%>&restaurantId=<%=restaurant.getRestaurantId()%>"
                       class="rdash-toggle-btn <%="ACTIVE".equals(restaurant.getStatus()) ? "rdash-toggle-off" : "rdash-toggle-on"%>">
                        <%="ACTIVE".equals(restaurant.getStatus()) ? "Close Restaurant" : "Open Restaurant"%>
                    </a>
                </div>
            </div>

            <!-- Quick Menu Preview -->
            <div class="rdash-box">
                <div class="rdash-box-header">
                    <h2>Menu Preview</h2>
                    <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=menu" class="rdash-link">View All →</a>
                </div>
                <div class="rdash-menu-preview">
                <% if (foodList != null) {
                    int count = 0;
                    for (FoodItem food : foodList) {
                        if (count >= 4) break;
                %>
                    <div class="rdash-menu-item">
                        <img src="<%=request.getContextPath()%>/<%=food.getImageUrl()%>"
                             alt="<%=food.getFoodName()%>"
                             onerror="this.src='<%=request.getContextPath()%>/images/default-food.jpg'">
                        <div class="rdash-menu-item-info">
                            <p class="rdash-menu-item-name"><%=food.getFoodName()%></p>
                            <p class="rdash-menu-item-price">₹<%=(int)food.getPrice()%></p>
                        </div>
                        <span class="badge <%="AVAILABLE".equalsIgnoreCase(food.getFoodStatus()) ? "badge-success" : "badge-danger"%>">
                            <%=food.getFoodStatus()%>
                        </span>
                    </div>
                <%
                        count++;
                    }
                } %>
                </div>
            </div>

            <!-- Recent Orders Preview -->
            <div class="rdash-box">
                <div class="rdash-box-header">
                    <h2>Recent Orders</h2>
                    <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=orders" class="rdash-link">View All →</a>
                </div>
                <% if (restaurantOrders == null || restaurantOrders.isEmpty()) { %>
                    <p class="rdash-empty">No orders yet!</p>
                <% } else {
                    int oCount = 0;
                    for (Order o : restaurantOrders) {
                        if (oCount >= 3) break;
                %>
                    <div class="rdash-recent-order">
                        <span class="order-id-value">#<%=o.getOrderId()%></span>
                        <span style="color:#94a3b8; font-size:13px;">₹<%=String.format("%.2f", o.getTotalAmount())%></span>
                        <span class="badge <%="Paid".equalsIgnoreCase(o.getPaymentStatus()) ? "badge-success" : "badge-pending"%>">
                            <%=o.getPaymentStatus()%>
                        </span>
                        <span class="badge badge-info"><%=o.getTrackingStatus() != null ? o.getTrackingStatus() : "PLACED"%></span>
                    </div>
                <%
                        oCount++;
                    }
                } %>
            </div>
        </div>

        <!-- MENU MANAGEMENT TAB -->
        <% } else if ("menu".equals(activeTab)) { %>
        <div class="rdash-section">
            <div class="rdash-section-header">
                <div>
                    <h1 class="rdash-title">Menu Management</h1>
                    <p class="rdash-subtitle">Add, edit or remove items from your menu</p>
                </div>
                <a href="<%=request.getContextPath()%>/jsp/addFoodItem.jsp" class="rdash-add-btn">+ Add New Item</a>
            </div>

            <% String menuSuccess = request.getParameter("success"); %>
            <% if (menuSuccess != null) { %>
                <div class="auth-success" style="margin-bottom:20px;">✅ <%=menuSuccess%></div>
            <% } %>

            <div class="rdash-menu-list">
            <% if (foodList != null && !foodList.isEmpty()) {
                for (FoodItem food : foodList) { %>
                <div class="rdash-food-card">
                    <img src="<%=request.getContextPath()%>/<%=food.getImageUrl()%>"
                         alt="<%=food.getFoodName()%>"
                         onerror="this.src='<%=request.getContextPath()%>/images/default-food.jpg'">
                    <div class="rdash-food-info">
                        <h3><%=food.getFoodName()%></h3>
                        <p><%=food.getDescription()%></p>
                        <div class="rdash-food-meta">
                            <span class="rdash-food-price">₹<%=(int)food.getPrice()%></span>
                            <span class="rdash-food-time">⏱ <%=food.getDeliveryTime()%> mins</span>
                            <span class="badge <%="AVAILABLE".equalsIgnoreCase(food.getFoodStatus()) ? "badge-success" : "badge-danger"%>">
                                <%=food.getFoodStatus()%>
                            </span>
                        </div>
                    </div>
                    <div class="rdash-food-actions">
                        <a href="<%=request.getContextPath()%>/EditFoodServlet?foodId=<%=food.getFoodId()%>"
                           class="rdash-edit-btn">✏️ Edit</a>
                        <a href="<%=request.getContextPath()%>/ToggleFoodServlet?foodId=<%=food.getFoodId()%>&status=<%="AVAILABLE".equalsIgnoreCase(food.getFoodStatus()) ? "UNAVAILABLE" : "AVAILABLE"%>"
                           class="rdash-toggle-food-btn">
                            <%="AVAILABLE".equalsIgnoreCase(food.getFoodStatus()) ? "🔴 Disable" : "🟢 Enable"%>
                        </a>
                        <a href="<%=request.getContextPath()%>/DeleteFoodServlet?foodId=<%=food.getFoodId()%>"
                           class="rdash-delete-btn"
                           onclick="return confirm('Are you sure you want to delete this item?')">
                            🗑 Delete
                        </a>
                    </div>
                </div>
            <% } } else { %>
                <p class="rdash-empty">No menu items yet. Add your first item!</p>
            <% } %>
            </div>
        </div>

        <!-- ORDERS TAB -->
        <% } else if ("orders".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">Incoming Orders</h1>
            <p class="rdash-subtitle">Manage and update the status of your orders</p>

            <% if (restaurantOrders == null || restaurantOrders.isEmpty()) { %>
                <div class="rdash-box">
                    <p class="rdash-empty">📦 No orders yet for your restaurant.</p>
                </div>
            <% } else { %>
                <div style="display:flex; flex-direction:column; gap:14px;">
                <% for (Order o : restaurantOrders) { %>
                    <div class="rdash-order-card">
                        <div class="rdash-order-header">
                            <div>
                                <span class="order-id-label">ORDER ID</span>
                                <span class="order-id-value">#<%=o.getOrderId()%></span>
                            </div>
                            <span class="order-date"><%=o.getOrderDate()%></span>
                        </div>
                        <div class="rdash-order-body">
                            <div class="order-detail">
                                <span class="order-detail-label">Amount</span>
                                <span class="order-amount">₹<%=String.format("%.2f", o.getTotalAmount())%></span>
                            </div>
                            <div class="order-detail">
                                <span class="order-detail-label">Payment</span>
                                <span class="badge <%="Paid".equalsIgnoreCase(o.getPaymentStatus()) ? "badge-success" : "badge-pending"%>">
                                    <%=o.getPaymentStatus()%>
                                </span>
                            </div>
                            <div class="order-detail">
                                <span class="order-detail-label">Order Status</span>
                                <span class="badge badge-info"><%=o.getOrderStatus()%></span>
                            </div>
                            <div class="order-detail">
                                <span class="order-detail-label">Tracking</span>
                                <span class="badge badge-info">
                                    <%=o.getTrackingStatus() != null ? o.getTrackingStatus() : "PLACED"%>
                                </span>
                            </div>
                        </div>
                        <div class="rdash-order-footer">
                            <span style="color:#94a3b8; font-size:13px;">📍 <%=o.getDeliveryAddress()%></span>
                            <form action="<%=request.getContextPath()%>/UpdateTrackingServlet" method="post"
                                  style="display:flex; gap:8px; align-items:center;">
                                <input type="hidden" name="orderId" value="<%=o.getOrderId()%>">
                                <select name="trackingStatus" class="rdash-tracking-select">
                                    <option <%="PLACED".equals(o.getTrackingStatus()) ? "selected" : ""%> value="PLACED">Placed</option>
                                    <option <%="CONFIRMED".equals(o.getTrackingStatus()) ? "selected" : ""%> value="CONFIRMED">Confirmed</option>
                                    <option <%="PREPARING".equals(o.getTrackingStatus()) ? "selected" : ""%> value="PREPARING">Preparing</option>
                                    <option <%="OUT_FOR_DELIVERY".equals(o.getTrackingStatus()) ? "selected" : ""%> value="OUT_FOR_DELIVERY">Out for Delivery</option>
                                    <option <%="DELIVERED".equals(o.getTrackingStatus()) ? "selected" : ""%> value="DELIVERED">Delivered</option>
                                </select>
                                <button type="submit" class="rdash-update-btn">Update</button>
                            </form>
                        </div>
                    </div>
                <% } %>
                </div>
            <% } %>
        </div>

        <!-- DONATIONS TAB -->
        <% } else if ("donations".equals(activeTab)) { %>
        <div class="rdash-section">
            <div class="rdash-section-header">
                <div>
                    <h1 class="rdash-title">Food Donations</h1>
                    <p class="rdash-subtitle">Donate surplus food to NGOs and reduce waste</p>
                </div>
                <a href="<%=request.getContextPath()%>/jsp/donateFood.jsp"
                   class="rdash-add-btn" style="background:#22c55e;">
                    🤝 Donate Food
                </a>
            </div>

            <% String donationSuccess = request.getParameter("success"); %>
            <% if (donationSuccess != null) { %>
                <div class="auth-success" style="margin-bottom:20px;">✅ <%=donationSuccess%></div>
            <% } %>

            <% if (myDonations == null || myDonations.isEmpty()) { %>
                <div class="rdash-box">
                    <div style="text-align:center; padding:40px;">
                        <span style="font-size:48px;">🤝</span>
                        <p style="color:white; font-size:18px; font-weight:600; margin:16px 0 8px;">No donations yet</p>
                        <p style="color:#94a3b8; margin-bottom:20px;">Start donating surplus food to help those in need!</p>
                        <a href="<%=request.getContextPath()%>/jsp/donateFood.jsp"
                           class="rdash-add-btn" style="background:#22c55e;">
                            🤝 Donate Now
                        </a>
                    </div>
                </div>
            <% } else { %>
                <div style="display:flex; flex-direction:column; gap:14px;">
                <% for (Donation d : myDonations) { %>
                    <div class="rdash-order-card">
                        <div class="rdash-order-header">
                            <div>
                                <span class="order-id-label">DONATION ID</span>
                                <span class="order-id-value">#<%=d.getDonationId()%></span>
                            </div>
                            <span class="order-date"><%=d.getCreatedAt()%></span>
                        </div>
                        <div class="rdash-order-body">
                            <div class="order-detail">
                                <span class="order-detail-label">Food</span>
                                <span style="color:white; font-weight:600;"><%=d.getFoodName()%></span>
                            </div>
                            <div class="order-detail">
                                <span class="order-detail-label">Quantity</span>
                                <span style="color:white; font-weight:600;"><%=d.getQuantity()%> servings</span>
                            </div>
                            <div class="order-detail">
                                <span class="order-detail-label">Expiry</span>
                                <span style="color:#eab308; font-size:13px;"><%=d.getExpiryTime()%></span>
                            </div>
                            <div class="order-detail">
                                <span class="order-detail-label">Status</span>
                                <span class="badge <%="COLLECTED".equals(d.getDonationStatus()) ? "badge-success" : "badge-info"%>">
                                    <%="COLLECTED".equals(d.getDonationStatus()) ? "✓ Collected" : "⏳ Available"%>
                                </span>
                            </div>
                        </div>
                        <div style="padding:12px 20px; border-top:1px solid #1e293b;">
                            <span style="color:#94a3b8; font-size:13px;">📍 <%=d.getPickupAddress()%></span>
                        </div>
                    </div>
                <% } %>
                </div>
            <% } %>
        </div>

        <!-- PROFILE TAB -->
        <% } else if ("profile".equals(activeTab)) { %>
        <div class="rdash-section">
            <h1 class="rdash-title">Restaurant Profile</h1>
            <p class="rdash-subtitle">Update your restaurant information</p>

            <div class="rdash-box">
                <form action="<%=request.getContextPath()%>/UpdateRestaurantServlet" method="post" class="rdash-form">
                    <input type="hidden" name="restaurantId" value="<%=restaurant.getRestaurantId()%>">

                    <div class="rdash-form-grid">
                        <div class="form-group">
                            <label>Restaurant Name</label>
                            <input type="text" name="restaurantName" value="<%=restaurant.getRestaurantName()%>" required>
                        </div>
                        <div class="form-group">
                            <label>Cuisine Type</label>
                            <input type="text" name="cuisineType" value="<%=restaurant.getCuisineType()%>">
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phoneNumber" value="<%=restaurant.getPhoneNumber()%>">
                        </div>
                        <div class="form-group">
                            <label>Delivery Time (mins)</label>
                            <input type="number" name="deliveryTime" value="<%=restaurant.getDeliveryTime()%>">
                        </div>
                        <div class="form-group">
                            <label>Min Price (₹)</label>
                            <input type="number" name="minPrice" value="<%=restaurant.getMinPrice()%>">
                        </div>
                        <div class="form-group">
                            <label>Price Range</label>
                            <select name="priceRange">
                                <option <%="Budget".equals(restaurant.getPriceRange()) ? "selected" : ""%>>Budget</option>
                                <option <%="Mid Range".equals(restaurant.getPriceRange()) ? "selected" : ""%>>Mid Range</option>
                                <option <%="Premium".equals(restaurant.getPriceRange()) ? "selected" : ""%>>Premium</option>
                                <option <%="Fine Dining".equals(restaurant.getPriceRange()) ? "selected" : ""%>>Fine Dining</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="3"><%=restaurant.getDescription()%></textarea>
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <textarea name="address" rows="2"><%=restaurant.getAddress()%></textarea>
                    </div>

                    <button type="submit" class="rdash-save-btn">Save Changes</button>
                </form>
            </div>
        </div>
        <% } %>

    </div>
</div>

</body>
</html>