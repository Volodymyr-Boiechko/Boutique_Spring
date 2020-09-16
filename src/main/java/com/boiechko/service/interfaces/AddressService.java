package com.boiechko.service.interfaces;

import com.boiechko.model.Address;

public interface AddressService {

    void addAddress(final Address address);

    Address getAddressById(final int idAddress);

    void updateAddress(final Address address);

    void deleteAddress(final Address address);


}
