package com.example.backend.controller;

import com.example.backend.models.Cart;
import com.example.backend.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/remove-rental")
public class RemoveRentController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                LocalDate rentDate = LocalDate.parse(request.getParameter("rentDate"));
                LocalDate returnDate = LocalDate.parse(request.getParameter("returnDate"));

                cart.removeRentalItem(productId, rentDate, returnDate);

                session.setAttribute("cart", cart);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("cart.jsp");
    }
}
