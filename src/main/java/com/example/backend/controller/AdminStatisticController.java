package com.example.backend.controller;

import com.example.backend.models.Product;
import com.example.backend.models.ProductStat;
import com.example.backend.services.StatisticService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/statistics")
public class AdminStatisticController extends HttpServlet {
    private StatisticService statisticService = new StatisticService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double totalRevenue = statisticService.getTotalRevenue();
        int totalOrders = statisticService.getTotalOrders();
        int totalRentals = statisticService.getTotalRentals();
        int totalProducts = statisticService.getTotalProducts();


        List<ProductStat> topSelling = statisticService.getTopSellingProducts();
        List<Product> lowStock = statisticService.getLowStockProducts();

        Map<String, Integer> usersByRole = statisticService.getUserCountByRole();
        Map<String, Integer> usersByStatus = statisticService.getUserCountByStatus();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRentals", totalRentals);
        request.setAttribute("topSelling", topSelling);
        request.setAttribute("lowStock", lowStock);
        request.setAttribute("usersByRole", usersByRole);
        request.setAttribute("usersByStatus", usersByStatus);
        request.setAttribute("totalProducts", totalProducts);


        request.getRequestDispatcher("/admin/statistics.jsp").forward(request, response);
    }
}
