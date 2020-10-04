package com.boiechko.controller;

import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class HeaderController {

    private final ClothesService clothesService;
    private final ProductService productService;

    public HeaderController(ClothesService clothesService, ProductService productService) {
        this.clothesService = clothesService;
        this.productService = productService;
    }

    @GetMapping("/header")
    public String onHeader(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final String sex = (String) session.getAttribute("sex");

        model.addAttribute("newestProducts", clothesService.getListOfClothes("newestClothes", null, sex));

        model.addAttribute("clothesTypes", productService.getUniqueProductNames("Одяг", sex));

        model.addAttribute("shoes", productService.getUniqueProductNames("Взуття", sex));

        model.addAttribute("accessories", productService.getUniqueProductNames("Аксесуари", sex));

        model.addAttribute("sportWear", productService.getUniqueProductNames("Спортивний одяг", sex));

        model.addAttribute("brands", productService.getUniqueNamesOfPopularBrands(sex));

        return "components/header";
    }

}
