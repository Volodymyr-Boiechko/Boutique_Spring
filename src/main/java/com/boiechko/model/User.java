package com.boiechko.model;

import com.boiechko.enums.UserType;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import java.sql.Date;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "idUser", unique = true)
    private int idUser;

    @NotNull
    @Column(name = "username", unique = true)
    private String username;

    @NotNull
    @Column(name = "password")
    private String password;

    @Column(name = "firstName")
    private String firstName;

    @Column(name = "surname")
    private String surname;

    @NotNull
    @Column(name = "birthDate")
    private Date birthDate;

    @Email
    @NotNull
    @Column(name = "email")
    private String email;

    @Column(name = "phoneNumber")
    private String phoneNumber;

    @Enumerated(value = EnumType.STRING)
    @NotNull
    @Column(name = "userType")
    private UserType userType;

    @Column(name = "activationCode")
    private String activationCode;

    @OneToMany(mappedBy = "user",
            cascade = CascadeType.ALL,
            fetch = FetchType.EAGER)
    private List<Address> addresses;

    public User() {
    }

    public User(@NotNull int idUser, @NotNull String username, @NotNull String password, String firstName,
                String surname, @NotNull Date birthDate, @Email @NotNull String email, String phoneNumber,
                @NotNull UserType userType, String activationCode, List<Address> addresses) {
        this.idUser = idUser;
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.surname = surname;
        this.birthDate = birthDate;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.userType = userType;
        this.activationCode = activationCode;
        this.addresses = addresses;
    }

    public User(@NotNull String username, @NotNull String password, @NotNull Date birthDate,
                @Email @NotNull String email, @NotNull UserType userType, String activationCode) {
        this.username = username;
        this.password = password;
        this.birthDate = birthDate;
        this.email = email;
        this.userType = userType;
        this.activationCode = activationCode;
    }

    public User(String firstName, String surname, @Email @NotNull String email, String phoneNumber) {
        this.firstName = firstName;
        this.surname = surname;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(final int idUser) {
        this.idUser = idUser;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(final String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(final String firstName) {
        this.firstName = firstName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(final String surname) {
        this.surname = surname;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(final Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(final String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(final UserType userType) {
        this.userType = userType;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(final String activationCode) {
        this.activationCode = activationCode;
    }

    public List<Address> getAddresses() {
        return addresses;
    }

    public void addAddress(final Address address) {
        address.setUser(this);
        addresses.add(address);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return idUser == user.idUser &&
                username.equals(user.username) &&
                password.equals(user.password) &&
                Objects.equals(firstName, user.firstName) &&
                Objects.equals(surname, user.surname) &&
                birthDate.equals(user.birthDate) &&
                email.equals(user.email) &&
                Objects.equals(phoneNumber, user.phoneNumber) &&
                userType == user.userType;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idUser, username, password, firstName, surname, birthDate, email, phoneNumber, userType);
    }

    @Override
    public String toString() {
        return "User{" +
                "idUser=" + idUser +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", firstName='" + firstName + '\'' +
                ", surname='" + surname + '\'' +
                ", birthDate=" + birthDate +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", userType=" + userType +
                ", activationCode='" + activationCode + '\'' +
                ", addresses=\n" + addresses +
                '}';
    }
}
