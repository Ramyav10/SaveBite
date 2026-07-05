package com.savebite_cag.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.savebite_cag.dao.RestaurantDAO;
import com.savebite_cag.model.Restaurant;
import com.savebite_cag.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public boolean addRestaurant(Restaurant restaurant) {
        String query = "INSERT INTO restaurants "
                + "(restaurant_name,owner_name,email,phone_number,address,description,image_url,rating,status,cuisineType,deliveryTime,minPrice,priceRange) "
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, restaurant.getRestaurantName());
            pstmt.setString(2, restaurant.getOwnerName());
            pstmt.setString(3, restaurant.getEmail());
            pstmt.setString(4, restaurant.getPhoneNumber());
            pstmt.setString(5, restaurant.getAddress());
            pstmt.setString(6, restaurant.getDescription());
            pstmt.setString(7, restaurant.getImageUrl());
            pstmt.setDouble(8, restaurant.getRating());
            pstmt.setString(9, restaurant.getStatus());
            pstmt.setString(10, restaurant.getCuisineType());
            pstmt.setInt(11, restaurant.getDeliveryTime());
            pstmt.setInt(12, restaurant.getMinPrice());
            pstmt.setString(13, restaurant.getPriceRange());

            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String query = "SELECT * FROM restaurants";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = new Restaurant();
                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setOwnerName(rs.getString("owner_name"));
                restaurant.setEmail(rs.getString("email"));
                restaurant.setPhoneNumber(rs.getString("phone_number"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setDescription(rs.getString("description"));
                restaurant.setImageUrl(rs.getString("image_url"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setStatus(rs.getString("status"));
                restaurant.setCreatedAt(rs.getTimestamp("created_at"));
                restaurant.setCuisineType(rs.getString("cuisineType"));
                restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
                restaurant.setMinPrice(rs.getInt("minPrice"));
                restaurant.setPriceRange(rs.getString("priceRange"));
                restaurant.setCoverImage(rs.getString("cover_image"));
                restaurants.add(restaurant);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public Restaurant getRestaurantById(int restaurantId) {
        String query = "SELECT * FROM restaurants WHERE restaurant_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Restaurant restaurant = new Restaurant();
                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setOwnerName(rs.getString("owner_name"));
                restaurant.setEmail(rs.getString("email"));
                restaurant.setPhoneNumber(rs.getString("phone_number"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setDescription(rs.getString("description"));
                restaurant.setImageUrl(rs.getString("image_url"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setStatus(rs.getString("status"));
                restaurant.setCreatedAt(rs.getTimestamp("created_at"));
                restaurant.setCuisineType(rs.getString("cuisineType"));
                restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
                restaurant.setMinPrice(rs.getInt("minPrice"));
                restaurant.setPriceRange(rs.getString("priceRange"));
                restaurant.setCoverImage(rs.getString("cover_image"));
                return restaurant;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getRestaurantCount() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM restaurants";

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

    public List<Restaurant> getRestaurantsSorted(String sort) throws SQLException {
        String query = "SELECT * FROM restaurants";

        if ("low".equals(sort)) {
            query += " ORDER BY minPrice ASC";
        } else if ("high".equals(sort)) {
            query += " ORDER BY minPrice DESC";
        } else if ("rating".equals(sort)) {
            query += " ORDER BY rating DESC";
        } else if ("fast".equals(sort)) {
            query += " ORDER BY deliveryTime ASC";
        }

        List<Restaurant> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = new Restaurant();
                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setOwnerName(rs.getString("owner_name"));
                restaurant.setEmail(rs.getString("email"));
                restaurant.setPhoneNumber(rs.getString("phone_number"));
                restaurant.setAddress(rs.getString("address"));
                restaurant.setDescription(rs.getString("description"));
                restaurant.setImageUrl(rs.getString("image_url"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setStatus(rs.getString("status"));
                restaurant.setCreatedAt(rs.getTimestamp("created_at"));
                restaurant.setCuisineType(rs.getString("cuisineType"));
                restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
                restaurant.setMinPrice(rs.getInt("minPrice"));
                restaurant.setPriceRange(rs.getString("priceRange"));
                restaurant.setCoverImage(rs.getString("cover_image"));
                list.add(restaurant);
            }
        }
        return list;
    }

    public List<Restaurant> getRestaurantsFiltered(String search, String sort) throws SQLException {
        String query = "SELECT * FROM restaurants WHERE restaurant_name LIKE ? OR cuisineType LIKE ?";

        if ("low".equals(sort)) {
            query += " ORDER BY minPrice ASC";
        } else if ("high".equals(sort)) {
            query += " ORDER BY minPrice DESC";
        } else if ("rating".equals(sort)) {
            query += " ORDER BY rating DESC";
        } else if ("fast".equals(sort)) {
            query += " ORDER BY deliveryTime ASC";
        }

        List<Restaurant> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Restaurant restaurant = new Restaurant();
                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setCuisineType(rs.getString("cuisineType"));
                restaurant.setDescription(rs.getString("description"));
                restaurant.setImageUrl(rs.getString("image_url"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
                restaurant.setMinPrice(rs.getInt("minPrice"));
                restaurant.setPriceRange(rs.getString("priceRange"));
                restaurant.setCoverImage(rs.getString("cover_image"));
                list.add(restaurant);
            }
        }
        return list;
    }

    public List<Restaurant> getOpenRestaurants(String search, String sort) throws SQLException {
        return getRestaurantsByStatus("ACTIVE", search, sort);
    }

    public List<Restaurant> getClosedRestaurants(String search, String sort) throws SQLException {
        return getRestaurantsByStatus("closed", search, sort);
    }

    public List<Restaurant> getRestaurantsByStatus(String status, String search, String sort) throws SQLException {
        String query = "SELECT * FROM restaurants WHERE status=?";

        if (search != null && !search.trim().isEmpty()) {
            query += " AND (restaurant_name LIKE ? OR cuisineType LIKE ?)";
        }

        if ("low".equals(sort)) query += " ORDER BY minPrice ASC";
        else if ("high".equals(sort)) query += " ORDER BY minPrice DESC";
        else if ("rating".equals(sort)) query += " ORDER BY rating DESC";
        else if ("fast".equals(sort)) query += " ORDER BY deliveryTime ASC";

        List<Restaurant> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, status);

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(2, "%" + search + "%");
                ps.setString(3, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setRestaurantName(rs.getString("restaurant_name"));
                r.setCuisineType(rs.getString("cuisineType"));
                r.setDescription(rs.getString("description"));
                r.setImageUrl(rs.getString("image_url"));
                r.setRating(rs.getDouble("rating"));
                r.setDeliveryTime(rs.getInt("deliveryTime"));
                r.setMinPrice(rs.getInt("minPrice"));
                r.setPriceRange(rs.getString("priceRange"));
                r.setCoverImage(rs.getString("cover_image"));
                list.add(r);
            }
        }
        return list;
    }

    public List<Restaurant> getRestaurantsByCuisine(String cuisine, String sort) throws SQLException {
        String query = "SELECT * FROM restaurants WHERE cuisineType=?";

        if ("low".equals(sort)) query += " ORDER BY minPrice ASC";
        else if ("high".equals(sort)) query += " ORDER BY minPrice DESC";
        else if ("rating".equals(sort)) query += " ORDER BY rating DESC";
        else if ("fast".equals(sort)) query += " ORDER BY deliveryTime ASC";

        List<Restaurant> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, cuisine);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setRestaurantName(rs.getString("restaurant_name"));
                r.setCuisineType(rs.getString("cuisineType"));
                r.setDescription(rs.getString("description"));
                r.setImageUrl(rs.getString("image_url"));
                r.setRating(rs.getDouble("rating"));
                r.setDeliveryTime(rs.getInt("deliveryTime"));
                r.setMinPrice(rs.getInt("minPrice"));
                r.setPriceRange(rs.getString("priceRange"));
                r.setCoverImage(rs.getString("cover_image"));
                list.add(r);
            }
        }
        return list;
    }

    public Restaurant getRestaurantByCuisine(String cuisine) {
        Restaurant restaurant = null;
        String sql = "SELECT * FROM restaurants WHERE cuisineType = ? LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, cuisine);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                restaurant = new Restaurant();
                restaurant.setRestaurantId(rs.getInt("restaurant_id"));
                restaurant.setRestaurantName(rs.getString("restaurant_name"));
                restaurant.setCuisineType(rs.getString("cuisineType"));
                restaurant.setStatus(rs.getString("status"));
                restaurant.setCoverImage(rs.getString("cover_image"));
                restaurant.setDescription(rs.getString("description"));
                restaurant.setImageUrl(rs.getString("image_url"));
                restaurant.setRating(rs.getDouble("rating"));
                restaurant.setDeliveryTime(rs.getInt("deliveryTime"));
                restaurant.setMinPrice(rs.getInt("minPrice"));
                restaurant.setPriceRange(rs.getString("priceRange"));
            } else {
                System.out.println("No restaurant found for cuisine = " + cuisine);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return restaurant;
    }
    public void updateStatus(int restaurantId, String status) {
        String sql = "UPDATE restaurants SET status = ? WHERE restaurant_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, restaurantId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void updateRestaurant(int restaurantId, String restaurantName,
            String cuisineType, String phoneNumber, String description,
            String address, int deliveryTime, int minPrice, String priceRange) {

        String sql = "UPDATE restaurants SET restaurant_name=?, cuisineType=?, phone_number=?, description=?, address=?, deliveryTime=?, minPrice=?, priceRange=? WHERE restaurant_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, restaurantName);
            ps.setString(2, cuisineType);
            ps.setString(3, phoneNumber);
            ps.setString(4, description);
            ps.setString(5, address);
            ps.setInt(6, deliveryTime);
            ps.setInt(7, minPrice);
            ps.setString(8, priceRange);
            ps.setInt(9, restaurantId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}