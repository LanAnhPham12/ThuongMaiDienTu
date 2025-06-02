
package com.example.backend.controller;

import com.example.backend.models.Category;
import com.example.backend.models.Product;
import com.example.backend.services.CategoryService;
import com.example.backend.services.ProductService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/shop")
public class ShopController extends HttpServlet {
    ProductService productService = new ProductService();
    CategoryService categoryService = CategoryService.getInstance();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
//        List<Product> products = productService.getProductsByCategoryId(categoryId);
//        System.out.println(products);
        String categoryIdParam = request.getParameter("categoryId");
        int categoryId = 0; // hoặc -1 hoặc giá trị mặc định bạn muốn

        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException e) {
                // Nếu parse lỗi, bạn có thể log hoặc để mặc định categoryId = 0
                categoryId = 0;
            }
        }

        List<Product> products;
        if (categoryId > 0) {
            products = productService.getProductsByCategoryId(categoryId);
        } else {
            // Nếu không có categoryId hoặc categoryId không hợp lệ thì lấy tất cả sản phẩm
            products = productService.getAllProducts();
        }


        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("shop.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}
