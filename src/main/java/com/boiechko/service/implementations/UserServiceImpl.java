package com.boiechko.service.implementations;

import com.boiechko.dao.interfaces.UserDao;
import com.boiechko.enums.UserType;
import com.boiechko.model.User;
import com.boiechko.service.interfaces.UserService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserDao userDao;

    public UserServiceImpl(final UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public User getUserByColumn(final String column, final String credentials) {
        return userDao.getUserByColumn(column, credentials);
    }

    @Override
    public List<User> getAllUsers() { return userDao.getAll(); }

    @Override
    public void addUser(final User user) { userDao.add(user); }

    @Override
    public User getUserById(final int idUser) { return userDao.getById(idUser); }

    @Override
    public void updateUser(final User user) { userDao.update(user); }

    @Override
    public void deleteUser(final User user) { userDao.delete(user); }

    @Override
    public boolean isUserAdmin(final User user) {
        return user != null && user.getUserType().equals(UserType.ADMIN);
    }
}
