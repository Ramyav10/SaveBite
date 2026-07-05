package com.savebite_cag.model;
import java.sql.Timestamp;



public class User {
	private int userId;
	private String fullName;
	private String email;
	private String phoneNumber;
	private String password;
	private String role;
	private String address;
	private Timestamp createdAt;
	private Timestamp lastLogin;
	private Integer restaurantId;
	private String status;
	public String getStatus() { return status; }
	public void setStatus(String status) { this.status = status; }

	public Integer getRestaurantId() {
	    return restaurantId;
	}

	public void setRestaurantId(Integer restaurantId) {
	    this.restaurantId = restaurantId;
	}
	
	public User(String fullName, String email, String phoneNumber, String password, String role,
			String address) {
		super();
		this.fullName = fullName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.password = password;
		this.role = role;
		this.address = address;
	}
	public User() {
		
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", phoneNumber=" + phoneNumber
				+ ", password=" + password + ", role=" + role + ", address=" + address + "]";
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getLastLogin() {
		return lastLogin;
	}
	public void setLastLogin(Timestamp lastLogin) {
		this.lastLogin = lastLogin;
	}

}
