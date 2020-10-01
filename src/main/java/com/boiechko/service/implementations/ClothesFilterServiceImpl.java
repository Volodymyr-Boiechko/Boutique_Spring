package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.ProductDao;
import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ClothesFilterService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class ClothesFilterServiceImpl implements ClothesFilterService {

    private final Logger logger = Logger.getLogger(ClothesFilterServiceImpl.class);

    private final ProductDao productDao;

    public ClothesFilterServiceImpl(ProductDao productDao) {
        this.productDao = productDao;
    }

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

    @Override
    public List<Product> getProductsWithFilters(final String typeName, final String productName, final String sex,
                                                final String[] selectedBrands, final String[] selectedColors,
                                                final String[] selectedSizes, final int minPrice, final int maxPrice) {

        return productDao.getProductsWithFilters(typeName, productName, sex,
                selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);
    }

    @Override
    public int getMinPriceOfClothes(final List<Product> clothes) {

        final Product productWithLowestPrice = clothes
                .stream()
                .min(Comparator.comparing(Product::getPrice))
                .orElseThrow(NoSuchElementException::new);

        return productWithLowestPrice.getPrice();

    }

    @Override
    public int getMaxPriceOfClothes(List<Product> clothes) {

        return clothes
                .stream()
                .map(Product::getPrice)
                .mapToInt(value -> value)
                .max()
                .orElseThrow(NoSuchElementException::new);
    }

}
