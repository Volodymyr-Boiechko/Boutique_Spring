package com.boiechko.service.interfaces;

import com.boiechko.model.OrderDetails;

import java.util.List;

public interface OrderDetailsService {

    void updateOrderDetailQuantities(final List<OrderDetails> orderDetails, final String[] arrayOfProductsQuantities);

    List<OrderDetails> getOrderDetailsByOrderId(final int idOrder);

}
