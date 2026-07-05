package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.RestaurantDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/UpdateRestaurantServlet")
public class UpdateRestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        String restaurantName = request.getParameter("restaurantName");
        String cuisineType = request.getParameter("cuisineType");
        String phoneNumber = request.getParameter("phoneNumber");
        String description = request.getParameter("description");
        String address = request.getParameter("address");
        int deliveryTime = Integer.parseInt(request.getParameter("deliveryTime"));
        int minPrice = Integer.parseInt(request.getParameter("minPrice"));
        String priceRange = request.getParameter("priceRange");

        RestaurantDAOImpl dao = new RestaurantDAOImpl();
        dao.updateRestaurant(restaurantId, restaurantName, cuisineType,
                             phoneNumber, description, address,
                             deliveryTime, minPrice, priceRange);

        response.sendRedirect(request.getContextPath() +
            "/RestaurantDashboardServlet?tab=profile&success=Profile updated!");
    }
}
