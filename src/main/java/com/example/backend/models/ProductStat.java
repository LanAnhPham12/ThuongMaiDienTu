package com.example.backend.models;

public class ProductStat {
    private int id;
    private String name;
    private int soldQuantity;

    public ProductStat() {
    }

    public ProductStat(int id, String name, int soldQuantity) {
        this.id = id;
        this.name = name;
        this.soldQuantity = soldQuantity;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    @Override
    public String toString() {
        return "ProductStat{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", soldQuantity=" + soldQuantity +
                '}';
    }
}
