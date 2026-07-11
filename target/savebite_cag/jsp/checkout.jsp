<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.model.Cart"%>
<%@ page import="com.savebite_cag.model.FoodItem"%>
<%@ page import="com.savebite_cag.daoimpl.CartDAOImpl"%>
<%@ page import="com.savebite_cag.daoimpl.FoodDAOImpl"%>
<%@ page import="java.util.List"%>

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
for (Cart cart : cartList) {
    FoodItem food = foodDao.getFoodById(cart.getFoodId());
    grandTotal += food.getPrice() * cart.getQuantity();
}
double tax = grandTotal * 0.05;
double finalTotal = grandTotal + tax;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout - SaveBite</title>
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
        <a href="<%=request.getContextPath()%>/jsp/orders.jsp">My Orders</a>
        <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username">👤
    <%=navUser != null ? navUser.getFullName() : ""%>
</a>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="checkout-wrapper">
    <h1 class="checkout-title">Checkout</h1>

    <form action="<%=request.getContextPath()%>/CheckoutServlet" method="post">
    <div class="checkout-container">

        <!-- LEFT: Delivery + Payment -->
        <div class="checkout-left">

            <!-- Delivery Address -->
            <div class="checkout-box">
                <h2>📍 Delivery Address</h2>
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName"
                           value="<%=user.getFullName()%>" required>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phone"
                           value="<%=user.getPhoneNumber()%>" required>
                </div>
                <div class="form-group">
                    <label>Delivery Address</label>
                    <textarea name="address" rows="3"
                              required><%=user.getAddress() != null ? user.getAddress() : ""%></textarea>
                </div>
                <div class="form-group">
                    <label>Delivery Instructions (Optional)</label>
                    <input type="text" name="instructions"
                           placeholder="e.g. Ring the bell, Leave at door">
                </div>
            </div>

            <!-- Payment Method -->
            <div class="checkout-box">
                <h2>💳 Payment Method</h2>

                <div class="payment-options">

                    <label class="payment-option">
                        <input type="radio" name="paymentMethod"
                               value="COD" checked>
                        <div class="payment-card">
                            <span class="payment-icon">💵</span>
                            <div>
                                <p class="payment-title">Cash on Delivery</p>
                                <p class="payment-desc">Pay when your order arrives</p>
                            </div>
                        </div>
                    </label>

                    <label class="payment-option">
                        <input type="radio" name="paymentMethod"
                               value="UPI">
                        <div class="payment-card">
                            <span class="payment-icon">📱</span>
                            <div>
                                <p class="payment-title">UPI Payment</p>
                                <p class="payment-desc">GPay, PhonePe, Paytm</p>
                            </div>
                        </div>
                    </label>

                    <label class="payment-option">
                        <input type="radio" name="paymentMethod"
                               value="CARD">
                        <div class="payment-card">
                            <span class="payment-icon">💳</span>
                            <div>
                                <p class="payment-title">Credit / Debit Card</p>
                                <p class="payment-desc">Visa, Mastercard, RuPay</p>
                            </div>
                        </div>
                    </label>

                    <label class="payment-option">
                        <input type="radio" name="paymentMethod"
                               value="NETBANKING">
                        <div class="payment-card">
                            <span class="payment-icon">🏦</span>
                            <div>
                                <p class="payment-title">Net Banking</p>
                                <p class="payment-desc">All major banks supported</p>
                            </div>
                        </div>
                    </label>

                </div>
            </div>

        </div>

        <!-- RIGHT: Order Summary -->
        <div class="checkout-summary">
            <h2>🧾 Order Summary</h2>

            <div class="checkout-items">
            <%
            for (Cart cart : cartList) {
                FoodItem food = foodDao.getFoodById(cart.getFoodId());
                double itemTotal = food.getPrice() * cart.getQuantity();
            %>
                <div class="checkout-item">
                    <div class="checkout-item-info">
                        <img src="<%=request.getContextPath()%>/<%=food.getImageUrl()%>"
                             alt="<%=food.getFoodName()%>"
                             onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/images/default-food.jpg'">
                        <div>
                            <p class="checkout-item-name"><%=food.getFoodName()%></p>
                            <p class="checkout-item-qty">x<%=cart.getQuantity()%></p>
                        </div>
                    </div>
                    <span class="checkout-item-price">₹<%=(int)itemTotal%></span>
                </div>
            <% } %>
            </div>

            <div class="summary-divider"></div>

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
                <span>₹<%=(int)tax%></span>
            </div>

            <div class="summary-divider"></div>

            <div class="summary-row grand">
                <span>Grand Total</span>
                <span>₹<%=(int)finalTotal%></span>
            </div>

            <input type="hidden" name="totalAmount" value="<%=(int)finalTotal%>">

            <button type="submit" class="checkout-btn">
                Place Order →
            </button>

            <a href="/savebite_cag/jsp/cart.jsp" class="continue-btn">
                ← Back to Cart
            </a>
        </div>

    </div>
    </form>
</div>

</body>
</html>