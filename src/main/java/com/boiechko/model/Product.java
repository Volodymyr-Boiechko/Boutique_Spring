package com.boiechko.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Objects;

@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Column(name = "idProduct", unique = true)
    private int idProduct;

    @NotNull
    @Column(name = "typeName")
    private String typeName;

    @NotNull
    @Column(name = "productName")
    private String productName;

    @NotNull
    @Column(name = "sex")
    private String sex;

    @NotNull
    @Column(name = "brand")
    private String brand;

    @Column(name = "model")
    private String model;

    @Column(name = "size")
    private String size;

    @Column(name = "color")
    private String color;

    @Column(name = "image")
    private String image;

    @Column(name = "price")
    private int price;

    @Column(name = "description")
    private String description;

    public Product(){
    }

    public Product(@NotNull int idProduct, @NotNull String typeName, @NotNull String productName,
                   @NotNull String sex, @NotNull String brand, String model, String size, String color,
                   String image, int price, String description) {
        this.idProduct = idProduct;
        this.typeName = typeName;
        this.productName = productName;
        this.sex = sex;
        this.brand = brand;
        this.model = model;
        this.size = size;
        this.color = color;
        this.image = image;
        this.price = price;
        this.description = description;
    }

    public Product(@NotNull String typeName, @NotNull String productName, @NotNull String sex, @NotNull
            String brand, String model, String size, String color, String image, int price, String description) {
        this.typeName = typeName;
        this.productName = productName;
        this.sex = sex;
        this.brand = brand;
        this.model = model;
        this.size = size;
        this.color = color;
        this.image = image;
        this.price = price;
        this.description = description;
    }

    public int getIdProduct() { return idProduct; }

    public void setIdProduct(int idProduct) { this.idProduct = idProduct; }

    public String getTypeName() { return typeName; }

    public void setTypeName(String typeName) { this.typeName = typeName; }

    public String getProductName() { return productName; }

    public void setProductName(String productName) { this.productName = productName; }

    public String getSex() { return sex; }

    public void setSex(String sex) { this.sex = sex; }

    public String getBrand() { return brand; }

    public void setBrand(String brand) { this.brand = brand; }

    public String getModel() { return model; }

    public void setModel(String model) { this.model = model; }

    public String getSize() { return size; }

    public void setSize(String size) { this.size = size; }

    public String getColor() { return color; }

    public void setColor(String color) { this.color = color; }

    public String getImage() { return image; }

    public void setImage(String image) { this.image = image; }

    public int getPrice() { return price; }

    public void setPrice(int price) { this.price = price; }

    public String getDescription() { return description; }

    public void setDescription(String description) { this.description = description; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return idProduct == product.idProduct &&
                price == product.price &&
                typeName.equals(product.typeName) &&
                productName.equals(product.productName) &&
                sex.equals(product.sex) &&
                brand.equals(product.brand) &&
                Objects.equals(model, product.model) &&
                Objects.equals(size, product.size) &&
                Objects.equals(color, product.color) &&
                image.equals(product.image) &&
                description.equals(product.description);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idProduct, typeName, productName, sex, brand, model, size, color, image, price, description);
    }

    @Override
    public String toString() {
        return "Product{" +
                "idProduct=" + idProduct +
                ", typeName='" + typeName + '\'' +
                ", productName='" + productName + '\'' +
                ", sex='" + sex + '\'' +
                ", brand='" + brand + '\'' +
                ", model='" + model + '\'' +
                ", size='" + size + '\'' +
                ", color='" + color + '\'' +
                ", image='" + image + '\'' +
                ", price=" + price +
                ", description='" + description + '\'' +
                '}';
    }
}
