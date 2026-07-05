package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.CartDAOImpl;
import com.savebite_cag.model.Cart;
import com.savebite_cag.model.User;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        CartDAOImpl dao = new CartDAOImpl();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String restaurantId = request.getParameter("restaurantId");
        String foodId = request.getParameter("foodId");
        String fromCart = request.getParameter("fromCart"); // NEW

        if ("add".equals(action)) {
            int fId = Integer.parseInt(foodId);
            Cart existing = dao.getCartByUserAndFood(user.getUserId(), fId);
            if (existing != null) {
                dao.updateQuantity(existing.getCartId(), existing.getQuantity() + 1);
            } else {
                Cart cart = new Cart();
                cart.setUserId(user.getUserId());
                cart.setFoodId(fId);
                cart.setQuantity(1);
                dao.addToCart(cart);
            }
            response.sendRedirect(request.getContextPath() +
                "/FoodServlet?restaurantId=" + restaurantId + "#food-" + foodId);

        } else if ("increase".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            dao.updateQuantity(cartId, quantity + 1);

            // Stay on cart or go back to menu
            if ("true".equals(fromCart)) {
                response.sendRedirect(request.getContextPath() + "/jsp/cart.jsp");
            } else {
                response.sendRedirect(request.getContextPath() +
                    "/FoodServlet?restaurantId=" + restaurantId + "#food-" + foodId);
            }

        } else if ("decrease".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            if (quantity <= 1) {
                dao.removeFromCart(cartId);
            } else {
                dao.updateQuantity(cartId, quantity - 1);
            }

            // Stay on cart or go back to menu
            if ("true".equals(fromCart)) {
                response.sendRedirect(request.getContextPath() + "/jsp/cart.jsp");
            } else {
                response.sendRedirect(request.getContextPath() +
                    "/FoodServlet?restaurantId=" + restaurantId + "#food-" + foodId);
            }

        } else if ("remove".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            dao.removeFromCart(cartId);
            response.sendRedirect(request.getContextPath() + "/jsp/cart.jsp");
        }
    }
}