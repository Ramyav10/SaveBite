package com.savebite_cag.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.savebite_cag.dao.DonationDAO;
import com.savebite_cag.model.Donation;
import com.savebite_cag.utility.DBConnection;

public class DonationDAOImpl implements DonationDAO {

    @Override
    public boolean addDonation(Donation donation) {
        String query = "INSERT INTO donations(restaurant_id,food_name,quantity,expiry_time,pickup_address,donation_status) VALUES(?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, donation.getRestaurantId());
            pstmt.setString(2, donation.getFoodName());
            pstmt.setInt(3, donation.getQuantity());
            pstmt.setString(4, donation.getExpiryTime());
            pstmt.setString(5, donation.getPickupAddress());
            pstmt.setString(6, "AVAILABLE");

            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Donation> getAllDonations() {
        List<Donation> list = new ArrayList<>();
        String query = "SELECT d.*, r.restaurant_name FROM donations d JOIN restaurants r ON d.restaurant_id = r.restaurant_id ORDER BY d.donation_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapDonation(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean acceptDonation(int donationId) {
        String query = "UPDATE donations SET donation_status='COLLECTED' WHERE donation_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, donationId);
            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Donation> getDonationsByStatus(String status) {
        List<Donation> list = new ArrayList<>();
        String query = "SELECT d.*, r.restaurant_name FROM donations d JOIN restaurants r ON d.restaurant_id = r.restaurant_id WHERE d.donation_status=? ORDER BY d.donation_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setString(1, status.trim());
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapDonation(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get donations by restaurant
    public List<Donation> getDonationsByRestaurant(int restaurantId) {
        List<Donation> list = new ArrayList<>();
        String query = "SELECT d.*, r.restaurant_name FROM donations d JOIN restaurants r ON d.restaurant_id = r.restaurant_id WHERE d.restaurant_id=? ORDER BY d.donation_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapDonation(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getDonationCount() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM donations";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // Helper method to map ResultSet to Donation
    private Donation mapDonation(ResultSet rs) throws Exception {
        Donation donation = new Donation();
        donation.setDonationId(rs.getInt("donation_id"));
        donation.setRestaurantId(rs.getInt("restaurant_id"));
        donation.setFoodName(rs.getString("food_name"));
        donation.setQuantity(rs.getInt("quantity"));
        donation.setExpiryTime(rs.getString("expiry_time"));
        donation.setPickupAddress(rs.getString("pickup_address"));
        donation.setDonationStatus(rs.getString("donation_status"));
        donation.setCreatedAt(rs.getTimestamp("donation_date"));
        donation.setRestaurantName(rs.getString("restaurant_name"));
        return donation;
    }
    public void deleteDonation(int donationId) {
        String sql = "DELETE FROM donations WHERE donation_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, donationId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}