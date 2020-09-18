package com.boiechko.controller;

import com.boiechko.model.Product;
import com.boiechko.model.User;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.ProductService;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/shoppingBag")
public class ShoppingBagController {

    private final Logger logger = Logger.getLogger(ShoppingBagController.class);

    private final ClothesService clothesService;
    private final ProductService productService;

    public ShoppingBagController(ClothesService clothesService, ProductService productService) {
        this.clothesService = clothesService;
        this.productService = productService;
    }

    @GetMapping
    public String onShoppingBag(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final List<Product> productsOfShoppingBag = (List<Product>) session.getAttribute("shoppingBag");

        if (productsOfShoppingBag != null && productsOfShoppingBag.size() != 0) {

            final User user = (User) session.getAttribute("user");

            model.addAttribute("pricesOfProducts",
                    productsOfShoppingBag.stream()
                            .map(Product::getPrice)
                            .sequential().collect(Collectors.toList()));

            model.addAttribute("addressesOfUser", user.getAddresses());
            model.addAttribute("maxQuantity", Arrays.asList(1, 2, 3, 4, 5));

        }

        return "shoppingBag";

    }

    @PostMapping("/{idProduct}")
    public ResponseEntity<Object> addToShoppingBag(@PathVariable("idProduct") final int idProduct) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        if (user != null) {

            final Product product = productService.getProductById(idProduct);
            final List<Product> shoppingBag = (List<Product>) session.getAttribute("shoppingBag");
            final List<Integer> idsOfProductsWhichAreFavorite = (List<Integer>) session.getAttribute("idsOfProductsThatAreFavorite");

            if (!clothesService.isProductInShoppingBag(shoppingBag, product)) {

                shoppingBag.add(product);
                session.setAttribute("shoppingBag", shoppingBag);

                idsOfProductsWhichAreFavorite.remove(Integer.valueOf(product.getIdProduct()));
                session.setAttribute("idsOfProductsThatAreFavorite", idsOfProductsWhichAreFavorite);

                logger.info("user: " + user.getUsername() + " added product: " + idProduct + " to shopping bag");

                return ResponseEntity.status(HttpStatus.OK).body(null);

            } else {
                logger.warn("user: " + user.getUsername() + " tried to add product in shopping bag, which is already in");
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
            }

        } else {
            logger.warn("someone tried to enter shopping bag");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

    }

    @DeleteMapping("/{idProduct}")
    public ResponseEntity<Object> deleteProductFromShoppingBag(@PathVariable("idProduct") final int idProduct) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        Product product = productService.getProductById(idProduct);

        final List<Product> shoppingBag = (List<Product>) session.getAttribute("shoppingBag");
        shoppingBag.remove(product);
        session.setAttribute("shoppingBag", shoppingBag);

        logger.info("product: " + idProduct + " deleted from shopping bag");

        return ResponseEntity.status(HttpStatus.OK).body(null);

    }

}
