<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - SaveBite</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>

<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
    
        <a href="<%=request.getContextPath()%>/jsp/login.jsp">Login</a>
        <a href="<%=request.getContextPath()%>/jsp/register.jsp" class="btn">Sign Up</a>
    </div>
</div>

<div class="auth-wrapper">
    <div class="auth-box">
        <div class="auth-logo">Save<span>Bite</span></div>
        <h2>Welcome Back</h2>
        <p class="auth-subtitle">Login to your SaveBite account</p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="auth-error"><%=error%></div>
        <% } %>
		<!-- ADD THIS for success message from register -->
<% String success = request.getParameter("success"); %>
<% if (success != null) { %>
    <div class="auth-success"><%=success%></div>
<% } %>
        <form action="<%=request.getContextPath()%>/LoginServlet" method="post">

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="auth-btn">Login</button>

        </form>

        <p class="auth-switch">Don't have an account? <a href="<%=request.getContextPath()%>//jsp/register.jsp">Sign Up</a></p>
    </div>
</div>

</body>
</html>