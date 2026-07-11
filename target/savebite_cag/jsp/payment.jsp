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

String paymentMethod = (String) session.getAttribute("paymentMethod");
Integer finalTotal = (Integer) session.getAttribute("finalTotal");
Integer orderId = (Integer) session.getAttribute("orderId");
String deliveryAddress = (String) session.getAttribute("deliveryAddress");

if (orderId == null) {
    OrderDAOImpl dao = new OrderDAOImpl();
    List<Order> orders = dao.getOrdersByUser(user.getUserId());
    Order latestOrder = orders.get(orders.size() - 1);
    orderId = latestOrder.getOrderId();
    finalTotal = (int) latestOrder.getTotalAmount();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment - SaveBite</title>
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
       
        <a href="<%=request.getContextPath()%>/jsp/cart.jsp" class="cart-link">&#128722;</a>
        <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username">👤
    <%=navUser != null ? navUser.getFullName() : ""%>
</a>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="payment-wrapper">
    <h1 class="payment-title">Complete Your Payment</h1>

    <div class="payment-container">

        <!-- LEFT: Payment Form -->
        <div class="payment-left">

            <!-- Order Info -->
            <div class="payment-box">
                <h2>📦 Order Details</h2>
                <div class="order-info-row">
                    <span>Order ID</span>
                    <span>#<%=orderId%></span>
                </div>
                <div class="order-info-row">
                    <span>Amount to Pay</span>
                    <span class="amount-highlight">₹<%=finalTotal%></span>
                </div>
                <% if (deliveryAddress != null) { %>
                <div class="order-info-row">
                    <span>Delivery To</span>
                    <span><%=deliveryAddress%></span>
                </div>
                <% } %>
            </div>

            <!-- UPI Payment -->
            <% if ("UPI".equals(paymentMethod)) { %>
            <div class="payment-box">
                <h2>📱 UPI Payment</h2>
                <form action="<%=request.getContextPath()%>/PaymentServlet" method="post">
                    <input type="hidden" name="orderId" value="<%=orderId%>">
                    <input type="hidden" name="amount" value="<%=finalTotal%>">
                    <input type="hidden" name="paymentMethod" value="UPI">

                    <div class="upi-apps">
                        <label class="upi-option">
                            <input type="radio" name="upiApp" value="GPay" checked>
                            <div class="upi-card">
                                <span>🟢</span>
                                <span>Google Pay</span>
                            </div>
                        </label>
                        <label class="upi-option">
                            <input type="radio" name="upiApp" value="PhonePe">
                            <div class="upi-card">
                                <span>🟣</span>
                                <span>PhonePe</span>
                            </div>
                        </label>
                        <label class="upi-option">
                            <input type="radio" name="upiApp" value="Paytm">
                            <div class="upi-card">
                                <span>🔵</span>
                                <span>Paytm</span>
                            </div>
                        </label>
                        <label class="upi-option">
                            <input type="radio" name="upiApp" value="Other">
                            <div class="upi-card">
                                <span>📲</span>
                                <span>Other UPI</span>
                            </div>
                        </label>
                    </div>

                    <div class="form-group" style="margin-top:20px;">
                        <label>Enter UPI ID</label>
                        <input type="text" name="upiId"
                               placeholder="e.g. yourname@upi" required>
                    </div>

                    <button type="submit" class="pay-btn">Pay ₹<%=finalTotal%> →</button>
                </form>
            </div>

            <!-- CARD Payment -->
            <% } else if ("CARD".equals(paymentMethod)) { %>
            <div class="payment-box">
                <h2>💳 Card Payment</h2>
                <form action="<%=request.getContextPath()%>/PaymentServlet" method="post">
                    <input type="hidden" name="orderId" value="<%=orderId%>">
                    <input type="hidden" name="amount" value="<%=finalTotal%>">
                    <input type="hidden" name="paymentMethod" value="CARD">

                    <div class="form-group">
                        <label>Card Number</label>
                        <input type="text" name="cardNumber"
                               placeholder="1234 5678 9012 3456"
                               maxlength="19" required>
                    </div>
                    <div class="form-group">
                        <label>Cardholder Name</label>
                        <input type="text" name="cardName"
                               placeholder="Name on card" required>
                    </div>
                    <div class="card-row">
                        <div class="form-group">
                            <label>Expiry Date</label>
                            <input type="text" name="expiry"
                                   placeholder="MM/YY" maxlength="5" required>
                        </div>
                        <div class="form-group">
                            <label>CVV</label>
                            <input type="password" name="cvv"
                                   placeholder="•••" maxlength="3" required>
                        </div>
                    </div>

                    <button type="submit" class="pay-btn">Pay ₹<%=finalTotal%> →</button>
                </form>
            </div>

            <!-- NET BANKING -->
            <% } else if ("NETBANKING".equals(paymentMethod)) { %>
            <div class="payment-box">
                <h2>🏦 Net Banking</h2>
                <form action="<%=request.getContextPath()%>/PaymentServlet" method="post">
                    <input type="hidden" name="orderId" value="<%=orderId%>">
                    <input type="hidden" name="amount" value="<%=finalTotal%>">
                    <input type="hidden" name="paymentMethod" value="NETBANKING">

                    <div class="bank-options">
                        <label class="bank-option">
                            <input type="radio" name="bank" value="SBI" checked>
                            <div class="bank-card">🏛 SBI</div>
                        </label>
                        <label class="bank-option">
                            <input type="radio" name="bank" value="HDFC">
                            <div class="bank-card">🏦 HDFC</div>
                        </label>
                        <label class="bank-option">
                            <input type="radio" name="bank" value="ICICI">
                            <div class="bank-card">🏦 ICICI</div>
                        </label>
                        <label class="bank-option">
                            <input type="radio" name="bank" value="AXIS">
                            <div class="bank-card">🏦 Axis</div>
                        </label>
                        <label class="bank-option">
                            <input type="radio" name="bank" value="KOTAK">
                            <div class="bank-card">🏦 Kotak</div>
                        </label>
                        <label class="bank-option">
                            <input type="radio" name="bank" value="OTHER">
                            <div class="bank-card">🏦 Other</div>
                        </label>
                    </div>

                    <button type="submit" class="pay-btn">Pay ₹<%=finalTotal%> →</button>
                </form>
            </div>

            <!-- COD -->
            <% } else { %>
            <div class="payment-box">
                <h2>💵 Cash on Delivery</h2>
                <div class="cod-info">
                    <p>✅ Your order has been placed successfully!</p>
                    <p>💰 Please keep <strong>₹<%=finalTotal%></strong> ready at the time of delivery.</p>
                    <p>🚚 Our delivery partner will collect the payment at your doorstep.</p>
                </div>
                <form action="<%=request.getContextPath()%>/PaymentServlet" method="post">
                    <input type="hidden" name="orderId" value="<%=orderId%>">
                    <input type="hidden" name="amount" value="<%=finalTotal%>">
                    <input type="hidden" name="paymentMethod" value="COD">
                    <button type="submit" class="pay-btn">Confirm Order →</button>
                </form>
            </div>
            <% } %>

        </div>

        <!-- RIGHT: Summary -->
        <div class="payment-summary">
            <h2>🔒 Secure Payment</h2>
            <div class="secure-badges">
                <span class="badge">🔐 SSL Encrypted</span>
                <span class="badge">✅ 100% Secure</span>
                <span class="badge">🛡 PCI Compliant</span>
            </div>
            <div class="summary-divider"></div>
            <div class="summary-row">
                <span>Order ID</span>
                <span>#<%=orderId%></span>
            </div>
            <div class="summary-row">
                <span>Payment Method</span>
                <span><%=paymentMethod != null ? paymentMethod : "COD"%></span>
            </div>
            <div class="summary-row grand">
                <span>Total Amount</span>
                <span>₹<%=finalTotal%></span>
            </div>
            <div class="summary-divider"></div>
            <p class="secure-note">
                🔒 Your payment information is encrypted and secure.
                We never store your card details.
            </p>
        </div>

    </div>
</div>

</body>
</html>