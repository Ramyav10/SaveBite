package com.savebite_cag.dao;

import java.util.List;
import com.savebite_cag.model.Payment;

public interface PaymentDAO {

    boolean addPayment(Payment payment);

    List<Payment> getPaymentsByOrder(int orderId);
}
