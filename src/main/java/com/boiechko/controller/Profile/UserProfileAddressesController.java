package com.boiechko.controller.Profile;

import com.boiechko.model.Address;
import com.boiechko.model.User;
import com.boiechko.service.interfaces.AddressService;
import com.boiechko.service.interfaces.OrderService;
import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/userProfile/userAddresses")
public class UserProfileAddressesController {

    private final Logger logger = Logger.getLogger(UserProfileAddressesController.class);

    private final AddressService addressService;
    private final OrderService orderService;

    public UserProfileAddressesController(AddressService addressService, OrderService orderService) {
        this.addressService = addressService;
        this.orderService = orderService;
    }

    @GetMapping
    public String onUserAddresses(final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        final List<Address> addressesOfUser = user.getAddresses()
                .stream()
                .sorted(Comparator.comparingInt(Address::getIdAddress))
                .collect(Collectors.toList());

        model.addAttribute("addressesOfUser", addressesOfUser);

        model.addAttribute("canUserDeleteAddress",
                addressService.isUserCanDeleteAddress(addressesOfUser, user.getOrders()));

        return "Profile/Address/addresses";

    }

    @GetMapping("/addAddress")
    public String onAddAddress() {

        return "Profile/Address/addAddress";
    }

    @PostMapping("addAddress")
    public ResponseEntity<Object> addAddress(@RequestParam("country") final String country,
                                             @RequestParam("city") final String city,
                                             @RequestParam("street") final String street,
                                             @RequestParam("postCode") final String postCode) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        final Address address = new Address(user, country, city, street, postCode);

        try {

            addressService.addAddress(address);
            user.addAddress(address);
            logger.info(user.getUsername() + " added new address");

            return ResponseEntity.status(HttpStatus.OK).body(null);

        } catch (IllegalArgumentException e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

    }

    @GetMapping("/editAddress/{idAddress}")
    public String onEditAddress(@PathVariable("idAddress") final int idAddress, final Model model) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");

        final Address address = addressService.getAddressById(idAddress);
        model.addAttribute("address", address);
        model.addAttribute("canUserDeleteAddress", orderService.isAddressHasOrder(idAddress, user.getOrders()));

        return "Profile/Address/editAddress";
    }

    @PostMapping("/editAddress/{idAddress}")
    public ResponseEntity<Object> updateUserAddress(@PathVariable("idAddress") final int idAddress,
                                                    @RequestParam("country") final String country,
                                                    @RequestParam("city") final String city,
                                                    @RequestParam("street") final String street,
                                                    @RequestParam("postCode") final String postCode) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final Address address = addressService.getAddressById(idAddress);
        final User user = (User) session.getAttribute("user");
        user.getAddresses().remove(address);

        address.setCountry(country);
        address.setCity(city);
        address.setStreet(street);
        address.setPostCode(postCode);

        try {

            addressService.updateAddress(address);
            user.addAddress(address);
            session.setAttribute("user", user);
            logger.info(user.getUsername() + " updated address: " + address.getIdAddress());

            return ResponseEntity.status(HttpStatus.OK).body(null);

        } catch (IllegalArgumentException e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

    }

    @DeleteMapping("/{idAddress}")
    public ResponseEntity<Object> deleteAddress(@PathVariable("idAddress") final int idAddress) {

        final ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        final HttpSession session = attributes.getRequest().getSession();

        final User user = (User) session.getAttribute("user");
        final Address address = addressService.getAddressById(idAddress);

        try {

            user.getAddresses().remove(address);
            addressService.deleteAddress(address);
            session.setAttribute("user", user);
            logger.info(user.getUsername() + " deleted address: " + address.getIdAddress());

            return ResponseEntity.status(HttpStatus.OK).body(null);

        } catch (IllegalArgumentException e) {
            logger.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }

    }

}
