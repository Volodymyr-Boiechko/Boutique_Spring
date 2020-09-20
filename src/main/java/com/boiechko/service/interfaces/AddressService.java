package com.boiechko.service.interfaces;

import com.boiechko.model.Address;
import com.boiechko.model.Order;

import java.util.List;

public interface AddressService {

    void addAddress(final Address address);

    Address getAddressById(final int idAddress);

    void updateAddress(final Address address);

    void deleteAddress(final Address address);

    List<Boolean> isUserCanDeleteAddress(final List<Address> addresses, final List<Order> orders);

}
