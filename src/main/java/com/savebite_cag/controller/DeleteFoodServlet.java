package com.savebite_cag.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.savebite_cag.daoimpl.FoodDAOImpl;

@WebServlet("/DeleteFoodServlet")
public class DeleteFoodServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int foodId = Integer.parseInt(request.getParameter("foodId"));

        FoodDAOImpl dao = new FoodDAOImpl();
        dao.deleteFoodItem(foodId);

        response.sendRedirect(request.getContextPath() + "/RestaurantDashboardServlet?tab=menu");
    }
}
