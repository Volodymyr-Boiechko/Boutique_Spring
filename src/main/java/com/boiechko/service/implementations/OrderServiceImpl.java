package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.OrderDao;
import com.boiechko.model.Order;
import com.boiechko.service.interfaces.OrderService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderDao orderDao;

    public OrderServiceImpl(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    @Override
    public List<Order> getAllOrders() { return orderDao.getAll(); }

    @Override
    public void addOrder(final Order order) {
        orderDao.add(order);
    }

    @Override
    public Order getOrderById(final int idOrder) { return orderDao.getById(idOrder); }

    @Override
    public boolean isAddressHasOrder(final int idAddress) {
        throw new UnsupportedOperationException();
    }

}
