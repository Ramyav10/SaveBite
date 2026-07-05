package com.savebite_cag.dao;

import java.util.List;
import com.savebite_cag.model.Restaurant;

public interface RestaurantDAO {

    boolean addRestaurant(Restaurant restaurant);

    List<Restaurant> getAllRestaurants();

    Restaurant getRestaurantById(int restaurantId);
}
