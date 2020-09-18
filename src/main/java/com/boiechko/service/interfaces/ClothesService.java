package com.boiechko.service.interfaces;

import com.boiechko.model.Product;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface ClothesService {

    List<Product> getListOfClothes(final HttpServletRequest request);

    int getNumberOfProductsShownOnPage(final int page, final int clothesSize);

    List<Product> getFavoriteProducts(final List<Integer> idsOfProductsWhichAreFavorite);

    boolean isFavoriteProduct(final List<Integer> idsOfProductsWhichAreFavorite, final Product product);

}
