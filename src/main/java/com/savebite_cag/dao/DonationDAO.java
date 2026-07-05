package com.savebite_cag.dao;

import java.util.List;
import com.savebite_cag.model.Donation;

public interface DonationDAO {

    boolean addDonation(Donation donation);

    List<Donation> getAllDonations();

    boolean acceptDonation(int donationId);
    
    List<Donation> getDonationsByStatus(String status);
    void deleteDonation(int donationId);
}
