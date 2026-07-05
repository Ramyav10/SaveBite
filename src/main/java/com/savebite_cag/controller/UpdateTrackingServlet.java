package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.OrderDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/UpdateTrackingServlet")
public class UpdateTrackingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String trackingStatus = request.getParameter("trackingStatus");

        OrderDAOImpl dao = new OrderDAOImpl();
        dao.updateTrackingStatus(orderId, trackingStatus);

        // Redirect back to restaurant dashboard orders tab
        response.sendRedirect(request.getContextPath() +
            "/RestaurantDashboardServlet?tab=orders");
    }
}
