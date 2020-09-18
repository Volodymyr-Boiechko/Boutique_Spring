package com.boiechko.controller;

import com.boiechko.model.Product;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.UserService;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/clothes")
public class ClothesController {

    private final Logger logger = Logger.getLogger(ClothesController.class);

    private final ClothesService clothesService;
    private final UserService userService;

    public ClothesController(ClothesService clothesService, UserService userService) {
        this.clothesService = clothesService;
        this.userService = userService;
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

}
