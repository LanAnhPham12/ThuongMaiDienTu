package com.example.backend.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.http.Part;

import com.example.backend.DAO.CustomOrderDAO;
import com.example.backend.models.CustomOrder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/custom-order")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class CustomOrderServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String height = request.getParameter("height");
        String weight = request.getParameter("weight");
        String designType = request.getParameter("designType");
        String fabricColor = request.getParameter("fabricColor");
        String[] materials = request.getParameterValues("material");
        String material = (materials != null) ? String.join(", ", materials) : "";
        String size = request.getParameter("size");

        float bust = parseFloat(request.getParameter("bust"));
        float waist = parseFloat(request.getParameter("waist"));
        float hip = parseFloat(request.getParameter("hip"));
        float sleeveLength = parseFloat(request.getParameter("sleeveLength"));
        float length = parseFloat(request.getParameter("length"));
        String message = request.getParameter("message");

        // Xử lý file upload
        Part filePart = request.getPart("designFile");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            filePart.write(uploadPath + File.separator + fileName);
        }

        // Tạo đối tượng order
        CustomOrder order = new CustomOrder(fullName, phone, height, weight,
                designType, fabricColor, material, size,
                bust, waist, hip, sleeveLength, length,
                message, fileName);

        // Lưu vào DB
        CustomOrderDAO dao = new CustomOrderDAO();
        dao.saveOrder(order);

        response.sendRedirect("thankyou.jsp");
    }

    private float parseFloat(String val) {
        try {
            return Float.parseFloat(val);
        } catch (Exception e) {
            return 0f;
        }
    }
}
