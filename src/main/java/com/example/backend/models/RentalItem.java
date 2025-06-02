package com.example.backend.models;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class RentalItem {
    private Product product;       // Sản phẩm thuê
    private LocalDate rentDate;    // Ngày bắt đầu thuê
    private LocalDate returnDate;  // Ngày kết thúc thuê
    private long rentalDays;       // Số ngày thuê
    private double totalPrice;     // Tổng tiền thuê

    public RentalItem(Product product, LocalDate rentDate, LocalDate returnDate, long rentalDays, double totalPrice) {
        this.product = product;
        this.rentDate = rentDate;
        this.returnDate = returnDate;
        this.rentalDays = rentalDays;
        this.totalPrice = totalPrice;
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

    public void setRentalDays(long rentalDays) {
        this.rentalDays = rentalDays;
        recalculateTotalPrice();
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    /**
     * Tính lại số ngày thuê dựa trên rentDate và returnDate.
     */
    public void recalculateRentalDays() {
        if (rentDate != null && returnDate != null && !returnDate.isBefore(rentDate)) {
            this.rentalDays = ChronoUnit.DAYS.between(rentDate, returnDate) + 1;
        } else {
            this.rentalDays = 0;
        }
    }

    /**
     * Tính lại tổng tiền thuê dựa trên giá thuê của sản phẩm và số ngày thuê.
     */
    public void recalculateTotalPrice() {
        if (product != null) {
            double pricePerDay = product.getRentalPrice();
            this.totalPrice = pricePerDay * rentalDays;
        } else {
            this.totalPrice = 0;
        }
    }
}
