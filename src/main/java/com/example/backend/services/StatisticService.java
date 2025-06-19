package com.example.backend.services;

import com.example.backend.DB.DBConnect;
import com.example.backend.models.Product;
import com.example.backend.models.ProductStat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class StatisticService {

    // Tổng doanh thu từ đơn hàng đã giao
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) FROM orders";
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getDouble(1) : 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Tổng số đơn hàng
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    //tong san pham
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }


    // Tổng lượt thuê (nếu bạn có bảng rentals, cần tạo bảng này trong DB)
    public int getTotalRentals() {
        String sql = "SELECT COUNT(*) FROM rentals"; // Cần bảng rentals tồn tại
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Top 5 sản phẩm bán chạy nhất
    public List<ProductStat> getTopSellingProducts() {
        String sql = """
            SELECT p.id, p.name, SUM(od.quantity) AS sold_quantity
            FROM order_details od
            JOIN products p ON od.product_id = p.id
            GROUP BY p.id, p.name
            ORDER BY sold_quantity DESC
            LIMIT 5
        """;
        List<ProductStat> result = new ArrayList<>();
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                result.add(new ProductStat(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("sold_quantity")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Các sản phẩm gần hết hàng (số lượng <= 5)
    public List<Product> getLowStockProducts() {
        String sql = "SELECT * FROM products WHERE stock <= 5 ORDER BY stock ASC";
        List<Product> result = new ArrayList<>();
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock")); // dùng field stock thay vì quantity
                result.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Thống kê người dùng theo vai trò (admin/user)
    public Map<String, Integer> getUserCountByRole() {
        String sql = "SELECT role, COUNT(*) AS count FROM users GROUP BY role";
        Map<String, Integer> map = new HashMap<>();
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("role"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    // Thống kê người dùng theo trạng thái (Active / Inactive)
    public Map<String, Integer> getUserCountByStatus() {
        String sql = "SELECT status, COUNT(*) AS count FROM users GROUP BY status";
        Map<String, Integer> map = new HashMap<>();
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
}
