package com.boiechko.controller;

import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.ProductService;
import com.boiechko.utils.ConvertStringToUtf8Util;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/clothes")
public class ClothesController {

    private final Logger logger = Logger.getLogger(ClothesController.class);

    private final ClothesService clothesService;
    private final ProductService productService;

    public ClothesController(ClothesService clothesService, ProductService productService) {
        this.clothesService = clothesService;
        this.productService = productService;
    }


    @GetMapping("/{sex}")
    public String changeSex(@PathVariable("sex") final String sex) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        session.setAttribute("sex", sex);

        return "redirect:/homePage";
    }

    @GetMapping("/{sex}/{typeName}")
    public String onClothes(@PathVariable("sex") final String sex,
                            @PathVariable("typeName") final String typeName,
                            @RequestParam(name = "productName", required = false) final String productName,
                            @RequestParam(name = "newest", defaultValue = "false") final boolean newest,
                            final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final String[] brands = attributes.getRequest().getParameterValues("brands");
        if (brands != null) {
            session.setAttribute("filterName", "brands");
            session.setAttribute("filterObjects", brands);
        } else {
            session.setAttribute("filterName", null);
            session.setAttribute("filterObjects", null);
        }

        session.setAttribute("newest", newest);
        session.setAttribute("clothes", clothesService.getListOfClothes(typeName, productName, sex));
        session.setAttribute("typeName", typeName);
        session.setAttribute("productName", productName);

        model.addAttribute("sex", productService.getUkrainianSex(sex));
        model.addAttribute("productName", productService.getPathToPage(typeName, productName));

        return "clothes";
    }

    @PostMapping
    public @ResponseBody
    ResponseEntity<Object> addProductToDataBase(@RequestParam("typeName") final String typeName,
                                                @RequestParam("productName") final String productName,
                                                @RequestParam("sex") final String sex,
                                                @RequestParam("brand") final String brand,
                                                @RequestParam("model") final String model,
                                                @RequestParam("size") final String size,
                                                @RequestParam("color") final String color,
                                                @RequestParam("image") final MultipartFile image,
                                                @RequestParam("destination") final String destination,
                                                @RequestParam("price") final int price,
                                                @RequestParam("description") final String description) {

        final Product product = new Product
                (ConvertStringToUtf8Util.convert(typeName), ConvertStringToUtf8Util.convert(productName),
                        ConvertStringToUtf8Util.convert(sex), brand, model, size, ConvertStringToUtf8Util.convert(color),
                        productService.getDestinationOfImage(image, destination), price, ConvertStringToUtf8Util.convert(description)
                );

        if (productService.saveImageOfProduct(image, destination)) {

            try {

                productService.addProduct(product);
                logger.info("product: " + product.getIdProduct() + " saved to data base");

                return ResponseEntity.status(HttpStatus.OK).body(null);

            } catch (IllegalArgumentException e) {
                logger.error(e.getMessage());
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
            }

        } else {
            logger.error("Failed to save image");
            return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(null);
        }

    }

}
