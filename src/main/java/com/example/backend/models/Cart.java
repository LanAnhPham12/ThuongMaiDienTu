
package com.example.backend.models;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items = new HashMap<>();
    private List<RentalItem> rentalItems = new ArrayList<>();

    public void addItem(Product product, int quantity) {
        if (items.containsKey(product.getId())) {
            CartItem existingItem = items.get(product.getId());
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            items.put(product.getId(), new CartItem(product, quantity));
        }
    }

//    public void addRental(RentalItem rental) {
//        rentalItems.add(rental);
//    }
public void addRental(RentalItem rental) {
    for (RentalItem existing : rentalItems) {
        // Kiểm tra trùng sản phẩm và ngày thuê + trả
        if (existing.getProduct().getId() == rental.getProduct().getId() &&
                existing.getRentDate().equals(rental.getRentDate()) &&
                existing.getReturnDate().equals(rental.getReturnDate())) {

            // Cộng dồn thời gian và giá thuê
            long newDays = existing.getRentalDays() + rental.getRentalDays();
            double newTotal = existing.getTotalPrice() + rental.getTotalPrice();

            existing.setRentalDays(newDays);
            existing.setTotalPrice(newTotal);
            return; // Không cần thêm mới
        }
    }

    // Nếu chưa tồn tại, thêm mới vào danh sách
    rentalItems.add(rental);
}

    public void removeItem(int productId) {
        items.remove(productId);
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public double getTotalPrice() {
        return items.values().stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
    }
    public List<CartItem> listItem (){
        return new ArrayList<>(items.values());
    }
    public void updateItemQuantity(String productId, int quantity) {
        try {
            int id = Integer.parseInt(productId);
            CartItem item = items.get(id);
            if (item != null) {
                item.setQuantity(quantity);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid productId: " + productId);
        }
    }



    public List<RentalItem> getRentalItems() {
        return rentalItems;
    }

    public void removeRental(RentalItem rental) {
        rentalItems.remove(rental);
    }

    // Tính tổng tiền thuê tất cả rentalItems
    public double getTotalRentalPrice() {
        return rentalItems.stream()
                .mapToDouble(RentalItem::getTotalPrice)
                .sum();
    }
}
