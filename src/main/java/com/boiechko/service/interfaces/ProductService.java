package com.boiechko.service.interfaces;

import com.boiechko.model.Product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.util.List;

public interface ProductService {

    List<Product> getProductsByColumnInRandomOrder(final String column, final String credentials);

    List<Product> getLatestAddedProducts();

    List<Product> groupByColumnWithCondition(final String condition, final String statement, final String column);

    List<Product> groupByColumn(final String column);

    List<Product> getPopularBrands();

    void addProduct(final Product product);

    Product getProductById(final int idProduct);

    List<Product> getAllProducts();

    void updateProduct(final Product product);

    void deleteProduct(final Product product);

    boolean saveImage(final Part image, final String destination);

    String getDestinationOfImage(final Part image, final String destination);

    List<String> getPathToProduct(final HttpServletRequest request, final Product product);


}
