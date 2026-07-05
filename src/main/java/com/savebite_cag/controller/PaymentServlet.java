package com.savebite_cag.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.savebite_cag.daoimpl.OrderDAOImpl;
import com.savebite_cag.daoimpl.PaymentDAOImpl;
import com.savebite_cag.model.Payment;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int orderId =
                Integer.parseInt(
                request.getParameter("orderId"));

        double amount =
                Double.parseDouble(
                request.getParameter("amount"));

        String paymentMethod =
                request.getParameter("paymentMethod");

        Payment payment = new Payment();

        payment.setOrderId(orderId);
        payment.setAmount(amount);
        payment.setPaymentMethod(paymentMethod);
        payment.setPaymentStatus("Paid");

        PaymentDAOImpl paymentDao =
                new PaymentDAOImpl();

        boolean paymentDone =
                paymentDao.addPayment(payment);

        if(paymentDone) {

            OrderDAOImpl orderDao =
                    new OrderDAOImpl();

            orderDao.updatePaymentStatus(
                    orderId,
                    "Paid");

            response.sendRedirect(
                    "jsp/orders.jsp");

        } else {

            response.getWriter()
            .println("Payment Failed");
        }
    }
}
