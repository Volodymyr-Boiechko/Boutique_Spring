package com.boiechko.controller;

import com.boiechko.model.User;
import com.boiechko.service.interfaces.UserProfileService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/userProfile")
public class UserProfileController {

    private final UserProfileService userProfileService;

    public UserProfileController(UserProfileService userProfileService) {
        this.userProfileService = userProfileService;
    }

    @GetMapping
    public String onUserProfile() {
        return "Profile/profile";
    }

    @GetMapping("/navProfile")
    public String onNavigationBar(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        model.addAttribute("numberOfSectionInNavigationBar",
                userProfileService.getNumberOfSectionInNavigationBar(attributes.getRequest()));

        model.addAttribute("firstLetterOfUsername", user.getUsername().charAt(0));

        return "components/navProfile";
    }




}
