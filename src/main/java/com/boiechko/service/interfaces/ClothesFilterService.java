package com.boiechko.service.interfaces;

import com.boiechko.model.Product;

import java.util.List;

public interface ClothesFilterService {

    List<String> getAllBrandsOfClothes(final List<Product> clothes);

    List<String> getAllColorsOfClothes(final List<Product> clothes);

    List<String> getAllModelsOfClothes(final List<Product> clothes);

}
