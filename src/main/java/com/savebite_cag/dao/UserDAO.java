package com.savebite_cag.dao;
import java.util.List;

import com.savebite_cag.model.User;

public interface UserDAO {

	    boolean addUser(User user);

	    User getUserByEmail(String email);

	    boolean validateUser(String email, String password);
	    void updateLastLogin(String email);
	    List<User> getAllUsers();
}


