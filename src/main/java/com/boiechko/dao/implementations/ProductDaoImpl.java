package com.boiechko.dao.implementations;

import com.boiechko.dao.interfaces.ProductDao;
import com.boiechko.model.Product;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class ProductDaoImpl implements ProductDao {

    private final int NUMBER_OF_PRODUCTS_TO_MAKE_BRAND_POPULAR = 7;

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
    public List<Product> getProducts(final String typeName, final String productName, final String sex) {

        final String queryString = createStringQueryForSelectingProducts(typeName, productName);

        final Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery(queryString)
                .setParameter(1, sex);

        return query.list();

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> getProductsWithFilters(final String sortBy, final String typeName, final String productName, final String sex,
                                                final String[] selectedBrands, final String[] selectedColors,
                                                final String[] selectedSizes, final int minPrice, final int maxPrice) {

        String queryString = createStringQueryForSelectingProducts(typeName, productName);

        queryString += " AND product.price >=?2 AND product.price <=?3";

        if (selectedBrands != null) {
            queryString += " AND product.brand IN (:brands)";
        }

        if (selectedColors != null) {
            queryString += " AND product.color IN (:colors)";
        }

        if (selectedSizes != null) {
            queryString += " AND product.size IN (:sizes)";
        }

        if (sortBy.contains("Новинки")) {
            queryString += " ORDER BY product.idProduct DESC";
        } else if (sortBy.equals("Сортувати за зростанням")) {
            queryString += " ORDER BY product.price ASC";
        } else if (sortBy.equals("Сортувати за спаданням")) {
            queryString += " ORDER BY product.price DESC";
        }

        final Query<Product> query = sessionFactory.getCurrentSession()
                .createQuery(queryString)
                .setParameter(1, sex)
                .setParameter(2, minPrice)
                .setParameter(3, maxPrice);

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

    public String createStringQueryForSelectingProducts(final String typeName, final String productName) {

        String queryString;
        final boolean isClothes = typeName.equals("Одяг") || typeName.equals("Взуття") || typeName.equals("Аксесуари") || typeName.equals("Спортивний одяг");

        if (typeName.equals("Новинки")) {
            queryString = "FROM Product product WHERE product.sex=?1";
        } else if (typeName.equals("Популярні бренди")) {

            queryString = "FROM Product product " +
                    "WHERE product.brand IN " +
                    "(SELECT brand FROM Product GROUP BY brand HAVING COUNT(brand) >= " + NUMBER_OF_PRODUCTS_TO_MAKE_BRAND_POPULAR + ") " +
                    "AND product.sex=?1";

        } else if (isClothes && productName == null) {

            queryString = "FROM Product product WHERE product.sex=?1 AND product.typeName = '" + typeName +"'";

        } else {
            queryString = "FROM Product product WHERE product.sex=?1 AND product.productName = '" + productName + "'";
        }

        return queryString;

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
