package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.savebite_cag.daoimpl.UserDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAOImpl dao = new UserDAOImpl();

        if (dao.validateUser(email, password)) {
            User user = dao.getUserByEmail(email);
            if ("BLOCKED".equalsIgnoreCase(user.getStatus())) {
                request.setAttribute("error", "Your account has been blocked. Please contact support.");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                return;
            }
            dao.updateLastLogin(email);

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if (user.getRole().equalsIgnoreCase("ADMIN")) {
                response.sendRedirect(request.getContextPath() + "/jsp/adminDashboard.jsp");
            } else if (user.getRole().equalsIgnoreCase("RESTAURANT")) {
                response.sendRedirect(request.getContextPath() + "/RestaurantDashboardServlet");
            } else if (user.getRole().equalsIgnoreCase("NGO")) {
                response.sendRedirect(request.getContextPath() + "/jsp/ngoDashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/home.jsp");
            }
        } else {
            // Redirect back to login with error
            request.setAttribute("error", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }
}