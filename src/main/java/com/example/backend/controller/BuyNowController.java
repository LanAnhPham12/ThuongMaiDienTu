package com.example.backend.controller;

import com.example.backend.DAO.ProductDAO;
import com.example.backend.DAO.ProductImageDAO;
import com.example.backend.models.Cart;
import com.example.backend.models.Product;
import com.example.backend.models.ProductImage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/buy-now")
public class BuyNowController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final ProductImageDAO productImageDAO = new ProductImageDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = 1;

            String quantityParam = request.getParameter("quantity");
            if (quantityParam != null) {
                quantity = Integer.parseInt(quantityParam);
            }

            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại.");
                return;
            }

            List<ProductImage> images = productImageDAO.getImagesByProductId(productId);
            product.setImages(images);

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            cart.addItem(product, quantity);

            // Mua ngay: chuyển sang trang thanh toán thay vì giỏ hàng
            response.sendRedirect("checkout.jsp");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ.");
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy vấn CSDL", e);
        }
    }
}
