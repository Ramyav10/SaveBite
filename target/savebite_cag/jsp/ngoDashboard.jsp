<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Donation"%>
<%@ page import="com.savebite_cag.model.User"%>
<%@ page import="com.savebite_cag.daoimpl.DonationDAOImpl"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
}

DonationDAOImpl dao = new DonationDAOImpl();
String status = request.getParameter("status");
List<Donation> donations;

if (status == null || status.isEmpty()) {
    donations = dao.getAllDonations();
} else {
    donations = dao.getDonationsByStatus(status);
}

int availableCount = dao.getDonationsByStatus("AVAILABLE").size();
int collectedCount = dao.getDonationsByStatus("COLLECTED").size();
int totalCount = dao.getAllDonations().size();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NGO Dashboard - SaveBite Rescue Hub</title>
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
        <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp">Rescue Hub</a>
      
        <span class="nav-username">🤝 <%=navUser != null ? navUser.getFullName() : ""%></span>
        <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
    </div>
</div>

<div class="ngo-wrapper">

    <!-- HEADER -->
    <div class="ngo-header">
        <div>
            <h1 class="ngo-title">🤝 Rescue Hub</h1>
            <p class="ngo-subtitle">Claim available food donations from restaurants and help feed those in need</p>
        </div>
    </div>
    <% String successMsg = request.getParameter("success"); %>
<% String errorMsg = request.getParameter("error"); %>

<% if (successMsg != null) { %>
    <div class="auth-success" style="margin-bottom:20px;">✅ <%=successMsg%></div>
<% } %>

<% if (errorMsg != null) { %>
    <div class="auth-error" style="margin-bottom:20px;">❌ <%=errorMsg%></div>
<% } %>

    <!-- STATS -->
    <div class="rdash-stats" style="margin-bottom:32px;">
        <div class="rdash-stat-card">
            <span class="rdash-stat-icon">📋</span>
            <div>
                <p class="rdash-stat-value"><%=totalCount%></p>
                <p class="rdash-stat-label">Total Donations</p>
            </div>
        </div>
        <div class="rdash-stat-card">
            <span class="rdash-stat-icon">✅</span>
            <div>
                <p class="rdash-stat-value"><%=availableCount%></p>
                <p class="rdash-stat-label">Available Now</p>
            </div>
        </div>
        <div class="rdash-stat-card">
            <span class="rdash-stat-icon">🚚</span>
            <div>
                <p class="rdash-stat-value"><%=collectedCount%></p>
                <p class="rdash-stat-label">Collected</p>
            </div>
        </div>
        <div class="rdash-stat-card">
            <span class="rdash-stat-icon">🍽</span>
            <div>
                <p class="rdash-stat-value">
                    <%
                    int totalServings = 0;
                    for (Donation d : dao.getAllDonations()) {
                        totalServings += d.getQuantity();
                    }
                    %>
                    <%=totalServings%>
                </p>
                <p class="rdash-stat-label">Total Servings</p>
            </div>
        </div>
    </div>

    <!-- FILTER TABS -->
    <div class="ngo-filter-tabs">
        <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp"
           class="ngo-tab <%=(status == null) ? "ngo-tab-active" : ""%>">
            All Donations
        </a>
        <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp?status=AVAILABLE"
           class="ngo-tab <%="AVAILABLE".equals(status) ? "ngo-tab-active" : ""%>">
            🟢 Available
        </a>
        <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp?status=COLLECTED"
           class="ngo-tab <%="COLLECTED".equals(status) ? "ngo-tab-active" : ""%>">
            ✅ Collected
        </a>
    </div>

    <!-- DONATIONS LIST -->
    <% if (donations == null || donations.isEmpty()) { %>
        <div class="rdash-box" style="text-align:center; padding:60px;">
            <span style="font-size:48px;">📭</span>
            <p style="color:white; font-size:18px; font-weight:600; margin:16px 0 8px;">
                No donations found
            </p>
            <p style="color:#94a3b8;">
                Check back later for available food donations from restaurants.
            </p>
        </div>
    <% } else { %>
        <div class="ngo-donations-grid">
        <% for (Donation d : donations) {
            boolean isAvailable = "AVAILABLE".equalsIgnoreCase(d.getDonationStatus());
        %>
            <div class="ngo-donation-card <%=isAvailable ? "" : "ngo-card-collected"%>">

                <!-- Card Header -->
                <div class="ngo-card-header">
                    <div class="ngo-card-icon">🍱</div>
                    <span class="badge <%=isAvailable ? "badge-success" : "badge-info"%>">
                        <%=isAvailable ? "✓ Available" : "✓ Collected"%>
                    </span>
                </div>

                <!-- Food Info -->
                <div class="ngo-card-body">
                    <h3 class="ngo-food-name"><%=d.getFoodName()%></h3>
                    <p class="ngo-restaurant-name">🏪 <%=d.getRestaurantName()%></p>

                    <div class="ngo-info-grid">
                        <div class="ngo-info-item">
                            <span class="ngo-info-label">Quantity</span>
                            <span class="ngo-info-value"><%=d.getQuantity()%> servings</span>
                        </div>
                        <div class="ngo-info-item">
                            <span class="ngo-info-label">Donation ID</span>
                            <span class="ngo-info-value">#<%=d.getDonationId()%></span>
                        </div>
                        <div class="ngo-info-item" style="grid-column:span 2;">
                            <span class="ngo-info-label">⏰ Expiry Time</span>
                            <span class="ngo-info-value" style="color:#eab308;"><%=d.getExpiryTime()%></span>
                        </div>
                        <div class="ngo-info-item" style="grid-column:span 2;">
                            <span class="ngo-info-label">📍 Pickup Address</span>
                            <span class="ngo-info-value"><%=d.getPickupAddress()%></span>
                        </div>
                    </div>
                </div>

                <!-- Action -->
                <div class="ngo-card-footer">
                    <% if (isAvailable) { %>
                        <a href="<%=request.getContextPath()%>/AcceptDonationServlet?donationId=<%=d.getDonationId()%>"
                           class="ngo-claim-btn"
                           onclick="return confirm('Confirm claiming this donation from <%=d.getRestaurantName()%>?')">
                            🚚 Claim Donation
                        </a>
                    <% } else { %>
                        <div class="ngo-claimed-label">
                            ✅ Already Collected
                        </div>
                    <% } %>
                </div>

            </div>
        <% } %>
        </div>
    <% } %>

</div>

</body>
</html>