package com.boiechko.controller;

import com.boiechko.model.User;
import com.boiechko.service.implementations.JavaMailService;
import com.boiechko.service.interfaces.UserService;
import com.boiechko.utils.HashingPassword.HashPasswordUtil;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/forgetPassword")
public class ForgetPasswordController {

    private final Logger logger = Logger.getLogger(ForgetPasswordController.class);

    private final UserService userService;

    public ForgetPasswordController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public String onForgetPasswordPage() {
        return "ForgetPassword/forgetPassword";
    }

    @PostMapping
    public ResponseEntity<String> findUser(@RequestParam("email") final String email) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = userService.getUserByColumn("email", email);

        if (user != null) {

            final String verificationCode = JavaMailService.sendRecoveryPasswordEmail(email, "recoverPassword", user);

            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("user", user);

            logger.warn(user.getUsername() + " відправлено лист чз відновленням паролю");

            return ResponseEntity.status(HttpStatus.OK).body(verificationCode);

        } else {
            logger.warn("Someone tried to change password");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
        }
    }

    @GetMapping("/verificationCode")
    public String onVerificationCode() {
        return "ForgetPassword/verificationCode";
    }

    @GetMapping("/updatePassword")
    public String onUpdatePassword() {
        return "ForgetPassword/updatePassword";
    }

    @PostMapping("/updatePassword")
    public ResponseEntity<Object> updatePassword(@RequestParam("password") final String password) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        if (user != null) {

            final boolean isOldPasswordEqualNewPassword = HashPasswordUtil.checkPassword(password, user.getPassword());

            if (!isOldPasswordEqualNewPassword) {

                user.setPassword(HashPasswordUtil.hashPassword(password));

                try {

                    userService.updateUser(user);

                } catch (IllegalArgumentException e) {
                    logger.error(user.getUsername() + " failed to update password");
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
                }

                session.invalidate();
                logger.info(user.getUsername() + " updated password");

                return ResponseEntity.status(HttpStatus.OK).body(null);

            } else {
                logger.warn(user.getUsername() + " old and new password are the same");
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
            }

        } else {
            logger.error("Server error");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
        }

    }

}