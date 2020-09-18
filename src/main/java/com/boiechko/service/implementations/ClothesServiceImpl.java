package com.boiechko.service.implementations;

import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.ProductService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ClothesServiceImpl implements ClothesService {

    private final int NUMBER_OF_PRODUCTS_PER_PAGE = 3;

    private final ProductService productService;

    public ClothesServiceImpl(ProductService productService) {
        this.productService = productService;
    }

    @Override
    public List<Product> getListOfClothes(final HttpServletRequest request) {

        final String[] urlPages = request.getRequestURI().split("/");

        List<Product> clothes;

        switch (urlPages[3]) {
            case "clothes":
            case "shoes":
            case "accessories":
            case "sportWear": {

                final String productName = request.getParameter("productName");
                clothes = getClothes(productName, urlPages[3]);
                break;
            }
            case "newestClothes": {

                clothes = productService.getLatestAddedProducts();
                break;
            }
            case "brands": {

                final String brand = request.getParameter("brand");
                clothes = productService.getProductsByColumnInRandomOrder("brand", brand);
                break;
            }
            default:
                clothes = new ArrayList<>();

        }

        return clothes;

    }

    @Override
    public int getNumberOfProductsShownOnPage(final int page, final int clothesSize) {

        int NumberOfProductsShownOnPage = page * NUMBER_OF_PRODUCTS_PER_PAGE;

        if (NumberOfProductsShownOnPage > clothesSize) {
            NumberOfProductsShownOnPage = clothesSize;
        }

        return NumberOfProductsShownOnPage;
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
    public boolean isProductInShoppingBag(final List<Product> shoppingBag, final Product product) {
        return shoppingBag.stream()
                .anyMatch(productFromShoppingBag -> productFromShoppingBag.equals(product));
    }

    private List<Product> getClothes(final String productName, final String typeName) {

        if (productName == null) {
            return productService.getProductsByColumnInRandomOrder("typeName", productService.getUkrainianTypeName(typeName));
        } else {
            return productService.getProductsByColumnInRandomOrder("productName", productName);
        }
    }

}
