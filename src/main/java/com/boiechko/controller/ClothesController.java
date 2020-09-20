package com.boiechko.controller;

import com.boiechko.model.Product;
import com.boiechko.model.User;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.ProductService;
import com.boiechko.service.interfaces.UserService;
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
import java.util.List;

@Controller
@RequestMapping(value = "/clothes")
public class ClothesController {

    private final Logger logger = Logger.getLogger(ClothesController.class);

    private final ClothesService clothesService;
    private final UserService userService;
    private final ProductService productService;

    public ClothesController(ClothesService clothesService, UserService userService, ProductService productService) {
        this.clothesService = clothesService;
        this.userService = userService;
        this.productService = productService;
    }


    @GetMapping("/{sex}")
    public String changeSex(@PathVariable("sex") final String sex) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        session.setAttribute("sex", sex);

        return "homePage";
    }

    @GetMapping("/{sex}/{typeName}")
    public String onClothes(@PathVariable("sex") final String sex,
                            @PathVariable("typeName") final String typeName,
                            @RequestParam(name = "page", defaultValue = "1") final int page,
                            final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        if (userService.isUserAdmin(user)) {
            model.addAttribute("isUserCanAddClothes", true);
        } else {
            model.addAttribute("isUserCanAddClothes", false);
        }

        if (page == 1) {
            session.setAttribute("clothes", clothesService.getListOfClothes(attributes.getRequest()));
        }

        final List<Product> clothes = (List<Product>) session.getAttribute("clothes");

        final int numberOfProductsShownOnPage = clothesService.getNumberOfProductsShownOnPage(page, clothes.size());

        model.addAttribute("numberOfProductsShownOnPage", numberOfProductsShownOnPage);
        model.addAttribute("lastIndexOfShownProduct", numberOfProductsShownOnPage - 1);
        model.addAttribute("pageNumber", page);

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
