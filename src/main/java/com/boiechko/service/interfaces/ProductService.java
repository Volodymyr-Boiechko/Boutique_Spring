package com.boiechko.service.interfaces;

import com.boiechko.model.Product;

import javax.servlet.http.Part;
import java.util.List;

public interface ProductService {

    List<Product> getProductsByColumnInRandomOrder(final String column, final String credentials);

    List<Product> getLatestAddedProducts();

    List<Product> groupByColumnWithCondition(final String condition, final String statement, final String column);

    List<Product> groupByColumn(final String column);

    List<Product> getPopularBrands();

    List<Product> getProductsThatUserMayLike(final Product product);

    void addProduct(final Product product);

    Product getProductById(final int idProduct);

    List<Product> getAllProducts();

    void updateProduct(final Product product);

    void deleteProduct(final Product product);

    boolean saveImageOfProduct(final Part image, final String destination);

    String getDestinationOfImage(final Part image, final String destination);

    String getUkrainianSex(final String englishSex);

    String getUkrainianTypeName(final String englishTypeName);

    String getEnglishTypeName(final String ukrainianTypeName);

}
