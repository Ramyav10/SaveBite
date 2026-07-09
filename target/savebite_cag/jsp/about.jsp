<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.savebite_cag.model.User"%>
<%
User navUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us - SaveBite</title>
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

<div class="about-wrapper">

    <!-- HERO -->
    <div class="about-hero">
        <h1>About <span style="color:#f97316;">SaveBite</span></h1>
        <p>Connecting food lovers with great restaurants, and surplus food with those who need it most.</p>
    </div>

    <!-- MISSION -->
    <div class="about-section">
        <div class="about-grid">
            <div class="about-card">
                <span class="about-icon">🎯</span>
                <h2>Our Mission</h2>
                <p>To reduce food waste and hunger by connecting restaurants, customers and NGOs on a single platform. Every meal saved is a step towards a sustainable future.</p>
            </div>
            <div class="about-card">
                <span class="about-icon">👁</span>
                <h2>Our Vision</h2>
                <p>A world where no food goes to waste and no person goes hungry. We believe technology can bridge the gap between surplus and need.</p>
            </div>
            <div class="about-card">
                <span class="about-icon">💚</span>
                <h2>Our Values</h2>
                <p>Sustainability, compassion, transparency and innovation drive everything we do at SaveBite. We care about people and the planet.</p>
            </div>
        </div>
    </div>

    <!-- STATS -->
    <div class="about-stats">
        <div class="about-stat">
            <h2>500+</h2>
            <p>Orders Delivered</p>
        </div>
        <div class="about-stat">
            <h2>120+</h2>
            <p>Partner Restaurants</p>
        </div>
        <div class="about-stat">
            <h2>50+</h2>
            <p>NGO Partners</p>
        </div>
        <div class="about-stat">
            <h2>2000+</h2>
            <p>Meals Saved</p>
        </div>
    </div>

    <!-- TEAM -->
    <div class="about-section">
        <h2 class="about-section-title">What We Do</h2>
        <div class="about-grid">
            <div class="about-card">
                <span class="about-icon">🍽</span>
                <h3>Food Delivery</h3>
                <p>Browse hundreds of restaurants, order your favorite food and get it delivered fast to your doorstep.</p>
            </div>
            <div class="about-card">
                <span class="about-icon">🤝</span>
                <h3>Food Rescue</h3>
                <p>Restaurants donate surplus food to verified NGO partners who distribute it to those in need.</p>
            </div>
            <div class="about-card">
                <span class="about-icon">🌱</span>
                <h3>Reduce Waste</h3>
                <p>Every donation and every order helps reduce food waste and builds a more sustainable food system.</p>
            </div>
        </div>
    </div>

    <!-- CONTACT -->
    <div class="about-contact">
        <h2>Get In Touch</h2>
        <p>Have questions or want to partner with us?</p>
        <div class="about-contact-grid">
            <div class="about-contact-item">
                <span>📍</span>
                <p>12 MG Road, Indiranagar, Bangalore 560038, India</p>
            </div>
            <div class="about-contact-item">
                <span>📞</span>
                <p>+91 80 1234 5678</p>
            </div>
            <div class="about-contact-item">
                <span>✉️</span>
                <p>hello@savebite.in</p>
            </div>
        </div>
    </div>

</div>

<!-- FOOTER -->
<footer class="footer-section">
    <div class="footer-bottom">
        <p>&copy; 2026 SaveBite Technologies Pvt. Ltd. All rights reserved.</p>
    </div>
</footer>

</body>
</html>