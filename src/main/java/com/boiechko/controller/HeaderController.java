package com.boiechko.controller;

import com.boiechko.service.interfaces.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.stream.Collectors;

@Controller
public class HeaderController {

    private final ProductService productService;

    public HeaderController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/header")
    public String onHeader(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final String sex = (String) session.getAttribute("sex");

        model.addAttribute("newestProducts", productService.getProductsBySex(
                productService.getLatestAddedProducts().stream().limit(30).collect(Collectors.toList()), sex));

        model.addAttribute("clothesTypes", productService.getUniqueProductNames("Одяг", sex));

        model.addAttribute("shoes", productService.getUniqueProductNames("Взуття", sex));

        model.addAttribute("accessories", productService.getUniqueProductNames("Аксесуари", sex));

        model.addAttribute("sportWear", productService.getUniqueProductNames("Спортивний одяг", sex));

        model.addAttribute("brands", productService.getProductsBySex(productService.getUniqueNamesOfPopularBrands(), sex));

        return "components/header";
    }

}
