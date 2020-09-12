package com.boiechko.utils.Mail;


import com.boiechko.model.User;
import org.apache.log4j.Logger;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

public class JavaMailUtil {

    private final Logger logger = Logger.getLogger(JavaMailUtil.class);

    private final static String myAccountEmail = "boiechko.work@gmail.com";
    private final static String password = "28171821";

    private final String emailSubject;
    private String verificationCode;
    private User user;
    private String comment;

    public String getVerificationCode() {
        return verificationCode;
    }

    public JavaMailUtil(String emailSubject, User user) {
        this.emailSubject = emailSubject;
        this.user = user;
    }

    public JavaMailUtil(String emailSubject, User user, String comment) {
        this.emailSubject = emailSubject;
        this.user = user;
        this.comment = comment;
    }

    private String getSubject() {

        if ("confirmRegistration".equals(emailSubject)) {
            return "Активація акаунту";
        }
        return null;
    }

    public void sendMail(final String recipient) {

        try {

            final Properties properties = new Properties();
            properties.load(JavaMailUtil.class.getClassLoader().getResourceAsStream("mail.properties"));

            final Session session = Session.getInstance(properties, new Authenticator() {

                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(myAccountEmail, password);
                }
            });

            final Message message = prepareMessage(session, recipient);

            if (message != null) {
                Transport.send(message);
            }

        } catch (IOException | MessagingException e) {
            logger.error(e.getMessage());
        }

    }

    private Message prepareMessage(final Session session, final String recipient) {

        try {

            final Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject(getSubject());

            final String pathToFile = "C:\\Users\\volod\\IdeaProjects\\Boutique_Spring\\src\\main\\resources\\htmlFiles\\" +
                    emailSubject + ".txt";

            final String htmlCode = getHtmlCode(pathToFile);

            message.setContent(replaceMarkersFromHtml(htmlCode), "text/html;charset=UTF-8");

            return message;

        } catch (MessagingException e) {
            e.printStackTrace();
            return null;
        }

    }

    public String getHtmlCode(final String pathToFile) {

        String result = "";

        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(
                        new FileInputStream(pathToFile), StandardCharsets.UTF_8))) {

            String buf;
            while ((buf = br.readLine()) != null) {
                result = String.format("%s%s\n", result, buf);
            }

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        return result;
    }

    private String replaceMarkersFromHtml(String htmlText) {

        if ("confirmRegistration".equals(emailSubject)) {
            htmlText = htmlText.replace("user", user.getUsername());
            htmlText = htmlText.replace("link", "http://localhost:8080/registration?activationCode=" + user.getActivationCode());
        }

        return htmlText;
    }

}