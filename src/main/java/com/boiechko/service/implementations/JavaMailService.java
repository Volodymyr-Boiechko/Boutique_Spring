package com.boiechko.service.implementations;

import com.boiechko.model.User;
import com.boiechko.utils.Mail.JavaMailUtil;

public class JavaMailService {

    private static JavaMailUtil javaMailUtil = null;

    public static void sendConfirmRegistrationEmail(final String recipient, final String emailSubject, final User user) {

        javaMailUtil = new JavaMailUtil(emailSubject, user);
        javaMailUtil.sendMail(recipient);

    }

    public static String sendRecoveryPasswordEmail(final String recipient, final String emailSubject, final User user) {

        javaMailUtil = new JavaMailUtil(emailSubject, user);
        javaMailUtil.sendMail(recipient);

        return javaMailUtil.getVerificationCode();

    }

    public static void sendQuestionFromUserEmail(final String recipient, final String emailSubject, final User user,
                                                 final String comment) {

        javaMailUtil = new JavaMailUtil(emailSubject, user, comment);
        javaMailUtil.sendMail(recipient);
    }

}

