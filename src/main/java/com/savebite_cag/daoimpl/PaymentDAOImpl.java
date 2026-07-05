package com.savebite_cag.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.savebite_cag.dao.PaymentDAO;
import com.savebite_cag.model.Payment;
import com.savebite_cag.utility.DBConnection;

public class PaymentDAOImpl implements PaymentDAO {

    private Connection con;

    public PaymentDAOImpl() {
        con = DBConnection.getConnection();
    }

    @Override
    public boolean addPayment(Payment payment) {

        String query =
        "INSERT INTO payments(order_id,amount,payment_method,payment_status) VALUES(?,?,?,?)";

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(query);

            pstmt.setInt(1, payment.getOrderId());
            pstmt.setDouble(2, payment.getAmount());
            pstmt.setString(3, payment.getPaymentMethod());
            pstmt.setString(4, payment.getPaymentStatus());

            return pstmt.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Payment> getPaymentsByOrder(int orderId) {

        List<Payment> payments = new ArrayList<>();

        String query =
                "SELECT * FROM payments WHERE order_id=?";

        try {

            PreparedStatement pstmt =
                    con.prepareStatement(query);

            pstmt.setInt(1, orderId);

            ResultSet rs = pstmt.executeQuery();

            while(rs.next()) {

                Payment payment = new Payment();

                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setPaymentDate(rs.getTimestamp("payment_date"));

                payments.add(payment);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return payments;
    }
}
