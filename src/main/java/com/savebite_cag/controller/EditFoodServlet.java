package com.savebite_cag.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.savebite_cag.daoimpl.FoodDAOImpl;
import com.savebite_cag.model.FoodItem;
import com.savebite_cag.model.User;

@WebServlet("/EditFoodServlet")
public class EditFoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int foodId = Integer.parseInt(request.getParameter("foodId"));
        FoodDAOImpl dao = new FoodDAOImpl();
        FoodItem food = dao.getFoodById(foodId);

        request.setAttribute("food", food);
        request.getRequestDispatcher("/jsp/editFoodItem.jsp").forward(request, response);
    }
}
