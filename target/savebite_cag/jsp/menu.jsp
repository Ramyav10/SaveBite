<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.savebite_cag.model.FoodItem"%>
<%@ page import="com.savebite_cag.model.Restaurant"%>
<%@ page import="com.savebite_cag.model.Cart"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.daoimpl.CartDAOImpl"%>

<%
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
List<FoodItem> foodList = (List<FoodItem>) request.getAttribute("foodList");

User user = (User) session.getAttribute("user");
Map<Integer, Cart> cartMap = new HashMap<>();

if (user != null) {
    CartDAOImpl cartDao = new CartDAOImpl();
    List<Cart> cartList = cartDao.getCartByUser(user.getUserId());
    for (Cart c : cartList) {
        cartMap.put(c.getFoodId(), c);
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=restaurant.getRestaurantName()%> Menu - SaveBite</title>
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
        <% if (navUser != null) { %>
            <a href="<%=request.getContextPath()%>/jsp/orders.jsp">My Orders</a>
            <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username">
    👤<%=navUser.getFullName()%>
</a>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
        <% } else { %>
            <a href="<%=request.getContextPath()%>/jsp/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/jsp/register.jsp" class="btn">Sign Up</a>
        <% } %>
    </div>
</div>

<!-- HERO -->
<%
String bannerImg = (restaurant.getCoverImage() != null && !restaurant.getCoverImage().isEmpty())
                    ? restaurant.getCoverImage()
                    : "images/menu-hero.png";
%>

<div class="menu-hero" style="background-image: linear-gradient(rgba(0,0,0,0.65), rgba(0,0,0,0.65)), url('<%=request.getContextPath()%>/<%=bannerImg%>');">
    <div class="restaurant-badge">
        <span class="status-dot"></span>
        <span><%=restaurant.getStatus()%></span>
    </div>
    <div class="hero-overlay">
        <h1 class="restaurant-name-hero"><%=restaurant.getRestaurantName()%></h1>
        <p class="hero-subtitle">Freshly prepared, delivered fast to your doorstep.</p>
    </div>
</div>

<!-- MENU SECTION -->
<div class="menu-section">
    <div class="menu-section-header">
        <h2>Our Menu</h2>
        <p>Choose your favorite dishes and add them to your cart</p>
        <div class="gold-line"></div>
    </div>

    <div class="menu-container">
    <%
    if (foodList != null && foodList.size() > 0) {
        for (FoodItem food : foodList) {
            Cart cartItem = cartMap.get(food.getFoodId());
            boolean inCart = cartItem != null;
            boolean canAdd = restaurant.getStatus().equalsIgnoreCase("ACTIVE")
                          && food.getFoodStatus().equalsIgnoreCase("AVAILABLE");
    %>
        <div class="menu-card" id="food-<%=food.getFoodId()%>">
            <div class="img-wrapper">
                <img src="<%=request.getContextPath()%>/<%=food.getImageUrl()%>"
                     alt="<%=food.getFoodName()%>"
                     onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/default-food.jpg'">
                <span class="featured-badge">Featured</span>
                <span class="rating">⭐ <%=food.getRating()%></span>
            </div>

            <div class="menu-info">
                <h3><%=food.getFoodName()%></h3>
                <p class="desc"><%=food.getDescription()%></p>
                <div class="menu-meta">
                    <span class="menu-price">₹<%=(int)food.getPrice()%></span>
                    <span class="menu-delivery">⏱ <%=food.getDeliveryTime()%> mins</span>
                </div>

                <% if(restaurant.getStatus().equalsIgnoreCase("ACTIVE")) { %>
                    <% if(food.getFoodStatus().equalsIgnoreCase("AVAILABLE")) { %>
                        <span class="available">✓ Available</span>
                    <% } else { %>
                        <span class="not-available">✕ Not Available</span>
                    <% } %>
                <% } else { %>
                    <span class="not-available">Restaurant Closed</span>
                <% } %>

                <% if (canAdd) { %>
                    <% if (inCart) { %>
                        <div class="qty-control">
                            <a href="<%=request.getContextPath()%>/CartServlet?action=decrease&cartId=<%=cartItem.getCartId()%>&quantity=<%=cartItem.getQuantity()%>&restaurantId=<%=food.getRestaurantId()%>&foodId=<%=food.getFoodId()%>#food-<%=food.getFoodId()%>"
                               class="qty-btn">−</a>
                            <span class="qty-count"><%=cartItem.getQuantity()%></span>
                            <a href="<%=request.getContextPath()%>/CartServlet?action=increase&cartId=<%=cartItem.getCartId()%>&quantity=<%=cartItem.getQuantity()%>&restaurantId=<%=food.getRestaurantId()%>&foodId=<%=food.getFoodId()%>#food-<%=food.getFoodId()%>"
                               class="qty-btn">+</a>
                        </div>
                    <% } else { %>
                        <a href="<%=request.getContextPath()%>/CartServlet?action=add&foodId=<%=food.getFoodId()%>&restaurantId=<%=food.getRestaurantId()%>#food-<%=food.getFoodId()%>"
                           class="add-btn">Add to Cart</a>
                    <% } %>
                <% } else { %>
                    <a class="add-btn disabled">Add to Cart</a>
                <% } %>

            </div>
        </div>
    <%
        }
    } else { %>
        <p style="color:#94a3b8; font-size:18px; text-align:center;">No items available.</p>
    <% } %>
    </div>
</div>

</body>
</html>