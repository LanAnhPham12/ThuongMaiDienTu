package com.example.backend.controller;

import com.example.backend.DAO.CustomOrderDAO;
import com.example.backend.models.CustomOrder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/custom-orders")
public class CustomOrderListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CustomOrderDAO dao = new CustomOrderDAO();
        List<CustomOrder> orders = dao.getAllOrders();

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/admin-custom-orders.jsp").forward(request, response);
    }
}

