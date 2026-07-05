package com.savebite_cag.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.savebite_cag.dao.CartDAO;
import com.savebite_cag.model.Cart;
import com.savebite_cag.utility.DBConnection;

public class CartDAOImpl implements CartDAO {

    @Override
    public boolean addToCart(Cart cart) {
        try (Connection con = DBConnection.getConnection()) {

            String checkQuery = "SELECT * FROM cart WHERE user_id=? AND food_id=?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setInt(1, cart.getUserId());
            checkStmt.setInt(2, cart.getFoodId());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int currentQty = rs.getInt("quantity");
                String updateQuery = "UPDATE cart SET quantity=? WHERE cart_id=?";
                PreparedStatement updateStmt = con.prepareStatement(updateQuery);
                updateStmt.setInt(1, currentQty + cart.getQuantity());
                updateStmt.setInt(2, rs.getInt("cart_id"));
                return updateStmt.executeUpdate() > 0;
            } else {
                String insertQuery = "INSERT INTO cart(user_id,food_id,quantity) VALUES(?,?,?)";
                PreparedStatement insertStmt = con.prepareStatement(insertQuery);
                insertStmt.setInt(1, cart.getUserId());
                insertStmt.setInt(2, cart.getFoodId());
                insertStmt.setInt(3, cart.getQuantity());
                return insertStmt.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Cart> getCartByUser(int userId) {
        List<Cart> list = new ArrayList<>();
        String query = "SELECT * FROM cart WHERE user_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setFoodId(rs.getInt("food_id"));
                cart.setQuantity(rs.getInt("quantity"));
                list.add(cart);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean removeFromCart(int cartId) {
        String query = "DELETE FROM cart WHERE cart_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, cartId);
            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean clearCart(int userId) {
        String query = "DELETE FROM cart WHERE user_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() >= 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Cart getCartByUserAndFood(int userId, int foodId) {
        String sql = "SELECT * FROM cart WHERE user_id = ? AND food_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, foodId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setFoodId(rs.getInt("food_id"));
                cart.setQuantity(rs.getInt("quantity"));
                return cart;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateQuantity(int cartId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
