package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.UserDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/AdminBlockUserServlet")
public class AdminBlockUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        String status = request.getParameter("status");

        UserDAOImpl dao = new UserDAOImpl();
        dao.updateUserStatus(userId, status);

        response.sendRedirect(request.getContextPath() +
            "/jsp/adminDashboard.jsp?tab=users");
    }
}