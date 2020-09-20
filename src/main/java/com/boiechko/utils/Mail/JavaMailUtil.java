package com.boiechko.utils.Mail;


import com.boiechko.model.Address;
import com.boiechko.model.Order;
import com.boiechko.model.Product;
import com.boiechko.model.User;
import org.apache.log4j.Logger;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.Set;

public class JavaMailUtil {

    private final Logger logger = Logger.getLogger(JavaMailUtil.class);

    private final static String myAccountEmail = "boiechko.work@gmail.com";
    private final static String password = "28171821";

    private final String emailSubject;
    private String verificationCode;
    private User user;
    private String comment;

    private Order order = new Order();
    private Set<Product> products;

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

    public JavaMailUtil(String emailSubject, Order order, Set<Product> products) {
        this.emailSubject = emailSubject;
        this.order = order;
        this.products = products;
    }

    private String getSubject() {

        switch (emailSubject) {
            case "confirmRegistration":
                return "Активація акаунту";
            case "recoverPassword":
                return "Відновлення паролю";
            case "questionFromUser":
                return "Запитання від користувача";
            case "orderDetail":
                return "Інформація про замовлення";
            default:
                return null;
        }
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

            if (emailSubject.contains("orderDetail")) {
                message.setContent(getHtmlCodeWithImages(htmlCode));
            } else {
                message.setContent(replaceMarkersFromHtml(htmlCode), "text/html;charset=UTF-8");
            }

            return message;

        } catch (MessagingException e) {
            logger.error(e.getMessage());
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
            logger.error(e.getMessage());
            return null;
        }

        return result;
    }

    private String addProducts(final String buf) {

        StringBuilder result = new StringBuilder();
        final String pathToFile = "C:\\Users\\volod\\IdeaProjects\\Boutique_Spring\\src\\main\\resources\\htmlFiles\\productBlock.txt";

        if (buf.contains("<div class=\"productsWrapper\">")) {

            result.append("<div class=\"productsWrapper\">\n");

            String productBlock = getHtmlCode(pathToFile);

            for (Product product : products) {

                final String[] searchList = {"${product.image}", "${product.typeName}", "${product.description}", "${product.price}", "${product.quantity}"};
                final String[] replaceList = {Integer.toString(product.getIdProduct()), product.getTypeName(), product.getDescription(),
                        Integer.toString(product.getPrice()), Integer.toString(product.getQuantity())};

                result.append("\n").append(productBlock);

                for (int i = 0; i < searchList.length; i++) {
                    result = new StringBuilder(result.toString().replace(searchList[i], replaceList[i]));
                }

            }
        }

        return buf.replace("<div class=\"productsWrapper\">", result.toString());
    }

    private Multipart getHtmlCodeWithImages(final String htmlCode) {

        Multipart multipart = new MimeMultipart();

        try {
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(replaceMarkersFromHtml(addProducts(htmlCode)), "text/html;charset=UTF-8");
            multipart.addBodyPart(messageBodyPart);

            final String path = "C:\\Users\\volod\\IdeaProjects\\Boutique_Spring\\src\\main\\webapp\\resources\\";

            for (Product product : products) {

                final String imagePath = path + product.getImage().replace("/", "\\");

                MimeBodyPart imagePart = new MimeBodyPart();
                try {
                    imagePart.setHeader("Content-ID", "<" + product.getIdProduct() + ">");
                    imagePart.setDisposition(MimeBodyPart.INLINE);
                    imagePart.attachFile(imagePath);
                } catch (MessagingException | IOException e) {
                    e.printStackTrace();
                }
                multipart.addBodyPart(imagePart);

            }
        } catch (MessagingException e) {
            logger.error(e.getMessage());
            return null;
        }

        return multipart;

    }

    private String replaceMarkersFromHtml(String htmlText) {

        switch (emailSubject) {
            case "confirmRegistration": {
                htmlText = htmlText.replace("user", user.getUsername());
                htmlText = htmlText.replace("link", "http://localhost:8080/registration?activationCode=" + user.getActivationCode());
                break;
            }
            case "recoverPassword": {
                verificationCode = VerificationCode.generateCode();
                htmlText = htmlText.replace("user", user.getUsername());
                htmlText = htmlText.replace("number", verificationCode);
                break;
            }
            case "questionFromUser": {

                final String[] searchList = {"firstName", "surname", "email", "phoneNumber", "comment"};
                final String[] replaceList = {user.getFirstName(), user.getSurname(), user.getEmail(), user.getPhoneNumber(), comment};

                for (int i = 0; i < searchList.length; i++) {
                    htmlText = htmlText.replace(searchList[i], replaceList[i]);
                }
                break;
            }
            case "orderDetail": {

                final User user = order.getUser();
                final Address address = user.getAddresses()
                        .stream()
                        .filter(address1 -> address1.getIdAddress() == order.getIdAddress())
                        .findAny()
                        .orElse(null);

                if (address == null) {
                    return null;
                }

                final String[] searchList = {"${username}", "${order.idOrder}", "${order.timeOrder}", "${products.size()} ${nameOfProduct}",
                        "${order.totalPrice}", "${person.firstName} ", "${person.surname}", "${address.street}", "${address.city}",
                        "${address.country}", "${address.postCode}", "${person.phoneNumber}", "${deliveryDate}"
                };
                final String[] replaceList = {user.getUsername(), Integer.toString(order.getIdOrder()), order.getOrderTime().toString(),
                        getTitleOfProducts(products.size()), Integer.toString(order.getTotalPrice()), user.getFirstName() + "\t",
                        user.getSurname(), address.getStreet(), address.getCity(), address.getCountry(), address.getPostCode(),
                        user.getPhoneNumber(), order.getOrderTime().toLocalDate().plusDays(21).toString()

                };

                for (int i = 0; i < searchList.length; i++) {
                    htmlText = htmlText.replace(searchList[i], replaceList[i]);
                }
                break;
            }
        }

        return htmlText;
    }

    private String getTitleOfProducts(final int size) {

        if (size == 1) {
            return size + " товар";
        } else if (size > 1 && size < 5) {
            return size + " товари";
        } else {
            return size + " товарів";
        }

    }

}