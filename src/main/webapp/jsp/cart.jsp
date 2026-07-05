<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Cart"%>
<%@ page import="com.savebite_cag.model.FoodItem"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.daoimpl.CartDAOImpl"%>
<%@ page import="com.savebite_cag.daoimpl.FoodDAOImpl"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

CartDAOImpl cartDao = new CartDAOImpl();
FoodDAOImpl foodDao = new FoodDAOImpl();
List<Cart> cartList = cartDao.getCartByUser(user.getUserId());
double grandTotal = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cart - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>
<%@ page import="com.savebite_cag.model.User"%>
<%
User navUser = (User) session.getAttribute("user");
%>

<!-- NAVBAR -->

<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
        <a href="<%=request.getContextPath()%>/jsp/cart.jsp" class="cart-link">&#128722;</a>
        <a href="<%=request.getContextPath()%>/jsp/orders.jsp">My Orders</a>
        <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username">👤
    <%=navUser != null ? navUser.getFullName() : ""%>
</a>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="cart-wrapper">

    <h1 class="cart-title">🛒 My Cart</h1>

    <% if (cartList == null || cartList.isEmpty()) { %>
        <div class="cart-empty">
            <p>🍽️ Your cart is empty!</p>
            <a href="/savebite_cag/RestaurantServlet" class="btn">Browse Restaurants</a>
        </div>
    <% } else { %>

    <div class="cart-container">

        <!-- LEFT: Cart Items -->
        <div class="cart-items">
        <%
        for (Cart cart : cartList) {
            FoodItem food = foodDao.getFoodById(cart.getFoodId());
            double total = food.getPrice() * cart.getQuantity();
            grandTotal += total;
        %>
            <div class="cart-card">
                <div class="cart-img">
                    <img src="<%=request.getContextPath()%>/<%=food.getImageUrl()%>"
                         alt="<%=food.getFoodName()%>"
                         onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/default-food.jpg'">
                </div>
                <div class="cart-details">
                    <h3><%=food.getFoodName()%></h3>
                    <p class="cart-desc"><%=food.getDescription()%></p>
                    <span class="cart-price">₹<%=(int)food.getPrice()%></span>
                </div>
                <div class="cart-actions">
                    <div class="cart-qty">
    <a href="<%=request.getContextPath()%>/CartServlet?action=decrease&cartId=<%=cart.getCartId()%>&quantity=<%=cart.getQuantity()%>&foodId=<%=cart.getFoodId()%>&fromCart=true"
       class="qty-btn">−</a>
    <span class="qty-count"><%=cart.getQuantity()%></span>
    <a href="<%=request.getContextPath()%>/CartServlet?action=increase&cartId=<%=cart.getCartId()%>&quantity=<%=cart.getQuantity()%>&foodId=<%=cart.getFoodId()%>&fromCart=true"
       class="qty-btn">+</a>
</div>
                    <p class="cart-total">₹<%=(int)total%></p>
                    <a href="<%=request.getContextPath()%>/CartServlet?action=remove&cartId=<%=cart.getCartId()%>"
                       class="cart-remove">🗑 Remove</a>
                </div>
            </div>
        <% } %>
        </div>

        <!-- RIGHT: Order Summary -->
        <div class="cart-summary">
            <h2>Order Summary</h2>
            <div class="summary-row">
                <span>Subtotal</span>
                <span>₹<%=(int)grandTotal%></span>
            </div>
            <div class="summary-row">
                <span>Delivery Fee</span>
                <span class="free">FREE</span>
            </div>
            <div class="summary-row">
                <span>Taxes (5%)</span>
                <span>₹<%=(int)(grandTotal * 0.05)%></span>
            </div>
            <div class="summary-divider"></div>
            <div class="summary-row grand">
                <span>Grand Total</span>
                <span>₹<%=(int)(grandTotal + grandTotal * 0.05)%></span>
            </div>
            <a href="<%=request.getContextPath()%>/jsp/checkout.jsp" class="checkout-btn">
                Proceed to Checkout →
            </a>
            <a href="/savebite_cag/RestaurantServlet" class="continue-btn">
                ← Continue Shopping
            </a>
        </div>

    </div>
    <% } %>
</div>

</body>
</html>