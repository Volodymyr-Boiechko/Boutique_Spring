package com.boiechko.controller;

import com.boiechko.service.interfaces.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.stream.Collectors;

@Controller
public class HeaderController {

    private final ProductService productService;

    public HeaderController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/header")
    public String onHeader(final Model model) {

        model.addAttribute("newestProducts",
                productService.getLatestAddedProducts().stream().limit(30).collect(Collectors.toList()));

        model.addAttribute("clothesTypes",
                productService.groupByColumnWithCondition("typeName", "Одяг", "productName"));

        model.addAttribute("shoes",
                productService.groupByColumnWithCondition("typeName", "Взуття", "productName"));

        model.addAttribute("accessories",
                productService.groupByColumnWithCondition("typeName", "Аксесуари", "productName"));

        model.addAttribute("sportWear",
                productService.groupByColumnWithCondition("typeName", "Спортивний одяг", "productName"));

        model.addAttribute("brands", productService.getPopularBrands());

        return "components/header";
    }

}
