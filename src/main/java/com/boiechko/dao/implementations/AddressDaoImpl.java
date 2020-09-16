package com.boiechko.dao.implementations;

import com.boiechko.dao.interfaces.AddressDao;
import com.boiechko.model.Address;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class AddressDaoImpl implements AddressDao {

    private final SessionFactory sessionFactory;

    public AddressDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Address> getAll() {
        return sessionFactory.getCurrentSession().createQuery("FROM Address").list();
    }

    @Override
    public void add(final Address address) {
        sessionFactory.getCurrentSession().persist(address);
    }

    @Override
    public Address getById(final int id) {
        return sessionFactory.getCurrentSession().get(Address.class, id);
    }

    @Override
    public void update(final Address address) {
        sessionFactory.getCurrentSession().update(address);
    }

    @Override
    public void delete(final Address address) {
        sessionFactory.getCurrentSession().delete(address);
    }
}
