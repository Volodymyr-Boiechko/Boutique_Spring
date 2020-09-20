package com.boiechko.service.interfaces;

import com.boiechko.model.Order;

import java.util.List;

public interface OrderService {

    List<Order> getAllOrders();

    void addOrder(final Order order);

    Order getOrderById(final int idOrder);

    boolean isAddressHasOrder(final int idAddress);

}
