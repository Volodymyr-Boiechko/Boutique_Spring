package com.boiechko.controller;

import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Arrays;

@Controller
@RequestMapping("/clothes")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/{sex}/productItem/{idProduct}")
    public String onProductPage(@PathVariable("sex") final String sex,
                                @PathVariable("idProduct") final int idProduct,
                                final Model model) {

        final Product product = productService.getProductById(idProduct);

        model.addAttribute("product", product);
        model.addAttribute("productsThatUserMayLike", productService.getProductsThatUserMayLike(product, sex));
        model.addAttribute("pathToProduct", Arrays.asList(productService.getUkrainianSex(sex),
                productService.getEnglishTypeName(product.getTypeName())));

        return "product";

    }

}
