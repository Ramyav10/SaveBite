package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.UserDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/AdminDeleteUserServlet")
public class AdminDeleteUserServlet extends HttpServlet {
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

        // Prevent admin from deleting themselves
        if (userId == user.getUserId()) {
            response.sendRedirect(request.getContextPath() +
                "/jsp/adminDashboard.jsp?tab=users&error=Cannot delete your own account!");
            return;
        }

        UserDAOImpl dao = new UserDAOImpl();
        dao.deleteUser(userId);

        response.sendRedirect(request.getContextPath() +
            "/jsp/adminDashboard.jsp?tab=users&success=User deleted successfully!");
    }
}
