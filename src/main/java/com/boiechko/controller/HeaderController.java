package com.boiechko.controller;

import com.boiechko.service.interfaces.ProductService;
import com.boiechko.utils.ProductsBySexUtil;
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

        model.addAttribute("newestProducts", ProductsBySexUtil.getProductsBySex(
                productService.getLatestAddedProducts().stream().limit(30).collect(Collectors.toList()), sex));

        model.addAttribute("clothesTypes", ProductsBySexUtil.getProductsBySex(
                productService.groupByColumnWithCondition("typeName", "Одяг", "productName"), sex));

        model.addAttribute("shoes", ProductsBySexUtil.getProductsBySex(
                productService.groupByColumnWithCondition("typeName", "Взуття", "productName"), sex));

        model.addAttribute("accessories", ProductsBySexUtil.getProductsBySex(
                productService.groupByColumnWithCondition("typeName", "Аксесуари", "productName"), sex));

        model.addAttribute("sportWear", ProductsBySexUtil.getProductsBySex(
                productService.groupByColumnWithCondition("typeName", "Спортивний одяг", "productName"), sex));

        model.addAttribute("brands", ProductsBySexUtil.getProductsBySex(productService.getPopularBrands(), sex));

        return "components/header";
    }

}
