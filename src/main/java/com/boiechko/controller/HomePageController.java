package com.boiechko.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomePageController {

    @GetMapping("/")
    public String onHomePage() {
        return "redirect:/homePage";
    }

    @GetMapping("/homePage")
    public String homePage() {
        return "homePage";
    }

}
