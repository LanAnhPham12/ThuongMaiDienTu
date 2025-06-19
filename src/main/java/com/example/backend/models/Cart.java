
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

    // sp thuê

    public void addRental(RentalItem rental) {
        for (RentalItem existing : rentalItems) {
            // Nếu đã có sản phẩm thuê cùng ngày thuê và trả thì không cộng dồn thủ công nữa
            if (existing.getProduct().getId() == rental.getProduct().getId()
                    && existing.getRentDate().equals(rental.getRentDate())
                    && existing.getReturnDate().equals(rental.getReturnDate())) {
                return; // Đã tồn tại => bỏ qua để tránh trùng
            }
        }
        // Nếu chưa tồn tại thì thêm mới
        rentalItems.add(rental);
    }

    public void removeRental(RentalItem rental) {
        rentalItems.remove(rental);
    }

    public List<RentalItem> getRentalItems() {
        return rentalItems;
    }

    public double getTotalRentalPrice() {
        return rentalItems.stream()
                .mapToDouble(RentalItem::getTotalPrice)
                .sum();
    }
}
