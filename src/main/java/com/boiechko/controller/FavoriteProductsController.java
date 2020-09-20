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
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/favoriteProducts")
public class FavoriteProductsController {

    private final Logger logger = Logger.getLogger(FavoriteProductsController.class);

    private final ClothesService clothesService;
    private final ProductService productService;

    public FavoriteProductsController(ClothesService clothesService, ProductService productService) {
        this.clothesService = clothesService;
        this.productService = productService;
    }

    @GetMapping
    public String onFavoriteProducts(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final List<Integer> idsOfProductsThatAreFavorite = (List<Integer>) session.getAttribute("idsOfProductsThatAreFavorite");

        model.addAttribute("favoriteProducts", clothesService.getFavoriteProducts(idsOfProductsThatAreFavorite));

        return "favoriteProducts";

    }

    @PostMapping("/{idProduct}")
    public ResponseEntity<String> addToFavoriteProducts(@PathVariable("idProduct") final int idProduct) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        if (user != null) {

            final Product product = productService.getProductById(idProduct);

            final List<Integer> idsOfProductsThatAreFavorite = (List<Integer>) session.getAttribute("idsOfProductsThatAreFavorite");
            final Set<Product> shoppingBag = (Set<Product>) session.getAttribute("shoppingBag");

            if (!clothesService.isFavoriteProduct(idsOfProductsThatAreFavorite, product)) {

                idsOfProductsThatAreFavorite.add(product.getIdProduct());
                session.setAttribute("idsOfProductsThatAreFavorite", idsOfProductsThatAreFavorite);

                shoppingBag.remove(product);
                session.setAttribute("shoppingBag", shoppingBag);

                logger.info("product with id: " + idProduct + " saved in favorit    eProducts");

                return ResponseEntity.status(HttpStatus.OK).body("add");

            } else {

                deleteFromFavoriteProducts(idProduct);

                logger.info("product with id: " + idProduct + " deleted from favoriteProducts");
                return ResponseEntity.status(HttpStatus.OK).body("remove");
            }
        } else {
            logger.warn("user wanted to add product to the favorite products without logging in");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

    }

    @DeleteMapping("/{idProduct}")
    public ResponseEntity<Object> deleteFromFavoriteProducts(@PathVariable("idProduct") final int idProduct) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final Product product = productService.getProductById(idProduct);

        final List<Integer> idsOfProductsThatAreFavorite = (List<Integer>) session.getAttribute("idsOfProductsThatAreFavorite");

        idsOfProductsThatAreFavorite.remove(Integer.valueOf(product.getIdProduct()));
        session.setAttribute("idsOfProductsThatAreFavorite", idsOfProductsThatAreFavorite);

        logger.info("product with id: " + idProduct + " deleted from favoriteProducts");

        return ResponseEntity.status(HttpStatus.OK).body(null);

    }

}
