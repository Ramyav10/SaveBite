package com.savebite_cag.controller;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.savebite_cag.daoimpl.FoodDAOImpl;
import com.savebite_cag.daoimpl.RestaurantDAOImpl;
import com.savebite_cag.model.FoodItem;
import com.savebite_cag.model.Restaurant;
import com.savebite_cag.model.User;

@WebServlet("/FoodServlet")
public class FoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Role checks at the very top
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && "NGO".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/ngoDashboard.jsp");
            return;
        }
        if (user != null && "RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/RestaurantDashboardServlet");
            return;
        }

        FoodDAOImpl foodDao = new FoodDAOImpl();
        RestaurantDAOImpl restaurantDao = new RestaurantDAOImpl();
        Restaurant restaurant = null;

        String restaurantIdParam = request.getParameter("restaurantId");
        String cuisine = request.getParameter("cuisine");

        if (restaurantIdParam != null) {
            int restaurantId = Integer.parseInt(restaurantIdParam);
            restaurant = restaurantDao.getRestaurantById(restaurantId);
        } else if (cuisine != null) {
            restaurant = restaurantDao.getRestaurantByCuisine(cuisine);
        }

        if (restaurant != null) {
            List<FoodItem> foodList = foodDao.getFoodsByRestaurant(restaurant.getRestaurantId());
            System.out.println("Restaurant = " + restaurant);
            System.out.println("Food list size = " + (foodList != null ? foodList.size() : 0));
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("foodList", foodList);
            request.getRequestDispatcher("/jsp/menu.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/jsp/home.jsp");
        }
    }
}