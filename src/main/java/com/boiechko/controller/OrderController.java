package com.boiechko.controller;

import com.boiechko.model.Order;
import com.boiechko.model.OrderDetails;
import com.boiechko.model.Product;
import com.boiechko.model.User;
import com.boiechko.service.implementations.JavaMailService;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.OrderDetailsService;
import com.boiechko.service.interfaces.OrderService;
import com.boiechko.utils.ConvertDateUtil;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class OrderController {

    private Logger logger = Logger.getLogger(OrderController.class);

    private final OrderService orderService;
    private final OrderDetailsService orderDetailsService;
    private final ClothesService clothesService;

    public OrderController(OrderService orderService, OrderDetailsService orderDetailsService, ClothesService clothesService) {
        this.orderService = orderService;
        this.orderDetailsService = orderDetailsService;
        this.clothesService = clothesService;
    }

    @PostMapping("/makeOrder")
    public ResponseEntity<Object> makeOrder(@RequestParam("json[]") final String[] arrayOfProductsQuantities,
                                            @RequestParam("totalPrice") final int totalPrice,
                                            @RequestParam("idAddress") final int idAddress,
                                            @RequestParam("dateOrder") final String dateOrder) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");
        final Set<Product> shoppingBag = (Set<Product>) session.getAttribute("shoppingBag");

        final Order order = new Order(user, idAddress, totalPrice, ConvertDateUtil.convertDate(dateOrder), shoppingBag);

        try {

            orderService.addOrder(order);
            user.addOrder(order);

            final List<OrderDetails> orderDetails = orderDetailsService.getOrderDetailsByOrderId(order.getIdOrder());

            orderDetailsService.updateOrderDetailQuantities(orderDetails, arrayOfProductsQuantities);
            clothesService.updateOrderDetailsInProducts(shoppingBag, orderDetails);

            session.setAttribute("shoppingBag", new HashSet<Product>());

            JavaMailService.sendOrderDetailsEmail(user.getEmail(), "orderDetail", order, shoppingBag);

            return ResponseEntity.status(HttpStatus.OK).body(null);

        } catch (IllegalArgumentException e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }


    }


}
