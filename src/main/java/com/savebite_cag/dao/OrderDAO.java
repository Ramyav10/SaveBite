package com.savebite_cag.dao;

import java.util.List;
import com.savebite_cag.model.Order;

public interface OrderDAO {

    boolean placeOrder(Order order);

    List<Order> getOrdersByUser(int userId);
    boolean updatePaymentStatus(int orderId, String status);
    List<Order> getAllOrders();

    boolean updateTrackingStatus(int orderId,String status);
    
}