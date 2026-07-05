<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>
<%
User navUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Privacy Policy - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>

<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
    
        <% if (navUser != null) { %>
            <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username"><%=navUser.getFullName()%></a>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
        <% } else { %>
            <a href="<%=request.getContextPath()%>/jsp/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/jsp/register.jsp" class="btn">Sign Up</a>
        <% } %>
    </div>
</div>

<div class="policy-wrapper">
    <h1 class="policy-title">Privacy Policy</h1>
    <p class="policy-date">Last updated: July 2026</p>

    <div class="policy-box">

        <div class="policy-section">
            <h2>1. Information We Collect</h2>
            <p>We collect information you provide directly to us, such as when you create an account, place an order, or contact us for support. This includes:</p>
            <ul>
                <li>Name, email address and password</li>
                <li>Phone number and delivery address</li>
                <li>Payment information (processed securely)</li>
                <li>Order history and preferences</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>2. How We Use Your Information</h2>
            <p>We use the information we collect to:</p>
            <ul>
                <li>Process and deliver your orders</li>
                <li>Send order confirmations and updates</li>
                <li>Improve our services and user experience</li>
                <li>Communicate with you about promotions and offers</li>
                <li>Prevent fraud and ensure platform security</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>3. Information Sharing</h2>
            <p>We do not sell, trade, or rent your personal information to third parties. We may share your information with:</p>
            <ul>
                <li>Restaurant partners to fulfill your orders</li>
                <li>NGO partners for food donation coordination</li>
                <li>Payment processors to handle transactions</li>
                <li>Law enforcement when required by law</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>4. Data Security</h2>
            <p>We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure or destruction. All payment information is encrypted using SSL technology.</p>
        </div>

        <div class="policy-section">
            <h2>5. Cookies</h2>
            <p>We use cookies and similar tracking technologies to track activity on our platform and hold certain information. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent.</p>
        </div>

        <div class="policy-section">
            <h2>6. Your Rights</h2>
            <p>You have the right to:</p>
            <ul>
                <li>Access your personal information</li>
                <li>Correct inaccurate data</li>
                <li>Request deletion of your account</li>
                <li>Opt out of marketing communications</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>7. Contact Us</h2>
            <p>If you have any questions about this Privacy Policy, please contact us at:</p>
            <p style="color:#f97316; margin-top:8px;">hello@savebite.in</p>
            <p style="color:#94a3b8;">+91 80 1234 5678</p>
        </div>

    </div>
</div>

<footer class="footer-section">
    <div class="footer-bottom">
        <p>&copy; 2026 SaveBite Technologies Pvt. Ltd. All rights reserved.</p>
    </div>
</footer>

</body>
</html>