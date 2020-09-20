package com.boiechko.controller.Profile;

import com.boiechko.model.Order;
import com.boiechko.model.Product;
import com.boiechko.model.User;
import com.boiechko.service.interfaces.AddressService;
import com.boiechko.service.interfaces.ClothesService;
import com.boiechko.service.interfaces.OrderDetailsService;
import com.boiechko.service.interfaces.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/userProfile/userOrders")
public class UserProfileOrdersController {

    final private OrderService orderService;
    final private OrderDetailsService orderDetailsService;
    final private AddressService addressService;
    final private ClothesService clothesService;


    public UserProfileOrdersController(OrderService orderService, OrderDetailsService orderDetailsService,
                                       AddressService addressService, ClothesService clothesService) {
        this.orderService = orderService;
        this.orderDetailsService = orderDetailsService;
        this.addressService = addressService;
        this.clothesService = clothesService;
    }

    @GetMapping
    public String onUserOrders(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        model.addAttribute("allOrdersOfUser", orderService.sortUserOrders(user.getOrders()));

        return "Profile/Orders/orders";

    }

    @GetMapping("/{idOrder}")
    public String onOrderDetails(@PathVariable("idOrder") final int idOrder,
                                 final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        final Order order = user.getOrders()
                .stream()
                .filter(element -> element.getIdOrder() == idOrder)
                .findAny()
                .orElse(null);

        if (order != null) {

            final Set<Product> products = order.getProducts();
            clothesService.updateOrderDetailsInProducts(products, orderDetailsService.getOrderDetailsByOrderId(order.getIdOrder()));

            model.addAttribute("order", order);
            model.addAttribute("orderProducts", products);
            model.addAttribute("address", addressService.getAddressById(order.getIdAddress()));

            return "Profile/Orders/orderItem";

        } else {
            return "homePage";
        }
    }

}
