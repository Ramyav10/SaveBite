<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.model.FoodItem"%>

<%
User user = (User) session.getAttribute("user");
if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
}

FoodItem food = (FoodItem) request.getAttribute("food");
if (food == null) {
    response.sendRedirect(request.getContextPath() + "/RestaurantDashboardServlet?tab=menu");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Food Item - SaveBite</title>
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
        <h2 style="color:white; margin-bottom:6px;">Edit Menu Item</h2>
        <p style="color:#94a3b8; margin-bottom:24px;">Update details for <%=food.getFoodName()%></p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="auth-error"><%=error%></div>
        <% } %>

        <form action="<%=request.getContextPath()%>/UpdateFoodServlet"
              method="post"
              enctype="multipart/form-data"
              class="auth-form">

            <input type="hidden" name="foodId" value="<%=food.getFoodId()%>">
            <input type="hidden" name="existingImage" value="<%=food.getImageUrl()%>">

            <div class="rdash-form-grid">
                <div class="form-group">
                    <label>Food Name</label>
                    <input type="text" name="foodName" value="<%=food.getFoodName()%>" required>
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <input type="text" name="category" value="<%=food.getCategory()%>">
                </div>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="3"><%=food.getDescription()%></textarea>
            </div>

            <div class="rdash-form-grid">
                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" name="price" value="<%=(int)food.getPrice()%>" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>Delivery Time (mins)</label>
                    <input type="number" name="deliveryTime" value="<%=food.getDeliveryTime()%>">
                </div>
            </div>

            <div class="rdash-form-grid">
                <div class="form-group">
                    <label>Rating</label>
                    <input type="number" name="rating" value="<%=food.getRating()%>" step="0.1" min="0" max="5">
                </div>
                <div class="form-group">
                    <label>Available Quantity</label>
                    <input type="number" name="availableQuantity" value="<%=food.getAvailableQuantity()%>">
                </div>
            </div>

            <!-- Current Image Preview -->
            <div class="form-group">
                <label>Current Image</label>
                <% if (food.getImageUrl() != null && !food.getImageUrl().isEmpty()) { %>
                    <img src="<%=request.getContextPath()%>/<%=food.getImageUrl()%>"
                         onerror="this.src='<%=request.getContextPath()%>/images/default-food.jpg'"
                         style="width:100px; height:100px; object-fit:cover; border-radius:10px; display:block; margin-bottom:10px; border:2px solid #1e293b;">
                <% } %>
                <label>Change Image</label>
                <input type="file" name="imageFile" accept="image/*" class="file-input">
                <p style="color:#64748b; font-size:12px; margin-top:6px;">
                    Leave empty to keep current image. Accepted: JPG, PNG, WEBP (max 2MB)
                </p>
            </div>

            <div class="form-group">
                <label>Status</label>
                <select name="foodStatus">
                    <option value="AVAILABLE" <%="AVAILABLE".equalsIgnoreCase(food.getFoodStatus()) ? "selected" : ""%>>Available</option>
                    <option value="UNAVAILABLE" <%="UNAVAILABLE".equalsIgnoreCase(food.getFoodStatus()) ? "selected" : ""%>>Unavailable</option>
                </select>
            </div>

            <div style="display:flex; gap:12px; margin-top:8px;">
                <button type="submit" class="auth-btn">Save Changes</button>
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