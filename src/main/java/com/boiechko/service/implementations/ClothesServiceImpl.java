package com.boiechko.service.implementations;

import com.boiechko.model.OrderDetails;
import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.ProductService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ClothesServiceImpl implements ClothesService {

    private final ProductService productService;

    public ClothesServiceImpl(ProductService productService) {
        this.productService = productService;
    }

    @Override
    public List<Product> getListOfClothes(final String typeName, final String productName, final String sex) {

        List<Product> clothes;

        switch (typeName) {
            case "clothes":
            case "shoes":
            case "accessories":
            case "sportWear": {

                clothes = getClothes(typeName, productName);
                break;
            }
            case "newestClothes": {

                clothes = productService.getLatestAddedProducts();
                break;
            }
            case "brands": {

                clothes = productService.getPopularBrands();
                break;
            }
            default:
                clothes = new ArrayList<>();

        }

        return productService.getProductsBySex(clothes, sex);

    }

    @Override
    public List<Product> getFavoriteProducts(final List<Integer> idsOfProductsWhichAreFavorite) {

        return idsOfProductsWhichAreFavorite.stream()
                .map(productService::getProductById)
                .collect(Collectors.toList());
    }

    @Override
    public boolean isFavoriteProduct(List<Integer> idsOfProductsWhichAreFavorite, Product product) {
        return idsOfProductsWhichAreFavorite.stream()
                .anyMatch(idProduct -> idProduct == product.getIdProduct());
    }

    @Override
    public boolean isProductInShoppingBag(final Set<Product> shoppingBag, final Product product) {
        return shoppingBag.stream()
                .anyMatch(productFromShoppingBag -> productFromShoppingBag.equals(product));
    }

    public void updateOrderDetailsInProducts(final Set<Product> products, final List<OrderDetails> orderDetails) {

        for (Product product : products) {

            for (OrderDetails orderDetail : orderDetails) {

                if (product.getIdProduct() == orderDetail.getIdProduct()) {
                    product.setQuantity(orderDetail.getQuantity());
                }

            }

        }

    }

    private List<Product> getClothes(final String typeName, final String productName) {

        if (productName == null) {
            return productService.getProductsByColumn("typeName", productService.getUkrainianTypeName(typeName));
        } else {
            return productService.getProductsByColumn("productName", productName);
        }
    }

}
