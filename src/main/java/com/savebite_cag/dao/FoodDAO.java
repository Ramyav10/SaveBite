package com.savebite_cag.dao;

import java.util.List;
import com.savebite_cag.model.FoodItem;

public interface FoodDAO {

    List<FoodItem> getFoodsByRestaurant(int restaurantId);

    FoodItem getFoodById(int foodId);
}