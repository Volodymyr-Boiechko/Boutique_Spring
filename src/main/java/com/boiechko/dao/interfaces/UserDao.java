package com.boiechko.dao.interfaces;

import com.boiechko.model.User;

public interface UserDao extends Dao<User> {

    User getUserByColumn(final String column, final String credentials);

}
