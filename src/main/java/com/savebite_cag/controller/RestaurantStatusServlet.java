package com.savebite_cag.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.savebite_cag.daoimpl.RestaurantDAOImpl;

@WebServlet("/RestaurantStatusServlet")
public class RestaurantStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status");
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));

        RestaurantDAOImpl dao = new RestaurantDAOImpl();
        dao.updateStatus(restaurantId, status);

        response.sendRedirect(request.getContextPath() + "/RestaurantDashboardServlet?tab=overview");
    }
}