package com.boiechko.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.sql.Date;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "purchanse")
public class Order implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "idOrder", unique = true)
    private int idOrder;

    @ManyToOne()
    @NotNull
    @JoinColumn(name = "idUser")
    private User user;

    @NotNull
    @Column(name = "idAddress")
    private int idAddress;

    @NotNull
    @Column(name = "totalPrice")
    private int totalPrice;

    @NotNull
    @Column(name = "orderTime")
    private Date orderTime;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "order_details",
            joinColumns = {@JoinColumn(name = "idOrder")},
            inverseJoinColumns = {@JoinColumn(name = "idProduct")}
    )
    private Set<Product> products;

    public Order(){
    }

    public Order(@NotNull int idOrder, @NotNull User user, @NotNull int idAddress, @NotNull int totalPrice, @NotNull Date orderTime, Set<Product> products) {
        this.idOrder = idOrder;
        this.user = user;
        this.idAddress = idAddress;
        this.totalPrice = totalPrice;
        this.orderTime = orderTime;
        this.products = products;
    }

    public Order(@NotNull User user, @NotNull int idAddress, @NotNull int totalPrice, @NotNull Date orderTime, Set<Product> products) {
        this.user = user;
        this.idAddress = idAddress;
        this.totalPrice = totalPrice;
        this.orderTime = orderTime;
        this.products = products;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getIdAddress() {
        return idAddress;
    }

    public void setIdAddress(int idAddress) {
        this.idAddress = idAddress;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Set<Product> getProducts() {
        return products;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return idOrder == order.idOrder &&
                idAddress == order.idAddress &&
                totalPrice == order.totalPrice &&
                user.equals(order.user) &&
                orderTime.equals(order.orderTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idOrder, user, idAddress, totalPrice, orderTime);
    }

    @Override
    public String toString() {
        return "Order{" +
                "idOrder=" + idOrder +
                ", uidUser=" + user.getIdUser() +
                ", idAddress=" + idAddress +
                ", totalPrice=" + totalPrice +
                ", orderTime=" + orderTime +
                ", products=" + products +
                '}';
    }
}
