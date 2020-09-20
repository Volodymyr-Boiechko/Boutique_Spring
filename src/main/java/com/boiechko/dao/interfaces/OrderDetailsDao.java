package com.boiechko.dao.interfaces;

import com.boiechko.model.OrderDetails;

import java.util.List;

public interface OrderDetailsDao {

    void addOrderDetails(final OrderDetails orderDetails);

    void updateOrderDetail(final OrderDetails orderDetail);

    List<OrderDetails> getOrderDetailsByOrderId(final int idOrder);

}
