package com.boiechko.controller;

import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ClothesFilterService;
import com.boiechko.service.interfaces.ProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class ClothesFiltersController {

    private final ClothesFilterService clothesFilterService;
    private final ProductService productService;

    public ClothesFiltersController(ClothesFilterService clothesFilterService, ProductService productService) {
        this.clothesFilterService = clothesFilterService;
        this.productService = productService;
    }

    @GetMapping(value = "/clothesFilterPage")
    public String onClothesFilters(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final List<Product> clothes = (List<Product>) session.getAttribute("clothes");

        model.addAttribute("minPrice", clothesFilterService.getMinPriceOfClothes(clothes));
        model.addAttribute("maxPrice", clothesFilterService.getMaxPriceOfClothes(clothes));
        model.addAttribute("brands", clothesFilterService.getAllBrandsOfClothes(clothes));
        model.addAttribute("colors", clothesFilterService.getAllColorsOfClothes(clothes));
        model.addAttribute("sizes", Arrays.asList("XS", "S", "M", "L", "XL", "XXL"));

        return "components/clothesFilters";
    }

    @GetMapping(value = "/filterClothes")
    public @ResponseBody
    ResponseEntity<List<Product>> filterClothes(@RequestParam(value = "selectedBrands[]", required = false) String[] selectedBrands,
                                                @RequestParam(value = "selectedColors[]", required = false) String[] selectedColors,
                                                @RequestParam(value = "selectedSizes[]", required = false) String[] selectedSizes,
                                                @RequestParam(value = "minPrice", required = false) final int minPrice,
                                                @RequestParam(value = "maxPrice", required = false) final int maxPrice,
                                                final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final List<Product> clothes = (List<Product>) session.getAttribute("clothes");
        final String typeName = (String) session.getAttribute("typeName");
        final String productName = (String) session.getAttribute("productName");
        final String sex = (String) session.getAttribute("sex");

        final List<Product> filteredClothes = clothesFilterService
                .getProductsWithFilters(productService.getUkrainianTypeName(typeName), productName,
                        productService.getUkrainianSex(sex), selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);

        if (filteredClothes.isEmpty()) {
            return ResponseEntity.ok(new ArrayList<Product>());
        }

        return ResponseEntity.ok(filteredClothes);

    }

}
