package com.savebite_cag.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.savebite_cag.daoimpl.CartDAOImpl;

@WebServlet("/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int cartId =
                Integer.parseInt(request.getParameter("cartId"));

        CartDAOImpl dao = new CartDAOImpl();

        dao.removeFromCart(cartId);

        response.sendRedirect("jsp/cart.jsp");
    }
}