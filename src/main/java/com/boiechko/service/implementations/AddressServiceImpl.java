package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.AddressDao;
import com.boiechko.model.Address;
import com.boiechko.model.Order;
import com.boiechko.service.interfaces.AddressService;
import com.boiechko.service.interfaces.OrderService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AddressServiceImpl implements AddressService {

    private final AddressDao addressDao;
    private final OrderService orderService;

    public AddressServiceImpl(AddressDao addressDao, OrderService orderService) {
        this.addressDao = addressDao;
        this.orderService = orderService;
    }

    @Override
    public void addAddress(final Address address) { addressDao.add(address); }

    @Override
    public Address getAddressById(final int idAddress) { return addressDao.getById(idAddress); }

    @Override
    public void updateAddress(final Address address) { addressDao.update(address); }

    @Override
    public void deleteAddress(final Address address) { addressDao.delete(address); }

    @Override
    public List<Boolean> isUserCanDeleteAddress(final List<Address> addresses, final List<Order> orders) {

        return addresses.stream()
                .map(Address::getIdAddress)
                .map(idAddress -> orderService.isAddressHasOrder(idAddress, orders))
                .collect(Collectors.toList());
    }
}
