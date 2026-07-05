package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.OrderDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/AdminCancelOrderServlet")
public class AdminCancelOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderDAOImpl dao = new OrderDAOImpl();
        dao.updateOrderStatus(orderId, "Cancelled");

        response.sendRedirect(request.getContextPath() +
            "/jsp/adminDashboard.jsp?tab=orders&success=Order cancelled successfully!");
    }
}
