<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - SaveBite</title>
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
        <h2>Create Account</h2>
        <p class="auth-subtitle">Join SaveBite and start ordering today</p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="auth-error"><%=error%></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="auth-form">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" placeholder="Enter your full name" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phoneNumber" placeholder="Enter your phone number" required>
            </div>
			<div class="form-group">
    <label>Register As</label>
    <select name="role" required>
        <option value="" disabled selected>Select your role</option>
        <option value="CUSTOMER">Customer</option>
        <option value="RESTAURANT">Restaurant Owner</option>
        <option value="NGO">NGO Partner</option>
    </select>
</div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Create a password" required>
            </div>

            <div class="form-group">
                <label>Address</label>
                <textarea name="address" placeholder="Enter your delivery address" rows="3"></textarea>
            </div>

            <button type="submit" class="auth-btn">Create Account</button>

        </form>

        <p class="auth-switch">Already have an account? <a href="<%=request.getContextPath()%>//jsp/login.jsp">Login</a></p>
    </div>
</div>

</body>
</html>