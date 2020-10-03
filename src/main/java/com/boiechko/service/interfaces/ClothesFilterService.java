package com.boiechko.service.interfaces;

import com.boiechko.model.Product;

import java.util.List;

public interface ClothesFilterService {

    List<String> getAllBrandsOfClothes(final List<Product> clothes);

    List<String> getAllColorsOfClothes(final List<Product> clothes);

    List<String> getAllModelsOfClothes(final List<Product> clothes);

    List<Product> getProductsWithFilters(final String sortBy, final String typeName, final String productName, final String sex,
                                         final String[] selectedBrands,
                                         final String[] selectedColors,
                                         final String[] selectedSizes, final int minPrice, final int maxPrice);

    int getMinPriceOfClothes(final List<Product> clothes);

    int getMaxPriceOfClothes(final List<Product> clothes);

}
