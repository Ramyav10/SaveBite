<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>

<%
User user = (User) session.getAttribute("user");
if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Donate Food - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>

<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet">Dashboard</a>
        
        <span class="nav-username">🏪 <%=user != null ? user.getFullName() : ""%></span>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="auth-wrapper">
    <div class="auth-box" style="max-width:600px;">

        <div style="text-align:center; margin-bottom:20px;">
            <span style="font-size:48px;">🤝</span>
        </div>

        <h2 style="color:white; text-align:center; margin-bottom:6px;">Donate Surplus Food</h2>
        <p style="color:#94a3b8; text-align:center; margin-bottom:24px;">
            Help reduce food waste by donating leftover food to NGOs
        </p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="auth-error"><%=error%></div>
        <% } %>

        <form action="<%=request.getContextPath()%>/AddDonationServlet"
              method="post"
              class="auth-form">

            <div class="form-group">
                <label>Food Name</label>
                <input type="text" name="foodName"
                       placeholder="e.g. Chicken Biryani, Veg Meals"
                       required>
            </div>

            <div class="rdash-form-grid">
                <div class="form-group">
                    <label>Quantity (servings)</label>
                    <input type="number" name="quantity"
                           placeholder="e.g. 20" min="1" required>
                </div>
                <div class="form-group">
                    <label>Expiry Time</label>
                    <input type="datetime-local" name="expiryTime" required>
                </div>
            </div>

            <div class="form-group">
                <label>Pickup Address</label>
                <textarea name="pickupAddress" rows="3"
                          placeholder="Enter the address where NGO can collect the food"
                          required></textarea>
            </div>

            <div class="donate-info-box">
                <p>📋 <strong>How it works:</strong></p>
                <p>1. Submit your donation details</p>
                <p>2. NGO partners will see your donation</p>
                <p>3. An NGO will claim and collect the food</p>
                <p>4. You'll see the status update in your dashboard</p>
            </div>

            <div style="display:flex; gap:12px; margin-top:8px;">
                <button type="submit" class="auth-btn"
                        style="background:#22c55e;">
                    🤝 Donate Food
                </button>
                <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet"
                   style="display:block; text-align:center; padding:13px; background:#1e293b; color:#94a3b8; border-radius:8px; text-decoration:none; flex:1;">
                   Cancel
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>