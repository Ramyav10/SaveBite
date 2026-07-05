package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.DonationDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/AcceptDonationServlet")
public class AcceptDonationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int donationId = Integer.parseInt(request.getParameter("donationId"));

        DonationDAOImpl dao = new DonationDAOImpl();
        boolean status = dao.acceptDonation(donationId);

        if (status) {
            // Redirect back to NGO dashboard with success message
            response.sendRedirect(request.getContextPath() +
                "/jsp/ngoDashboard.jsp?status=AVAILABLE&success=Donation claimed successfully!");
        } else {
            response.sendRedirect(request.getContextPath() +
                "/jsp/ngoDashboard.jsp?error=Failed to claim donation. Please try again.");
        }
    }
}