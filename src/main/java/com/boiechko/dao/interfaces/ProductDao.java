package com.boiechko.dao.interfaces;

import com.boiechko.model.Product;

import java.util.List;

public interface ProductDao extends Dao<Product> {

    List<Product> getProductsByColumn(final String column, final String credentials);


    List<Product> getProducts(final String typeName, final String productName, final String sex);

    List<Product> getProductsWithFilters(final String sortBy, final String typeName, final String productName, final String sex,
                                         final String[] selectedBrands, final String[] selectedColors,
                                         final String[] selectedSizes, final int minPrice, final int maxPrice);

}
