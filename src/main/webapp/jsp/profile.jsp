<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
     
        <a href="<%=request.getContextPath()%>/jsp/cart.jsp" class="cart-link">&#128722;</a>
        <a href="<%=request.getContextPath()%>/jsp/orders.jsp">My Orders</a>
        <span class="nav-username"><%=user.getFullName()%></span>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="profile-wrapper">

    <h1 class="profile-title">My Profile</h1>
    <p class="profile-subtitle">Manage your account details and preferences</p>

    <% String success = request.getParameter("success"); %>
    <% String error = (String) request.getAttribute("error"); %>
    <% if (success != null) { %>
        <div class="auth-success" style="margin-bottom:20px;">✅ <%=success%></div>
    <% } %>
    <% if (error != null) { %>
        <div class="auth-error" style="margin-bottom:20px;">❌ <%=error%></div>
    <% } %>

    <div class="profile-container">

        <!-- LEFT: Avatar + Info -->
        <div class="profile-left">
            <div class="profile-avatar">
                <%=user.getFullName().substring(0,1).toUpperCase()%>
            </div>
            <h2 class="profile-name"><%=user.getFullName()%></h2>
            <p class="profile-email"><%=user.getEmail()%></p>
            <span class="badge badge-info" style="margin-top:8px;"><%=user.getRole()%></span>

            <div class="profile-stats">
                <a href="<%=request.getContextPath()%>/jsp/orders.jsp" class="profile-stat-item">
                    <span class="profile-stat-icon">📦</span>
                    <span class="profile-stat-label">My Orders</span>
                </a>
                <a href="<%=request.getContextPath()%>/jsp/cart.jsp" class="profile-stat-item">
                    <span class="profile-stat-icon">&#128722;</span>
                    <span class="profile-stat-label">My Cart</span>
                </a>
            </div>
        </div>

        <!-- RIGHT: Edit Forms -->
        <div class="profile-right">

            <!-- Edit Profile -->
            <div class="profile-box">
                <h2>Edit Profile</h2>
                <form action="<%=request.getContextPath()%>/UpdateProfileServlet"
                      method="post" class="auth-form">
                    <input type="hidden" name="action" value="updateProfile">

                    <div class="rdash-form-grid">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName"
                                   value="<%=user.getFullName()%>" required>
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phoneNumber"
                                   value="<%=user.getPhoneNumber() != null ? user.getPhoneNumber() : ""%>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" value="<%=user.getEmail()%>"
                               disabled style="opacity:0.5; cursor:not-allowed;">
                        <p style="color:#64748b; font-size:12px; margin-top:4px;">
                            Email cannot be changed
                        </p>
                    </div>

                    <div class="form-group">
                        <label>Delivery Address</label>
                        <textarea name="address" rows="3"
                                  placeholder="Enter your delivery address"><%=user.getAddress() != null ? user.getAddress() : ""%></textarea>
                    </div>

                    <button type="submit" class="auth-btn">Save Changes</button>
                </form>
            </div>

            <!-- Change Password -->
            <div class="profile-box" style="margin-top:24px;">
                <h2>Change Password</h2>
                <form action="<%=request.getContextPath()%>/UpdateProfileServlet"
                      method="post" class="auth-form">
                    <input type="hidden" name="action" value="changePassword">

                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" name="currentPassword"
                               placeholder="Enter current password" required>
                    </div>
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" name="newPassword"
                               placeholder="Enter new password" required>
                    </div>
                    <div class="form-group">
                        <label>Confirm New Password</label>
                        <input type="password" name="confirmPassword"
                               placeholder="Confirm new password" required>
                    </div>

                    <button type="submit" class="auth-btn"
                            style="background:#3b82f6;">Update Password</button>
                </form>
            </div>

        </div>
    </div>
</div>

</body>
</html>