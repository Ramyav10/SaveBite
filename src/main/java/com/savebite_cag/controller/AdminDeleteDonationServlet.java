package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.DonationDAOImpl;
import com.savebite_cag.model.User;

@WebServlet("/AdminDeleteDonationServlet")
public class AdminDeleteDonationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int donationId = Integer.parseInt(request.getParameter("donationId"));

        DonationDAOImpl dao = new DonationDAOImpl();
        dao.deleteDonation(donationId);

        response.sendRedirect(request.getContextPath() +
            "/jsp/adminDashboard.jsp?tab=donations&success=Donation deleted successfully!");
    }
}
