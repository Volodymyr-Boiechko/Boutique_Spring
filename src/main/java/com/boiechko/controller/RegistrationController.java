package com.boiechko.controller;

import com.boiechko.enums.UserType;
import com.boiechko.model.User;
import com.boiechko.service.implementations.JavaMailService;
import com.boiechko.service.interfaces.UserService;
import com.boiechko.utils.ConvertDateUtil;
import com.boiechko.utils.HashingPassword.HashPasswordUtil;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@RequestMapping("/registration")
public class RegistrationController {

    private final Logger logger = Logger.getLogger(RegistrationController.class);

    private final UserService userService;

    public RegistrationController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public String registrationPage(@RequestParam(name = "activationCode", defaultValue = "null") final String activationCode) {

        if (!activationCode.equals("null")) {

            final User user = userService.getUserByColumn("activationCode", activationCode);
            user.setActivationCode(null);

            try {

                userService.updateUser(user);

            } catch (IllegalArgumentException exception) {
                logger.error(exception.getMessage());
                logger.error(user.getUsername() + " failed to activate account");
            }

            return "login";

        } else {
            return "registration";
        }

    }

    @PostMapping
    @ResponseBody
    public ResponseEntity<Object> registration(@RequestParam("username") final String username,
                                               @RequestParam("password") final String password,
                                               @RequestParam("date") final String date,
                                               @RequestParam("email") final String email) {

        User user = userService.getUserByColumn("username", username);

        if (user == null) {

            final String hashedPassword = HashPasswordUtil.hashPassword(password);

            user = new User(username, hashedPassword, ConvertDateUtil.convertDate(date), email,
                    UserType.USER, UUID.randomUUID().toString());

            try {

                userService.addUser(user);
                JavaMailService.sendConfirmRegistrationEmail(user.getEmail(), "confirmRegistration", user);

                logger.info("Confirmation registration letter has been sent to " + username);

                return ResponseEntity.status(HttpStatus.OK).body(null);

            } catch (IllegalArgumentException e) {
                logger.error(e.getMessage());
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
            }

        } else {
            logger.warn(user.getUsername() + " , user with this username already exists");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
        }

    }

}
