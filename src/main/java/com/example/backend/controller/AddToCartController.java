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

@WebServlet("/add-to-cart")
public class AddToCartController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final ProductImageDAO productImageDAO = new ProductImageDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy productId từ form
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = 1; // Mặc định 1 nếu không truyền quantity

            // Nếu người dùng gửi quantity từ form
            String quantityParam = request.getParameter("quantity");
            if (quantityParam != null) {
                quantity = Integer.parseInt(quantityParam);
            }

            // Lấy sản phẩm từ DB
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại.");
                return;
            }

            // Lấy ảnh sản phẩm
            List<ProductImage> images = productImageDAO.getImagesByProductId(productId);
            product.setImages(images);

            // Lấy giỏ hàng từ session hoặc tạo mới
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            // Thêm vào giỏ
            cart.addItem(product, quantity);

            // Redirect hoặc phản hồi JSON/text
            response.sendRedirect("cart.jsp"); // hoặc response.getWriter().write("...");

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ.");
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy vấn CSDL", e);
        }
    }
}
