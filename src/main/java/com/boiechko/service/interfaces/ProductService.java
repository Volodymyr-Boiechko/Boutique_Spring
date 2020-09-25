package com.boiechko.service.interfaces;

import com.boiechko.model.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductService {

    List<Product> getProductsByColumnInRandomOrder(final String column, final String credentials);

    List<Product> getLatestAddedProducts();

    List<Product> getUniqueProductNames(final String typeName, final String sex);

    List<Product> groupByColumn(final String column);

    List<Product> getUniqueNamesOfPopularBrands();

    List<Product> getPopularBrands();

    List<Product> getProductsThatUserMayLike(final Product product);

    List<Product> getProductsBySex(final List<Product> products, final String sex);

    void addProduct(final Product product);

    Product getProductById(final int idProduct);

    List<Product> getAllProducts();

    void updateProduct(final Product product);

    void deleteProduct(final Product product);

    boolean saveImageOfProduct(final MultipartFile image, final String destination);

    String getDestinationOfImage(final MultipartFile image, final String destination);

    String getUkrainianSex(final String englishSex);

    String getUkrainianTypeName(final String englishTypeName);

    String getEnglishTypeName(final String ukrainianTypeName);

    String getPathToPage(final String typeName, final String productName);

}
