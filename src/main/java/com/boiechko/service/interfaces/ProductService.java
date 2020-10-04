package com.boiechko.service.interfaces;

import com.boiechko.model.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductService {

    List<Product> getUniqueProductNames(final String typeName, final String sex);

    List<Product> getUniqueNamesOfPopularBrands(final String sex);

    List<Product> getProductsThatUserMayLike(final Product product, final String sex);

    boolean saveImageOfProduct(final MultipartFile image, final String destination);

    String getDestinationOfImage(final MultipartFile image, final String destination);

    String getUkrainianSex(final String englishSex);

    String getUkrainianTypeName(final String englishTypeName);

    String getEnglishTypeName(final String ukrainianTypeName);

    String getPathToPage(final String typeName, final String productName);

    void addProduct(final Product product);

    Product getProductById(final int idProduct);

    List<Product> getAllProducts();

    void updateProduct(final Product product);

    void deleteProduct(final Product product);

}
