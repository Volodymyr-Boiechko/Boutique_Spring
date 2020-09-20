package com.boiechko.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "order_details")
public class OrderDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "idOrderDetails", unique = true)
    private int idOrderDetails;

    @NotNull
    @Column(name = "idOrder")
    private int idOrder;

    @NotNull
    @Column(name = "idProduct")
    private int idProduct;

    @NotNull
    @Column(name = "quantity")
    private int quantity;

    public OrderDetails(){
    }

    public OrderDetails(@NotNull int idOrderDetails, @NotNull int idOrder, @NotNull int idProduct, @NotNull int quantity) {
        this.idOrderDetails = idOrderDetails;
        this.idOrder = idOrder;
        this.idProduct = idProduct;
        this.quantity = quantity;
    }

    public OrderDetails(@NotNull int idOrder, @NotNull int idProduct, @NotNull int quantity) {
        this.idOrder = idOrder;
        this.idProduct = idProduct;
        this.quantity = quantity;
    }

    public int getIdOrderDetails() {
        return idOrderDetails;
    }

    public void setIdOrderDetails(int idOrderDetails) {
        this.idOrderDetails = idOrderDetails;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderDetails that = (OrderDetails) o;
        return idOrderDetails == that.idOrderDetails &&
                idOrder == that.idOrder &&
                idProduct == that.idProduct &&
                quantity == that.quantity;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idOrderDetails, idOrder, idProduct, quantity);
    }

    @Override
    public String toString() {
        return "OrderDetails{" +
                "idOrderDetails=" + idOrderDetails +
                ", idOrder=" + idOrder +
                ", idProduct=" + idProduct +
                ", quantity=" + quantity +
                '}';
    }
}
