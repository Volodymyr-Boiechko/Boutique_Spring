package com.boiechko.controller.Profile;

import com.boiechko.model.User;
import com.boiechko.service.interfaces.UserProfileService;
import com.boiechko.service.interfaces.UserService;
import com.boiechko.utils.ConvertDateUtil;
import com.boiechko.utils.HashingPassword.HashPasswordUtil;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/userProfile")
public class UserProfileController {

    private final Logger logger = Logger.getLogger(UserProfileController.class);

    private final UserProfileService userProfileService;
    private final UserService userService;

    public UserProfileController(UserProfileService userProfileService, UserService userService) {
        this.userProfileService = userProfileService;
        this.userService = userService;
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

    @GetMapping("/userInfo")
    public String onUserInfo() {
        return "Profile/userInfo";
    }

    @PostMapping("/userInfo")
    @ResponseBody
    public ResponseEntity<Object> updateUserInfo(@RequestParam("firstName") final String firstName,
                                                 @RequestParam("surname") final String surname,
                                                 @RequestParam("birthDate") final String birthDate,
                                                 @RequestParam("email") final String email,
                                                 @RequestParam("phoneNumber") final String phoneNumber) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        user.setFirstName(firstName);
        user.setSurname(surname);
        user.setBirthDate(ConvertDateUtil.convertDate(birthDate));
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);

        try {
            userService.updateUser(user);
            logger.info(user.getUsername() + " updated info about himself");

            return ResponseEntity.status(HttpStatus.OK).body(null);

        } catch (IllegalArgumentException e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

    }

    @GetMapping("/changePassword")
    public String onChangePassword() {
        return "Profile/changePassword";
    }

    @PostMapping("/changePassword")
    public ResponseEntity<Object> changePassword(@RequestParam("currentPassword") final String currentPassword,
                                                 @RequestParam("newPassword") final String newPassword) {


        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        boolean isEnteredPasswordEqualCurrentPassword = HashPasswordUtil.checkPassword(currentPassword, user.getPassword());

        if (isEnteredPasswordEqualCurrentPassword) {

            user.setPassword(HashPasswordUtil.hashPassword(newPassword));

            try {

                userService.updateUser(user);
                logger.info(user.getUsername() + " updated password");

                return ResponseEntity.status(HttpStatus.OK).body(null);

            } catch (IllegalArgumentException e) {
                logger.error(e.getMessage());
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
            }

        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

    }

}
