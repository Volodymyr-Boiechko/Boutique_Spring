package com.boiechko.dao.implementations;

import com.boiechko.dao.interfaces.UserDao;
import com.boiechko.model.User;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class UserDaoImpl implements UserDao {

    private final SessionFactory sessionFactory;

    public UserDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    public User getUserByColumn(final String column, final String credentials) {

        Query<User> query = sessionFactory.getCurrentSession()
                .createQuery("from User WHERE " + column + "=?1")
                .setParameter(1, credentials);

        List<User> users = query.list();

        if (!users.isEmpty()) {
            return users.get(0);
        } else {
            return null;
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> getAll() {
        return sessionFactory.getCurrentSession().createQuery("from User ").list();
    }

    @Override
    public void add(final User user) {
        sessionFactory.getCurrentSession().persist(user);
    }

    @Override
    public User getById(final int id) {
        return sessionFactory.getCurrentSession().get(User.class, id);
    }

    @Override
    public void update(final User user) {
        sessionFactory.getCurrentSession().update(user);
    }

    @Override
    public void delete(final User user) {
        sessionFactory.getCurrentSession().remove(user);
    }
}
