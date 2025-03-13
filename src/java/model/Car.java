/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author datvt
 */
public class Car {

    private Integer id;
    private String name;
    private String manufacturer;
    private BigDecimal price;
    private Integer releasedYear;

    public Car() {

    }

    public Car(Integer id, String name, String manufacturer, BigDecimal price, Integer releasedYear) {
        this.id = id;
        this.name = name;
        this.manufacturer = manufacturer;
        this.price = price;
        this.releasedYear = releasedYear;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getReleasedYear() {
        return releasedYear;
    }

    public void setReleasedYear(Integer releasedYear) {
        this.releasedYear = releasedYear;
    }

    @Override
    public String toString() {
        return "Car{" + "id=" + id + ", name=" + name + ", manufacturer=" + manufacturer + ", price=" + price + ", releasedYear=" + releasedYear + '}';
    }

}
