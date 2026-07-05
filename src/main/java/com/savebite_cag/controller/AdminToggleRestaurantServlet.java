package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.RestaurantDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/AdminToggleRestaurantServlet")
public class AdminToggleRestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        String status = request.getParameter("status");

        RestaurantDAOImpl dao = new RestaurantDAOImpl();
        dao.updateStatus(restaurantId, status);

        response.sendRedirect(request.getContextPath() +
            "/jsp/adminDashboard.jsp?tab=restaurants");
    }
}
