package com.example.backend.models;


import java.util.Date;

public class Rental {
    private int userId;
    private int productId;
    private Date rentDate;
    private Date returnDate;
    private String status;

    public Rental() {
    }

    public Rental(int userId, int productId, Date rentDate, Date returnDate, String status) {
        this.userId = userId;
        this.productId = productId;
        this.rentDate = rentDate;
        this.returnDate = returnDate;
        this.status = status;
    }

    // Getters
    public int getUserId() {
        return userId;
    }

    public int getProductId() {
        return productId;
    }

    public Date getRentDate() {
        return rentDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public String getStatus() {
        return status;
    }

    // Setters
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setRentDate(Date rentDate) {
        this.rentDate = rentDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}