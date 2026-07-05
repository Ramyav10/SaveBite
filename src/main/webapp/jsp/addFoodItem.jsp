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
<title>Add Food Item - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>

<%@ page import="com.savebite_cag.model.User"%>
<%
User navUser = (User) session.getAttribute("user");
%>

<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet">Dashboard</a>
        
        <span class="nav-username">🏪 <%=navUser != null ? navUser.getFullName() : ""%></span>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="auth-wrapper">
    <div class="auth-box" style="max-width:600px;">
        <h2 style="color:white; margin-bottom:6px;">Add New Menu Item</h2>
        <p style="color:#94a3b8; margin-bottom:24px;">Add a new dish to your restaurant menu</p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="auth-error"><%=error%></div>
        <% } %>

        <form action="<%=request.getContextPath()%>/AddFoodServlet"
              method="post"
              enctype="multipart/form-data"
              class="auth-form">

            <div class="rdash-form-grid">
                <div class="form-group">
                    <label>Food Name</label>
                    <input type="text" name="foodName"
                           placeholder="e.g. Chicken Biryani" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <input type="text" name="category"
                           placeholder="e.g. Biryani, Starter">
                </div>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description"
                          placeholder="Describe your dish..." rows="3"></textarea>
            </div>

            <div class="rdash-form-grid">
                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" name="price"
                           placeholder="e.g. 250" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>Delivery Time (mins)</label>
                    <input type="number" name="deliveryTime"
                           placeholder="e.g. 30">
                </div>
            </div>

            <div class="rdash-form-grid">
                <div class="form-group">
                    <label>Rating</label>
                    <input type="number" name="rating"
                           placeholder="e.g. 4.5" step="0.1" min="0" max="5">
                </div>
                <div class="form-group">
                    <label>Available Quantity</label>
                    <input type="number" name="availableQuantity"
                           placeholder="e.g. 50">
                </div>
            </div>

            <div class="form-group">
                <label>Food Image</label>
                <input type="file" name="imageFile"
                       accept="image/*" class="file-input" required>
                <p style="color:#64748b; font-size:12px; margin-top:6px;">
                    Accepted: JPG, PNG, WEBP (max 2MB)
                </p>
            </div>

            <div class="form-group">
                <label>Status</label>
                <select name="foodStatus">
                    <option value="AVAILABLE">Available</option>
                    <option value="UNAVAILABLE">Unavailable</option>
                </select>
            </div>

            <div style="display:flex; gap:12px; margin-top:8px;">
                <button type="submit" class="auth-btn">Add Item</button>
                <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet?tab=menu"
                   style="display:block; text-align:center; padding:13px; background:#1e293b; color:#94a3b8; border-radius:8px; text-decoration:none; flex:1;">
                   Cancel
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>