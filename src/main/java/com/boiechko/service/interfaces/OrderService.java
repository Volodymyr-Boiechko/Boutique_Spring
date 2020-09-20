package com.boiechko.service.interfaces;

import com.boiechko.model.Order;
import com.boiechko.model.Product;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface OrderService {

    List<Order> getAllOrders();

    void addOrder(final Order order);

    Order getOrderById(final int idOrder);

    Map<Order, Set<Product>> sortUserOrders(final List<Order> userOrders);

    boolean isAddressHasOrder(final int idAddress, final List<Order> orders);

}
