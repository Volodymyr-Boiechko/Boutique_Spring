package com.boiechko.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "address")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "idAddress", unique = true)
    private int idAddress;

    @ManyToOne()
    @NotNull
    @JoinColumn(name = "idUser")
    private User user;

    @NotNull
    @Column(name = "country")
    private String country;

    @NotNull
    @Column(name = "city")
    private String city;

    @NotNull
    @Column(name = "street")
    private String street;

    @NotNull
    @Column(name = "postCode")
    private String postCode;

    public Address(){
    }

    public Address(@NotNull int idAddress, @NotNull User user, @NotNull String country,
                   @NotNull String city, @NotNull String street, @NotNull String postCode) {
        this.idAddress = idAddress;
        this.user = user;
        this.country = country;
        this.city = city;
        this.street = street;
        this.postCode = postCode;
    }

    public Address(@NotNull User user, @NotNull String country, @NotNull String city,
                   @NotNull String street, @NotNull String postCode) {
        this.user = user;
        this.country = country;
        this.city = city;
        this.street = street;
        this.postCode = postCode;
    }

    public int getIdAddress() { return idAddress; }

    public void setIdAddress(int idAddress) { this.idAddress = idAddress; }

    public User getUser() { return user; }

    public void setUser(User user) { this.user = user; }

    public String getCountry() { return country; }

    public void setCountry(String country) { this.country = country; }

    public String getCity() { return city; }

    public void setCity(String city) { this.city = city; }

    public String getStreet() { return street; }

    public void setStreet(String street) { this.street = street; }

    public String getPostCode() { return postCode; }

    public void setPostCode(String postCode) { this.postCode = postCode; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Address address = (Address) o;
        return idAddress == address.idAddress &&
                user.equals(address.user) &&
                country.equals(address.country) &&
                city.equals(address.city) &&
                street.equals(address.street) &&
                postCode.equals(address.postCode);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idAddress, user, country, city, street, postCode);
    }

    @Override
    public String toString() {
        return "Address{" +
                "idAddress=" + idAddress +
                ", idUser=" + user.getIdUser() +
                ", country='" + country + '\'' +
                ", city='" + city + '\'' +
                ", street='" + street + '\'' +
                ", postCode='" + postCode + '\'' +
                '}';
    }
}
