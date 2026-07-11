<%@ page import="com.savebite_cag.model.User" %>

<%
/*
User user = (User)session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
*/
%>
<%
User user = (User) session.getAttribute("user");
if (user != null && "RESTAURANT".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/RestaurantDashboardServlet");
    return;
}
if (user != null && "ADMIN".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/jsp/adminDashboard.jsp");
    return;
}
if (user != null && "NGO".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/jsp/ngoDashboard.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SaveBite Home</title>
<link rel="stylesheet"
href="<%=request.getContextPath()%>/css/styles.css">
</head>


<body>
<%
User navUser = (User) session.getAttribute("user");
%>

<div class="navbar">
    <div class="logo">SaveBite</div>

    <div class="nav-links">

        <% if (navUser == null) { %>
            <!-- NOT LOGGED IN -->
            <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
            <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
            <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp">Rescue Hub</a>
            
            <a href="<%=request.getContextPath()%>/jsp/login.jsp">Login</a>
            <a href="<%=request.getContextPath()%>/jsp/register.jsp" class="btn">Sign Up</a>

        <% } else if ("ADMIN".equalsIgnoreCase(navUser.getRole())) { %>
            <!-- ADMIN -->
            <a href="<%=request.getContextPath()%>/jsp/adminDashboard.jsp">Dashboard</a>
            <a href="#">Impact</a>
            <span class="nav-username">👑 <%=navUser.getFullName()%></span>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>

        <% } else if ("RESTAURANT".equalsIgnoreCase(navUser.getRole())) { %>
            <!-- RESTAURANT -->
            <a href="<%=request.getContextPath()%>/RestaurantDashboardServlet">Dashboard</a>
            <a href="#">Impact</a>
            <span class="nav-username">🏪 <%=navUser.getFullName()%></span>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>

        <% } else if ("NGO".equalsIgnoreCase(navUser.getRole())) { %>
            <!-- NGO -->
            <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp">Rescue Hub</a>
            <a href="#">Impact</a>
            <span class="nav-username">🤝 <%=navUser.getFullName()%></span>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>

        <% } else { %>
            <!-- CUSTOMER -->
            <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
            <a href="<%=request.getContextPath()%>/RestaurantServlet">Marketplace</a>
            
            <a href="#">Impact</a>
            <a href="<%=request.getContextPath()%>/jsp/cart.jsp" class="cart-link">&#128722;</a>
            <a href="<%=request.getContextPath()%>/jsp/orders.jsp">My Orders</a>
            <a href="<%=request.getContextPath()%>/jsp/profile.jsp">&#128100;<%=navUser.getFullName()%></a>
            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn">Logout</a>
        <% } %>

    </div>
</div>


<div class="hero">


    <div class="hero-content">
	

        <div class="badge">
             Food Rescue & Delivery Platform
        </div>
        <h1>
            Save Food.<br>
            Feed People.
        </h1>

        <p>
            Order delicious food, rescue surplus meals,
            and reduce food waste through SaveBite.
        </p>

        <a href="<%=request.getContextPath()%>/jsp/register.jsp" class="btn">Get Started</a>

    </div>

</div>
<section class="food-options">
  <h2>Order Our Best Food Options</h2>
  <div class="food-grid">
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=South+Indian" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/southindian.jpeg" alt="South Indian">
      <p>South Indian</p>
    </div>
  </a>
  <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=North+Indian" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/northindian.png?v=2'" alt="North Indian">
      <p>North Indian</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Biryani" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/Biriyani.jpeg" alt="Biryani">
      <p>Biryani</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Desserts" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/desserts.jpg" alt="Desserts">
      <p>Desserts</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Pizza" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/pizza.jpg" alt="Pizza">
      <p>Pizza</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Burgers" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/burger.jpg" alt="Burgers">
      <p>Burger</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Cafe" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/cafe.webp" alt="Cafe">
      <p>Coffee</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Japanese" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/japanese.jpeg" alt="Japanese">
      <p>Japanese</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Chinese" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/chinese.jpg" alt="Chinese">
      <p>Chinese</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Cakes" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/cake.jpg" alt="Cakes">
      <p>Cakes</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Shakes" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/shakes.jpg" alt="Shakes">
      <p>Shake</p>
    </div>
    </a>
    <a href="<%=request.getContextPath()%>/FoodServlet?cuisine=Rolls" class="food-item-link">
    <div class="food-item">
      <img src="<%=request.getContextPath()%>/images/rolls.jpg" alt="Rolls">
      <p>Rolls</p>
    </div>
    </a>
    <!-- Add more food items here -->
  </div>
</section>
<section class="popular-dishes">
  <div class="header-row">
    <h2>Popular Dishes</h2>
    <!-- Order Now button -->
<a href="<%=request.getContextPath()%>/RestaurantServlet" class="btn-order">
    Order Now &#x2192;
</a>


    
  </div>
  <p class="subtitle">Most loved meals ordered on SaveBite</p>

  <div class="dish-scroll">
    <div class="dish-card">
      <img src="<%=request.getContextPath()%>/images/chicken.jpeg" alt="Chicken Biryani">
      <h3>Chicken Biryani</h3>
      <p class="restaurant">Biryani House</p>
      <p class="price">&#8377;280</p>
    </div>

    <div class="dish-card">
      <img src="<%=request.getContextPath()%>/images/pizzza.jpg" alt="Margherita Pizza">
      <h3>Margherita Pizza</h3>
      <p class="restaurant">Pizza Hut</p>
      <p class="price">&#8377;249</p>
    </div>

    <div class="dish-card">
      <img src="<%=request.getContextPath()%>/images/classic.webp" alt="Classic Burger">
      <h3>Classic Burger</h3>
      <p class="restaurant">Burger King</p>
      <p class="price">&#8377;179</p>
    </div>

    <div class="dish-card">
      <img src="<%=request.getContextPath()%>/images/dosa.jpeg" alt="Masala Dosa">
      <h3>Masala Dosa</h3>
      <p class="restaurant">South Spice Kitchen</p>
      <p class="price">&#8377;120</p>
    </div>

    <div class="dish-card">
      <img src="<%=request.getContextPath()%>/images/noodles.png?v=2'" alt="Hakka Noodles">
      <h3>Hakka Noodles</h3>
      <p class="restaurant">China Bowl</p>
      <p class="price">&#8377;195</p>
    </div>
    <div class="dish-card">
      <img src="<%=request.getContextPath()%>/images/mousse.jpeg" alt="Hakka Noodles">
      <h3>Raspberry Mousse</h3>
      <p class="restaurant">Dessert Delight</p>
      <p class="price">&#8377;180</p>
    </div>
  </div>
</section>
<section class="savebite-flow">
  <div class="flow-header">
    <h2 class="flow-heading">How SaveBite Works</h2>
    <p class="flow-subtitle">Two powerful missions, one platform. Order your next meal or rescue one for someone who needs it.</p>
  </div>

  <div class="flow-container">
    <div class="flow-card">
      <div class="flow-icon flow-icon-order">&#x1F69A;</div>
      <h3>Order Food Delivery</h3>
      <ol>
        <li>
          <strong>Browse Restaurants</strong>
          <p>Explore restaurants by cuisine, rating and delivery time.</p>
        </li>
        <li>
          <strong>Add to Cart</strong>
          <p>Pick your favourites, customize and build your perfect order.</p>
        </li>
        <li>
          <strong>Fast Delivery</strong>
          <p>Track your order from kitchen to doorstep in real time.</p>
        </li>
      </ol>
      <a href="<%=request.getContextPath()%>/RestaurantServlet" class="btn-order">
          Order Now &#x2192;
      </a>
    </div>

    <div class="flow-card">
      <div class="flow-icon flow-icon-donate">&#x1F90D;</div>
      <h3>Rescue Surplus Food</h3>
      <ol>
        <li>
          <strong>Register Your Surplus</strong>
          <p>Have leftover food from events, functions or restaurants? List it.</p>
        </li>
        <li>
          <strong>Choose an NGO</strong>
          <p>Select from our verified NGO partners who will collect the food.</p>
        </li>
        <li>
          <strong>Feed Someone Today</strong>
          <p>Your donation reaches those in need within hours. Zero waste.</p>
        </li>
      </ol>
      <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp" class="btn-donate">
          Donate Food &#x2192;
      </a>
    </div>
  </div>
</section>


<section class="stats">

    <div class="stat-box">
        <h2>500+</h2>
        <p>Orders Delivered</p>
    </div>

    <div class="stat-box">
        <h2>120+</h2>
        <p>Partner Restaurants</p>
    </div>

    <div class="stat-box">
        <h2>50+</h2>
        <p>NGO Partners</p>
    </div>

    <div class="stat-box">
        <h2>2000+</h2>
        <p>Meals Saved</p>
    </div>
</section>

<div class="dashboard">
    <div class="card" style="cursor:pointer;"
         onclick="location.href='<%=request.getContextPath()%>/RestaurantServlet'">
        <h2>
            <span class="icon marketplace">&#127869;</span> Food Marketplace
        </h2>
        <p>Browse restaurants and order food online.</p>
    </div>

    <div class="card" style="cursor:pointer;"
         onclick="location.href='<%=request.getContextPath()%>/jsp/ngoDashboard.jsp'">
        <h2><span class="icon rescue">&#10084;</span> Rescue Hub</h2>
        <p>NGOs can collect surplus food donations.</p>
    </div>

    <div class="card">
        <h2><span class="icon waste">&#9851;</span> Reduce Waste</h2>
        <p>Help build a sustainable future.</p>
    </div>
</div>

<footer class="footer-section">

    <div class="footer-container">

        <!-- Column 1 -->
        <div class="footer-column">
            <h2 class="footer-logo">
                Save<span style="color:#f97316;">Bite</span>
            </h2>

            <p>
                Connecting food lovers with great restaurants,
                and surplus food with those who need it most.
                Every meal counts.
            </p>
        </div>

        <!-- Column 2 -->
        <!-- Column 2 -->
<div class="footer-column">
    <h3>Quick Links</h3>
    <ul>
        <li>
            <a href="<%=request.getContextPath()%>/RestaurantServlet">
                Order Food
            </a>
        </li>
        <li>
            <a href="<%=request.getContextPath()%>/jsp/donateFood.jsp">
                Donate Food
            </a>
        </li>
        <li>
            <a href="<%=request.getContextPath()%>/jsp/ngoDashboard.jsp">
                Our NGO Partners
            </a>
        </li>
        <li>
            <a href="<%=request.getContextPath()%>/jsp/orders.jsp">
                Track Your Order
            </a>
        </li>
        <li>
            <a href="<%=request.getContextPath()%>/jsp/profile.jsp">
                My Profile
            </a>
        </li>
    </ul>
</div>

        <!-- Column 3 -->
        <!-- Column 3 -->
<div class="footer-column">
    <h3>Company</h3>
    <ul>
        <li><a href="<%=request.getContextPath()%>/jsp/about.jsp">About Us</a></li>
        <li><a href="mailto:hello@savebite.in">Contact Us</a></li>
        <li><a href="<%=request.getContextPath()%>/jsp/register.jsp">Join Us</a></li>
        <li><a href="<%=request.getContextPath()%>/jsp/privacyPolicy.jsp">Privacy Policy</a></li>
<li><a href="<%=request.getContextPath()%>/jsp/termsOfService.jsp">Terms of Service</a></li>
    </ul>
</div>

        <!-- Column 4 -->
        <div class="footer-column">
            <h3>Contact</h3>

            <div class="contact-row">
                <span class="icon">&#x1F4CD;</span>
                <span class="text">
                    12 MG Road, Indiranagar,
                    Bangalore 560038, India
                </span>
            </div>

            <div class="contact-row">
                <span class="icon">&#x260E;</span>
                <span class="text">
                    +91 80 1234 5678
                </span>
            </div>

            <div class="contact-row">
                <span class="icon">&#x2709;</span>
                <span class="text">
                    hello@savebite.in
                </span>
            </div>
        </div>

    </div>

    <div class="footer-bottom">
        <p>&copy;
         2026 SaveBite Technologies Pvt. Ltd. All rights reserved.</p>
        <p>Made with  in Bangalore, India</p>
    </div>

</footer>
  
  



</body>
</html>