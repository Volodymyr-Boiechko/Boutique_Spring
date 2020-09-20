package com.boiechko.dao.implementations;

import com.boiechko.dao.interfaces.OrderDetailsDao;
import com.boiechko.model.OrderDetails;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class OrderDetailsDaoImpl implements OrderDetailsDao {

    private final SessionFactory sessionFactory;

    public OrderDetailsDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addOrderDetails(final OrderDetails orderDetails) {
        sessionFactory.getCurrentSession().persist(orderDetails);
    }

    @Override
    public void updateOrderDetail(final OrderDetails orderDetail) {
        sessionFactory.getCurrentSession().update(orderDetail);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<OrderDetails> getOrderDetailsByOrderId(final int idOrder) {

        Query<OrderDetails> query = sessionFactory.getCurrentSession()
                .createQuery("FROM OrderDetails WHERE idOrder=?1")
                .setParameter(1, idOrder);

        return query.list();

    }
}
