package com.boiechko.controller;

import com.boiechko.model.User;
import com.boiechko.service.implementations.JavaMailService;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/footer")
public class FooterController {

    private final Logger logger = Logger.getLogger(FooterController.class);

    @GetMapping
    public String onFooter() {
        return "components/footer";
    }


    @PostMapping
    @ResponseBody
    public ResponseEntity<Object> sendQuestion(@RequestParam("firstName") final String firstName,
                                               @RequestParam("surname") final String surname,
                                               @RequestParam("email") final String email,
                                               @RequestParam("phoneNumber") final String phoneNumber,
                                               @RequestParam("comment") final String comment) {

        final User user = new User(firstName, surname, email, phoneNumber);

        JavaMailService.sendQuestionFromUserEmail("boiechko.work@gmail.com",
                "questionFromUser", user, comment);

        logger.info("Question letter has been sent");

        return ResponseEntity.status(HttpStatus.OK).body(null);

    }

}
