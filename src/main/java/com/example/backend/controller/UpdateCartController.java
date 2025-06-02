package com.example.backend.controller;

import com.example.backend.models.Cart;
import com.example.backend.models.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

@WebServlet("/update-cart")
public class UpdateCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                int productId = entry.getKey();
                CartItem item = entry.getValue();

                String quantityParam = request.getParameter("quantity_" + productId);

                if (quantityParam != null) {
                    try {
                        int quantity = Integer.parseInt(quantityParam);
                        if (quantity > 0) {
                            item.setQuantity(quantity);
                        }
                    } catch (NumberFormatException e) {
                        // Bỏ qua nếu dữ liệu không hợp lệ
                    }
                }
            }

            session.setAttribute("cart", cart);
        }

        response.sendRedirect("cart.jsp");
    }
}
