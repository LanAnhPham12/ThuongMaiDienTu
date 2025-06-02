
package com.example.backend.controller;

import com.example.backend.DAO.CommentDAO;
import com.example.backend.models.Category;
import com.example.backend.models.Comment;
import com.example.backend.models.Product;
import com.example.backend.services.CategoryService;
import com.example.backend.services.CommentService;
import com.example.backend.services.ProductService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/detail")
public class DetailProductController extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final CommentDAO commentDAO = new CommentDAO();
    private final CommentService commentService = new CommentService(commentDAO);
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("id");

        if (productIdStr == null) {
            // Nếu thiếu tham số id, có thể redirect về trang shop hoặc trang lỗi
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            // Nếu id không phải số, cũng redirect hoặc trả lỗi
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        Product product = productService.getProductById(productId);
        if (product == null) {
            // Nếu sản phẩm không tồn tại, cũng xử lý hợp lý
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        List<Product> relatedProducts = productService.get5ProductsByCategoryId(product.getCategoryId());
        List<Comment> comments = commentService.getCommentsByProductId(productId);

        request.setAttribute("comments", comments);
        request.setAttribute("product", product);
        request.setAttribute("relatedProducts", relatedProducts);

        request.getRequestDispatcher("/detail.jsp").forward(request, response);
    }


}
