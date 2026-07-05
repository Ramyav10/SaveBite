package com.savebite_cag.controller;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.savebite_cag.daoimpl.RestaurantDAOImpl;
import com.savebite_cag.model.Restaurant;
import com.savebite_cag.model.User;

@WebServlet("/RestaurantServlet")
public class RestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirect restaurant owners to their dashboard
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && "RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/RestaurantDashboardServlet");
            return;
        }
     // Redirect NGO to their dashboard
        if (user != null && "NGO".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/ngoDashboard.jsp");
            return;
        }

        RestaurantDAOImpl dao = new RestaurantDAOImpl();
        String sort = request.getParameter("sort");
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String cuisine = request.getParameter("cuisine");
        List<Restaurant> restaurantList = null;

        try {
            if ("ACTIVE".equalsIgnoreCase(status)) {
                restaurantList = dao.getRestaurantsByStatus("ACTIVE", search, sort);
            } else if ("CLOSED".equalsIgnoreCase(status)) {
                restaurantList = dao.getRestaurantsByStatus("CLOSED", search, sort);
            } else if (cuisine != null && !"All".equalsIgnoreCase(cuisine)) {
                restaurantList = dao.getRestaurantsByCuisine(cuisine, sort);
            } else if (search != null && !search.trim().isEmpty()) {
                restaurantList = dao.getRestaurantsFiltered(search, sort);
            } else if (sort != null && !sort.equals("default")) {
                restaurantList = dao.getRestaurantsSorted(sort);
            } else {
                restaurantList = dao.getAllRestaurants();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            restaurantList = dao.getAllRestaurants();
        }

        request.setAttribute("restaurantList", restaurantList);
        request.getRequestDispatcher("jsp/restaurant.jsp").forward(request, response);
    }
}


