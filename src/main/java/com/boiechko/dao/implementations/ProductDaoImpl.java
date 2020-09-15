package com.boiechko.dao.implementations;

import com.boiechko.dao.interfaces.ProductDao;
import com.boiechko.model.Product;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDaoImpl implements ProductDao {

    private final SessionFactory sessionFactory;

    public ProductDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> getProductsByColumnInRandomOrder(final String column, final String credentials) {

        Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery("FROM Product WHERE " + column + "=?1 order by RAND()")
                .setParameter(1, credentials);

        return query.list();

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> getLatestAddedProducts() {

        Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery("FROM Product ORDER BY idProduct DESC");

        return query.list();


    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> groupByColumnWithCondition(final String condition, final String statement, final String column) {

        Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery("FROM Product WHERE " + condition + "=?1 GROUP BY " + column)
                .setParameter(1, statement);

        return query.list();

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> groupByColumn(final String column) {

        Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery("FROM Product GROUP BY " + column);

        return query.list();

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> getAll() {
        return sessionFactory.getCurrentSession().createQuery("from Product").list();
    }

    @Override
    public void add(final Product product) {
        sessionFactory.getCurrentSession().persist(product);
    }

    @Override
    public Product getById(final int id) {
        return sessionFactory.getCurrentSession().get(Product.class, id);
    }

    @Override
    public void update(final Product product) {
        sessionFactory.getCurrentSession().update(product);
    }

    @Override
    public void delete(final Product product) {
        sessionFactory.getCurrentSession().remove(product);
    }
}
