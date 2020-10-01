package com.boiechko.controller;

import com.boiechko.model.User;
import com.boiechko.service.interfaces.UserService;
import com.boiechko.utils.HashingPassword.HashPasswordUtil;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.Enumeration;

@Controller
public class LoginController {

    private final Logger logger = Logger.getLogger(LoginController.class);

    private final UserService userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<Object> login(@RequestParam("username") final String username,
                                        @RequestParam("password") final String enteredPassword,
                                        @RequestParam("saveUserInBrowser") final String saveUserInBrowser) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        try {

            final User user = userService.getUserByColumn("username", username);

            if (user != null) {

                if (user.getActivationCode() == null) {

                    boolean isEnteredPasswordEqualUserPassword = HashPasswordUtil.checkPassword(enteredPassword, user.getPassword());

                    if (isEnteredPasswordEqualUserPassword) {

                        session.setAttribute("user", userService.getUserByColumn("username", username));
                        session.setAttribute("admin", userService.isUserAdmin(user));

                        logger.info(username + " logged in");

                        return ResponseEntity.status(HttpStatus.OK).body(null);

                    } else {
                        logger.warn(username + " entered different passwords");
                        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
                    }
                } else {
                    logger.warn(username + " didn't activate the account");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
                }
            } else {
                logger.warn("Account not found");
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
            }

        } catch (IllegalArgumentException exception) {
            logger.error(exception.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

    }

    @GetMapping("/logout")
    public String logout() {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final Enumeration<String> sessionAttributeNames = session.getAttributeNames();

        if (sessionAttributeNames.hasMoreElements()) {
            session.invalidate();
            return "logout";
        } else {
            return "redirect:/";
        }

    }

}
