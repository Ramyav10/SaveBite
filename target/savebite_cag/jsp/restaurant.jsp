<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.savebite_cag.model.Restaurant"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurants</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css?v=7">
</head>
<body>
<%@ page import="com.savebite_cag.model.User"%>
<%
User navUser = (User) session.getAttribute("user");
%>
<div class="navbar">
    <div class="logo">SaveBite</div>
    <div class="nav-links">
        <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
        <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
       
       
        <% if (navUser != null) { %>
            <a href="<%=request.getContextPath()%>/jsp/cart.jsp" class="cart-link">&#128722;</a>
            <a href="<%=request.getContextPath()%>/jsp/orders.jsp">My Orders</a>
            <a href="<%=request.getContextPath()%>/jsp/profile.jsp" class="nav-username">👤
    <%=navUser != null ? navUser.getFullName() : ""%>
</a>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
        <% } else { %>
            <a href="<%=request.getContextPath()%>/jsp/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/jsp/register.jsp" class="btn">Sign Up</a>
        <% } %>
    </div>
</div>


<section class="restaurants">
  <h1>Order Food</h1>
  <p class="subtitle">11 restaurants found</p>

  <!-- Search and filters -->
  <div class="filters-wrapper">
  <form action="RestaurantServlet" method="get" class="filters">
  <input type="text" name="search" placeholder="Search restaurants, cuisines..." class="search-bar">
  <select name="sort" class="sort-dropdown" onchange="this.form.submit()">
    <option value="default">Sort By</option>
    <option value="rating">Top Rated</option>
    <option value="fast">Fast Delivery</option>
    <option value="low">Low Price</option>
  </select>
 <button type="submit" name="status" value="ACTIVE" class="open-now">Open Now</button>
 
</form>
  </div>

  <!-- Category buttons -->
  <% String selectedCuisine = request.getParameter("cuisine");
   if(selectedCuisine == null) selectedCuisine = "All"; %>

<div class="categories">
  <a href="RestaurantServlet?cuisine=All" class="cat-btn <%= "All".equals(selectedCuisine) ? "active" : "" %>">All</a>
  <a href="RestaurantServlet?cuisine=Biryani" class="cat-btn <%= "Biryani".equals(selectedCuisine) ? "active" : "" %>">Biryani</a>
  <a href="RestaurantServlet?cuisine=Pizza" class="cat-btn <%= "Pizza".equals(selectedCuisine) ? "active" : "" %>">Pizza</a>
  <a href="RestaurantServlet?cuisine=Burgers" class="cat-btn <%= "Burgers".equals(selectedCuisine) ? "active" : "" %>">Burgers</a>
  <a href="RestaurantServlet?cuisine=South+Indian" class="cat-btn <%= "South Indian".equals(selectedCuisine) ? "active" : "" %>">South Indian</a>
  <a href="RestaurantServlet?cuisine=Chinese" class="cat-btn <%= "Chinese".equals(selectedCuisine) ? "active" : "" %>">Chinese</a>
  <a href="RestaurantServlet?cuisine=North+Indian" class="cat-btn <%= "North Indian".equals(selectedCuisine) ? "active" : "" %>">North Indian</a>
  <a href="RestaurantServlet?cuisine=Cafe" class="cat-btn <%= "Cafe".equals(selectedCuisine) ? "active" : "" %>">Cafe</a>
  <a href="RestaurantServlet?cuisine=Cakes" class="cat-btn <%= "Cakes".equals(selectedCuisine) ? "active" : "" %>">Cakes</a>
  <a href="RestaurantServlet?cuisine=Shakes" class="cat-btn <%= "Shakes".equals(selectedCuisine) ? "active" : "" %>">Shakes</a>
  <a href="RestaurantServlet?cuisine=Rolls" class="cat-btn <%= "Rolls".equals(selectedCuisine) ? "active" : "" %>">Rolls</a>
  <a href="RestaurantServlet?cuisine=Japanese" class="cat-btn <%= "Japanese".equals(selectedCuisine) ? "active" : "" %>">Japanese</a>
</div>
  

  <!-- Restaurant cards -->
  <div class="restaurant-grid">
    <% 
    List<Restaurant> restaurantList = (List<Restaurant>)request.getAttribute("restaurantList");
    if(restaurantList != null){
      for(Restaurant r : restaurantList){
    %>
      <div class="restaurant-card">
    <img src="<%=r.getImageUrl()%>" alt="<%=r.getRestaurantName()%>">
    <span class="featured-badge">Featured</span>
    <span class="rating">&#11088; <%=r.getRating()%></span>
    <div class="card-content">
        <h2><%=r.getRestaurantName()%></h2>
        <p class="card-cuisine"><%=r.getCuisineType()%></p>
        <p class="card-desc"><%=r.getDescription()%></p>
        
        <div class="card-meta">
<span>&#128337; <%=r.getDeliveryTime()%> min</span>

    <span>Min. &#8377;<%=r.getMinPrice()%></span>
    
    <span> <%=r.getPriceRange()%></span>
        </div>
        <a href="<%=request.getContextPath()%>/FoodServlet?restaurantId=<%=r.getRestaurantId()%>" class="menu-btn">
            View Menu
        </a>
    </div>
</div>
    <% } } %>
  </div>
</section>


</body>
</html>
