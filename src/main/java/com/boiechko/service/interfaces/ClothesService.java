package com.boiechko.service.interfaces;

import com.boiechko.model.OrderDetails;
import com.boiechko.model.Product;

import java.util.List;
import java.util.Set;

public interface ClothesService {

    List<Product> getListOfClothes(final String typeName, final String productName, final String sex);

    List<Product> getFavoriteProducts(final List<Integer> idsOfProductsWhichAreFavorite);

    boolean isFavoriteProduct(final List<Integer> idsOfProductsWhichAreFavorite, final Product product);

    boolean isProductInShoppingBag(final Set<Product> shoppingBag, final Product product);

    void updateOrderDetailsInProducts(final Set<Product> products, final List<OrderDetails> orderDetails);

}
