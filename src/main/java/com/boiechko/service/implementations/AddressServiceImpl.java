package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.AddressDao;
import com.boiechko.model.Address;
import com.boiechko.service.interfaces.AddressService;
import org.springframework.stereotype.Service;

@Service
public class AddressServiceImpl implements AddressService {

    private final AddressDao addressDao;

    public AddressServiceImpl(AddressDao addressDao) {
        this.addressDao = addressDao;
    }

    @Override
    public void addAddress(final Address address) { addressDao.add(address); }

    @Override
    public Address getAddressById(final int idAddress) { return addressDao.getById(idAddress); }

    @Override
    public void updateAddress(final Address address) { addressDao.update(address); }

    @Override
    public void deleteAddress(final Address address) { addressDao.delete(address); }
}
