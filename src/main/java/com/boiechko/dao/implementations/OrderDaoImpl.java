package com.boiechko.dao.implementations;

import com.boiechko.dao.interfaces.OrderDao;
import com.boiechko.model.Order;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class OrderDaoImpl implements OrderDao {

    private final SessionFactory sessionFactory;

    public OrderDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Order> getAll() {
        return sessionFactory.getCurrentSession().createQuery("FROM Order").list();
    }

    @Override
    public void add(final Order order) {
        sessionFactory.getCurrentSession().persist(order);
    }

    @Override
    public Order getById(final int id) {
        return sessionFactory.getCurrentSession().get(Order.class, id);
    }

    @Override
    public void update(final Order order) {
        throw new UnsupportedOperationException();
    }

    @Override
    public void delete(final Order order) {
        throw new UnsupportedOperationException();
    }

}
