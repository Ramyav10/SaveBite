<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>
<%
User navUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Terms of Service - SaveBite</title>
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
    <h1 class="policy-title">Terms of Service</h1>
    <p class="policy-date">Last updated: July 2026</p>

    <div class="policy-box">

        <div class="policy-section">
            <h2>1. Acceptance of Terms</h2>
            <p>By accessing and using SaveBite, you accept and agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our platform.</p>
        </div>

        <div class="policy-section">
            <h2>2. Use of Platform</h2>
            <p>SaveBite provides a platform for food ordering and food rescue. You agree to:</p>
            <ul>
                <li>Provide accurate and complete information when registering</li>
                <li>Maintain the security of your account credentials</li>
                <li>Use the platform only for lawful purposes</li>
                <li>Not misuse or attempt to hack the platform</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>3. Orders and Payments</h2>
            <p>When you place an order on SaveBite:</p>
            <ul>
                <li>You agree to pay the full amount including taxes and fees</li>
                <li>Orders are subject to restaurant availability</li>
                <li>Refunds are processed as per our refund policy</li>
                <li>Payment information is encrypted and secure</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>4. Food Donations</h2>
            <p>For restaurants and NGOs using our food rescue feature:</p>
            <ul>
                <li>Donated food must be safe for consumption</li>
                <li>Accurate expiry times must be provided</li>
                <li>NGOs are responsible for timely collection</li>
                <li>SaveBite is not liable for food quality disputes</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2>5. User Accounts</h2>
            <p>SaveBite reserves the right to suspend or terminate accounts that violate these terms. Users are responsible for all activities that occur under their account.</p>
        </div>

        <div class="policy-section">
            <h2>6. Intellectual Property</h2>
            <p>All content on SaveBite including logos, images, and text is the property of SaveBite Technologies Pvt. Ltd. and may not be used without permission.</p>
        </div>

        <div class="policy-section">
            <h2>7. Limitation of Liability</h2>
            <p>SaveBite shall not be liable for any indirect, incidental, special or consequential damages resulting from the use or inability to use our services.</p>
        </div>

        <div class="policy-section">
            <h2>8. Changes to Terms</h2>
            <p>We reserve the right to modify these terms at any time. Continued use of the platform after changes constitutes acceptance of the new terms.</p>
        </div>

        <div class="policy-section">
            <h2>9. Contact Us</h2>
            <p>For questions about these Terms of Service, contact us at:</p>
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