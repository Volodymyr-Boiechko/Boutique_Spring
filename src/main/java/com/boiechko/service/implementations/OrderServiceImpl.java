package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.OrderDao;
import com.boiechko.model.Order;
import com.boiechko.model.Product;
import com.boiechko.service.interfaces.OrderService;
import org.springframework.stereotype.Service;

import java.util.*;

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
    public Map<Order, Set<Product>> sortUserOrders(final List<Order> userOrders) {

        final Map<Order, Set<Product>> allOrdersOfUser = new HashMap<>();
        userOrders.forEach(order -> allOrdersOfUser.put(order, order.getProducts()));

        Map<Order, Set<Product>> treeMap = new TreeMap<>(
                (o1, o2) -> Integer.compare(o2.getIdOrder(), o1.getIdOrder())
        );

        treeMap.putAll(allOrdersOfUser);

        return treeMap;

    }

    @Override
    public boolean isAddressHasOrder(final int idAddress, final List<Order> orders) {

        return orders
                .stream()
                .noneMatch(order -> order.getIdAddress() == idAddress);

    }

}
