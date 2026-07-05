package com.savebite_cag.controller;

import java.io.IOException;
import com.savebite_cag.daoimpl.DonationDAOImpl;
import com.savebite_cag.model.Donation;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.FoodDAOImpl;
import com.savebite_cag.daoimpl.OrderDAOImpl;
import com.savebite_cag.daoimpl.RestaurantDAOImpl;
import com.savebite_cag.model.FoodItem;
import com.savebite_cag.model.Order;
import com.savebite_cag.model.Restaurant;
import com.savebite_cag.model.User;

@WebServlet("/RestaurantDashboardServlet")
public class RestaurantDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        if (user.getRestaurantId() == null) {
            request.setAttribute("error", "No restaurant linked to this account.");
            request.getRequestDispatcher("/jsp/restaurantDashboard.jsp").forward(request, response);
            return;
        }

        int restaurantId = user.getRestaurantId();

        RestaurantDAOImpl restaurantDao = new RestaurantDAOImpl();
        FoodDAOImpl foodDao = new FoodDAOImpl();
        OrderDAOImpl orderDao = new OrderDAOImpl();

        Restaurant restaurant = restaurantDao.getRestaurantById(restaurantId);
        List<FoodItem> foodList = foodDao.getFoodsByRestaurant(restaurantId);

        // ✅ Fetch orders for this restaurant only
        List<Order> restaurantOrders = orderDao.getOrdersByRestaurant(restaurantId);

        // Calculate stats
        int totalMenuItems = foodList != null ? foodList.size() : 0;
        int totalOrders = restaurantOrders != null ? restaurantOrders.size() : 0;
        int pendingOrders = 0;
        double totalRevenue = 0;

        if (restaurantOrders != null) {
            for (Order o : restaurantOrders) {
                if ("Pending".equalsIgnoreCase(o.getPaymentStatus())) {
                    pendingOrders++;
                }
                totalRevenue += o.getTotalAmount();
            }
        }

        request.setAttribute("restaurant", restaurant);
        request.setAttribute("foodList", foodList);
        request.setAttribute("restaurantOrders", restaurantOrders);
        request.setAttribute("totalMenuItems", totalMenuItems);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("totalRevenue", (int) totalRevenue);

        request.getRequestDispatcher("/jsp/restaurantDashboard.jsp").forward(request, response);
        DonationDAOImpl donationDao = new DonationDAOImpl();
        List<Donation> myDonations = donationDao.getDonationsByRestaurant(restaurantId);
        request.setAttribute("myDonations", myDonations);
    }
}