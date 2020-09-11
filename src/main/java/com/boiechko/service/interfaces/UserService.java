package com.boiechko.service.interfaces;

import com.boiechko.model.User;

import java.util.List;

public interface UserService {

    User getUserByColumn(final String column, final String credentials);

    List<User> getAllUsers();

    void addUser(final User user);

    User getUserById(final int idUser);

    void updateUser(final User user);

    void deleteUser(final User user);

}
