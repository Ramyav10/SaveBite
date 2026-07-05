package com.savebite_cag.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.savebite_cag.dao.FoodDAO;
import com.savebite_cag.model.FoodItem;
import com.savebite_cag.utility.DBConnection;

public class FoodDAOImpl implements FoodDAO {

    // DELETE these two lines
    // private Connection con;
    // public FoodDAOImpl() {
    //     con = DBConnection.getConnection();
    // }

    @Override
    public List<FoodItem> getFoodsByRestaurant(int restaurantId) {
        List<FoodItem> foods = new ArrayList<>();
        String query = "SELECT * FROM food_items WHERE restaurant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();

            while(rs.next()) {
                FoodItem food = new FoodItem();
                food.setFoodId(rs.getInt("food_id"));
                food.setRestaurantId(rs.getInt("restaurant_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setCategory(rs.getString("category"));
                food.setDescription(rs.getString("description"));
                food.setPrice(rs.getDouble("price"));
                food.setImageUrl(rs.getString("image_url"));
                food.setAvailableQuantity(rs.getInt("available_quantity"));
                food.setFoodStatus(rs.getString("food_status"));
                food.setDeliveryTime(rs.getInt("deliveryTime"));
                food.setRating(rs.getDouble("rating"));
                foods.add(food);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
        return foods;
    }

    @Override
    public FoodItem getFoodById(int foodId) {
        String query = "SELECT * FROM food_items WHERE food_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, foodId);
            ResultSet rs = pstmt.executeQuery();

            if(rs.next()) {
                FoodItem food = new FoodItem();
                food.setFoodId(rs.getInt("food_id"));
                food.setRestaurantId(rs.getInt("restaurant_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setCategory(rs.getString("category"));
                food.setDescription(rs.getString("description"));
                food.setPrice(rs.getDouble("price"));
                food.setImageUrl(rs.getString("image_url"));
                food.setAvailableQuantity(rs.getInt("available_quantity"));
                food.setFoodStatus(rs.getString("food_status"));
                food.setDeliveryTime(rs.getInt("deliveryTime"));
                food.setRating(rs.getDouble("rating"));
                return food;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public void updateFoodStatus(int foodId, String status) {
        String sql = "UPDATE food_items SET food_status = ? WHERE food_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, foodId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void deleteFoodItem(int foodId) {
        String sql = "DELETE FROM food_items WHERE food_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, foodId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean addFoodItem(FoodItem food) {
        String sql = "INSERT INTO food_items(restaurant_id, food_name, category, description, price, image_url, available_quantity, food_status, deliveryTime, rating) VALUES(?,?,?,?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, food.getRestaurantId());
            ps.setString(2, food.getFoodName());
            ps.setString(3, food.getCategory());
            ps.setString(4, food.getDescription());
            ps.setDouble(5, food.getPrice());
            ps.setString(6, food.getImageUrl());
            ps.setInt(7, food.getAvailableQuantity());
            ps.setString(8, food.getFoodStatus());
            ps.setInt(9, food.getDeliveryTime());
            ps.setDouble(10, food.getRating());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean updateFoodItem(FoodItem food) {
        String sql = "UPDATE food_items SET food_name=?, category=?, description=?, price=?, image_url=?, available_quantity=?, food_status=?, deliveryTime=?, rating=? WHERE food_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, food.getFoodName());
            ps.setString(2, food.getCategory());
            ps.setString(3, food.getDescription());
            ps.setDouble(4, food.getPrice());
            ps.setString(5, food.getImageUrl());
            ps.setInt(6, food.getAvailableQuantity());
            ps.setString(7, food.getFoodStatus());
            ps.setInt(8, food.getDeliveryTime());
            ps.setDouble(9, food.getRating());
            ps.setInt(10, food.getFoodId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}