package com.boiechko.service.implementations;

import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ClothesFilterService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ClothesFilterServiceImpl implements ClothesFilterService {

    @Override
    public List<String> getAllBrandsOfClothes(final List<Product> clothes) {

        return clothes
                .stream()
                .map(Product::getBrand)
                .distinct()
                .sorted()
                .collect(Collectors.toList());

    }

    @Override
    public List<String> getAllColorsOfClothes(final List<Product> clothes) {
        return clothes
                .stream()
                .map(Product::getColor)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }

    @Override
    public List<String> getAllModelsOfClothes(List<Product> clothes) {
        return clothes
                .stream()
                .map(Product::getModel)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }
}
