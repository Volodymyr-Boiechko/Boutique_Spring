package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.OrderDetailsDao;
import com.boiechko.model.OrderDetails;
import com.boiechko.service.interfaces.OrderDetailsService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class OrderDetailsServiceImpl implements OrderDetailsService {

    private final OrderDetailsDao orderDetailsDao;

    public OrderDetailsServiceImpl(OrderDetailsDao orderDetailsDao) {
        this.orderDetailsDao = orderDetailsDao;
    }

    @Override
    public void updateOrderDetailQuantities(final List<OrderDetails> orderDetails, final String[] arrayOfProductsQuantities) {

        final AtomicInteger index = new AtomicInteger(0);

        orderDetails
                .stream()
                .peek(orderDetail -> orderDetail.setQuantity(Integer.parseInt(
                        arrayOfProductsQuantities[index.getAndIncrement()])))
                .forEach(orderDetailsDao::updateOrderDetail);

    }

    @Override
    public List<OrderDetails> getOrderDetailsByOrderId(final int idOrder) {
        return orderDetailsDao.getOrderDetailsByOrderId(idOrder);
    }
}
