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
import java.time.temporal.ChronoUnit;

@WebServlet("/addRentToCart")
public class AddRentToCart extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String rentDateStr = request.getParameter("rentDate");
        String returnDateStr = request.getParameter("returnDate");

        // parse ngày
        LocalDate rentDate = LocalDate.parse(rentDateStr);
        LocalDate returnDate = LocalDate.parse(returnDateStr);

        // tính số ngày thuê (returnDate - rentDate + 1)
        long days = ChronoUnit.DAYS.between(rentDate, returnDate) + 1;

        // lấy sản phẩm từ DB
        Product product = ProductDAO.getProductById(Integer.parseInt(productId));

        // giả sử sản phẩm có giá thuê theo ngày, tính tổng tiền thuê
        double pricePerDay = product.getRentalPrice(); // bạn cần bổ sung trường này nếu chưa có
        double totalRentPrice = pricePerDay * days;

        // tạo đối tượng CartItem hoặc RentalItem (tùy thiết kế)
        RentalItem rental = new RentalItem(product, rentDate, returnDate, days, totalRentPrice);

        // thêm vào giỏ hàng session (tùy bạn lưu giỏ hàng ở đâu)
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if(cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        cart.addRental(rental);

        // chuyển đến trang giỏ hàng hoặc thanh toán
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }

}
