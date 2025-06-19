package com.example.backend.models;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class RentalItem {
    private Product product;
    private LocalDate rentDate;
    private LocalDate returnDate;
    private long rentalDays;
    private double totalPrice;

    public RentalItem(Product product, LocalDate rentDate, LocalDate returnDate) {
        this.product = product;
        this.rentDate = rentDate;
        this.returnDate = returnDate;
        recalculateRentalDays();
        recalculateTotalPrice();
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
        recalculateTotalPrice();
    }

    public LocalDate getRentDate() {
        return rentDate;
    }

    public void setRentDate(LocalDate rentDate) {
        this.rentDate = rentDate;
        recalculateRentalDays();
        recalculateTotalPrice();
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
        recalculateRentalDays();
        recalculateTotalPrice();
    }

    public long getRentalDays() {
        return rentalDays;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public double getRentalPricePerDay() {
        return product != null ? product.getPrice() * 0.1 : 0;
    }

    private void recalculateRentalDays() {
        if (rentDate != null && returnDate != null && !returnDate.isBefore(rentDate)) {
            this.rentalDays = ChronoUnit.DAYS.between(rentDate, returnDate) + 1;
        } else {
            this.rentalDays = 0;
        }
    }

    private void recalculateTotalPrice() {
        this.totalPrice = getRentalPricePerDay() * rentalDays;
    }
}
