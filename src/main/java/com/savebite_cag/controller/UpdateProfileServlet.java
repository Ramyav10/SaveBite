package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.UserDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        UserDAOImpl dao = new UserDAOImpl();

        if ("updateProfile".equals(action)) {
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            dao.updateProfile(user.getUserId(), fullName, phoneNumber, address);

            // Update session
            user.setFullName(fullName);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);
            session.setAttribute("user", user);

            response.sendRedirect(request.getContextPath() +
                "/jsp/profile.jsp?success=Profile updated successfully!");

        } else if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Verify current password
            if (!dao.validateUser(user.getEmail(), currentPassword)) {
                request.setAttribute("error", "Current password is incorrect!");
                request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
                return;
            }

            // Check new passwords match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match!");
                request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
                return;
            }

            dao.updatePassword(user.getUserId(), newPassword);

            response.sendRedirect(request.getContextPath() +
                "/jsp/profile.jsp?success=Password changed successfully!");
        }
    }
}
