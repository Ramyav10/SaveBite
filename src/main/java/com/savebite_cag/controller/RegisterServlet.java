package com.savebite_cag.controller;
import java.io.IOException;
import com.savebite_cag.daoimpl.UserDAOImpl;
import com.savebite_cag.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

     // Block public admin registration
     if (role == null || role.equalsIgnoreCase("ADMIN")) {
         request.setAttribute("error", "Admin registration is not allowed.");
         request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
         return;
     }

     

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setPassword(password);
        user.setRole(role);
        user.setAddress(address);
       
        UserDAOImpl dao = new UserDAOImpl();
        boolean status = dao.addUser(user);

        if (status) {
            // Redirect to login with success message
            response.sendRedirect(request.getContextPath() +
                "/jsp/login.jsp?success=Registration successful! Please login.");
        } else {
            // Redirect back to register with error
            request.setAttribute("error", "Registration failed. Email may already exist.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
}