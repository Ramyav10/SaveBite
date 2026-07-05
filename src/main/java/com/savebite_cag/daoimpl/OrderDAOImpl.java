package com.savebite_cag.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.savebite_cag.dao.OrderDAO;
import com.savebite_cag.model.Order;
import com.savebite_cag.utility.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    // REMOVE constructor connection — use fresh in each method

	@Override
	public boolean placeOrder(Order order) {
	    String query = "INSERT INTO orders(user_id, total_amount, payment_status, order_status, delivery_address, restaurant_id) VALUES(?,?,?,?,?,?)";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(query)) {

	        pstmt.setInt(1, order.getUserId());
	        pstmt.setDouble(2, order.getTotalAmount());
	        pstmt.setString(3, order.getPaymentStatus());
	        pstmt.setString(4, order.getOrderStatus());
	        pstmt.setString(5, order.getDeliveryAddress());
	        pstmt.setInt(6, order.getRestaurantId());

	        System.out.println("Placing order with total = " + order.getTotalAmount());
	        System.out.println("Restaurant ID = " + order.getRestaurantId());

	        return pstmt.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
    @Override
    public boolean updatePaymentStatus(int orderId, String status) {
        String query = "UPDATE orders SET payment_status=? WHERE order_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE user_id=? ORDER BY order_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTrackingStatus(rs.getString("tracking_status"));
                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateTrackingStatus(int orderId, String status) {
        String query = "UPDATE orders SET tracking_status=? WHERE order_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    @Override
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE total_amount > 0 ORDER BY order_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setTrackingStatus(rs.getString("tracking_status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setOrderDate(rs.getTimestamp("order_date")); // ← was missing!
                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public int getOrderCount() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM orders";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getLastOrderId(int userId) {
        String sql = "SELECT order_id FROM orders WHERE user_id = ? ORDER BY order_id DESC LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("order_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTrackingStatus(rs.getString("tracking_status"));
                return order;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Order> getOrdersByRestaurant(int restaurantId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE restaurant_id = ? ORDER BY order_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTrackingStatus(rs.getString("tracking_status"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}