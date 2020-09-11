package com.boiechko.dao.interfaces;

import java.util.List;

public interface Dao<T> {

    List<T> getAll();

    void add(final T t);

    T getById(final int id);

    void update(final T t);

    void delete(final T t);

}
