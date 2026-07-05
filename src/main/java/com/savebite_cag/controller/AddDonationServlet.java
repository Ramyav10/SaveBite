package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.DonationDAOImpl;
import com.savebite_cag.model.Donation;
import com.savebite_cag.model.User;

@WebServlet("/AddDonationServlet")
public class AddDonationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        Donation donation = new Donation();
        donation.setRestaurantId(user.getRestaurantId()); // from session
        donation.setFoodName(request.getParameter("foodName"));
        donation.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        donation.setExpiryTime(request.getParameter("expiryTime"));
        donation.setPickupAddress(request.getParameter("pickupAddress"));

        DonationDAOImpl dao = new DonationDAOImpl();
        boolean status = dao.addDonation(donation);

        if (status) {
            response.sendRedirect(request.getContextPath() +
                "/RestaurantDashboardServlet?tab=donations&success=Food donated successfully!");
        } else {
            request.setAttribute("error", "Donation failed. Please try again.");
            request.getRequestDispatcher("/jsp/donateFood.jsp").forward(request, response);
        }
    }
}