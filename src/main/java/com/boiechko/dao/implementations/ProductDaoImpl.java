package com.boiechko.dao.implementations;

import com.boiechko.dao.interfaces.ProductDao;
import com.boiechko.model.Product;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Repository
@Transactional
public class ProductDaoImpl implements ProductDao {

    private final SessionFactory sessionFactory;

    public ProductDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> getProductsByColumn(final String column, final String credentials) {

        Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery("FROM Product WHERE " + column + "=?1")
                .setParameter(1, credentials);

        return query.list();

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> getLatestAddedProducts() {

        Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery("FROM Product ORDER BY idProduct DESC");

        return query.list().stream().limit(30).collect(Collectors.toList());

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> getProductsWithFilters(final String sortBy, final String typeName, final String productName, final String sex,
                                                final String[] selectedBrands, final String[] selectedColors,
                                                final String[] selectedSizes, final int minPrice, final int maxPrice) {

        String queryString = "FROM Product product WHERE typeName=?1 AND sex=?2 AND price >=?3 AND price <=?4";

        if (productName != null) {
            queryString += " AND product.productName = '" + productName + "'";
        }

        if (selectedBrands != null) {
            queryString += " AND brand IN (:brands)";
        }

        if (selectedColors != null) {
            queryString += " AND color IN (:colors)";
        }

        if (selectedSizes != null) {
            queryString += " AND product.size IN (:sizes)";
        }

        switch (sortBy) {
            case "Новинки": queryString += " ORDER BY product.idProduct ASC"; break;
            case "Сортувати за зростанням": queryString += " ORDER BY product.price ASC"; break;
            case "Сортувати за спаданням": queryString += " ORDER BY product.price DESC"; break;
        }

        final Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery(queryString)
                .setParameter(1, typeName)
                .setParameter(2, sex)
                .setParameter(3, minPrice)
                .setParameter(4, maxPrice);

        if (selectedBrands != null) {
            query.setParameterList("brands", selectedBrands);
        }
        if (selectedColors != null) {
            query.setParameterList("colors", selectedColors);
        }
        if (selectedSizes != null) {
            query.setParameterList("sizes", selectedSizes);
        }

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
