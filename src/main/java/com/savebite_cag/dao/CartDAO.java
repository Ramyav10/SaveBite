package com.savebite_cag.dao;

import java.util.List;
import com.savebite_cag.model.Cart;

public interface CartDAO {

    boolean addToCart(Cart cart);

    List<Cart> getCartByUser(int userId);

    boolean removeFromCart(int cartId);
    boolean clearCart(int userId);
}
