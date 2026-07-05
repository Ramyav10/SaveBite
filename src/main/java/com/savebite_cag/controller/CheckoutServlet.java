package com.savebite_cag.controller;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.CartDAOImpl;
import com.savebite_cag.daoimpl.FoodDAOImpl;
import com.savebite_cag.daoimpl.OrderDAOImpl;
import com.savebite_cag.model.Cart;
import com.savebite_cag.model.FoodItem;
import com.savebite_cag.model.Order;
import com.savebite_cag.model.User;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        CartDAOImpl cartDao = new CartDAOImpl();
        FoodDAOImpl foodDao = new FoodDAOImpl();
        List<Cart> cartList = cartDao.getCartByUser(user.getUserId());

        if (cartList == null || cartList.isEmpty()) {
            Integer existingOrderId = (Integer) session.getAttribute("orderId");
            if (existingOrderId != null) {
                session.setAttribute("paymentMethod", paymentMethod);
                response.sendRedirect(request.getContextPath() + "/jsp/payment.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/cart.jsp");
            }
            return;
        }

        // Calculate total and get restaurant_id from first cart item
        double grandTotal = 0;
        int restaurantId = 0;

        for (Cart cart : cartList) {
            FoodItem food = foodDao.getFoodById(cart.getFoodId());
            if (food != null) {
                grandTotal += food.getPrice() * cart.getQuantity();
                if (restaurantId == 0) {
                    restaurantId = food.getRestaurantId(); // get from first item
                }
            }
        }

        double tax = grandTotal * 0.05;
        double finalTotal = grandTotal + tax;

        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setTotalAmount(finalTotal);
        order.setDeliveryAddress(address);
        order.setOrderStatus("Placed");
        order.setRestaurantId(restaurantId); // SET RESTAURANT ID

        if ("COD".equals(paymentMethod)) {
            order.setPaymentStatus("Pending");
        } else {
            order.setPaymentStatus("Paid");
        }

        OrderDAOImpl orderDao = new OrderDAOImpl();
        boolean status = orderDao.placeOrder(order);

        if (status) {
            int orderId = orderDao.getLastOrderId(user.getUserId());
            cartDao.clearCart(user.getUserId());

            session.setAttribute("orderId", orderId);
            session.setAttribute("paymentMethod", paymentMethod);
            session.setAttribute("finalTotal", (int) finalTotal);
            session.setAttribute("deliveryAddress", address);

            if ("COD".equals(paymentMethod)) {
                response.sendRedirect(request.getContextPath() + "/jsp/orderConfirmation.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/payment.jsp");
            }
        } else {
            request.setAttribute("error", "Order failed. Please try again.");
            request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
        }
    }
}