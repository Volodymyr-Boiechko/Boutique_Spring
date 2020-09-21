package com.boiechko.dao.interfaces;

import com.boiechko.model.Product;

import java.util.List;

public interface ProductDao extends Dao<Product> {

    List<Product> getProductsByColumnInRandomOrder(final String column, final String credentials);

    List<Product> getLatestAddedProducts();

    List<Product> groupByColumn(final String column);

}
