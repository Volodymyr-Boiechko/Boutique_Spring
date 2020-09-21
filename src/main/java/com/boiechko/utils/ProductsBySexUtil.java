package com.boiechko.utils;

import com.boiechko.model.Product;

import java.util.List;
import java.util.stream.Collectors;

public class ProductsBySexUtil {

    public static List<Product> getProductsBySex(final List<Product> products, final String sex) {

        String ukrSex;

        if (sex.equals("manClothes")) {
            ukrSex = "чоловік";
        } else {
            ukrSex = "жінка";
        }

        return products
                .stream()
                .filter(product -> product.getSex().equals(ukrSex))
                .collect(Collectors.toList());

    }

}
