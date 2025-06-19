package com.example.backend.controller;

import com.example.backend.DAO.ProductDAO;
import com.example.backend.models.Cart;
import com.example.backend.models.Product;
import com.example.backend.models.RentalItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/addRentToCart")
public class AddRentToCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        String rentDateStr = request.getParameter("rentDate");
        String returnDateStr = request.getParameter("returnDate");

        try {
            // Parse input
            int productId = Integer.parseInt(productIdStr);
            LocalDate rentDate = LocalDate.parse(rentDateStr);
            LocalDate returnDate = LocalDate.parse(returnDateStr);

            // Lấy sản phẩm từ DB
            Product product = ProductDAO.getProductById(productId);
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại.");
                return;
            }

            // Tạo RentalItem (tự tính ngày và tiền)
            RentalItem rental = new RentalItem(product, rentDate, returnDate);

            // Lấy hoặc tạo giỏ hàng
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            // Thêm vào giỏ
            cart.addRental(rental);

            // Chuyển hướng đến giỏ hàng
            response.sendRedirect(request.getContextPath() + "/cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi dữ liệu nhập vào.");
        }
    }
}
