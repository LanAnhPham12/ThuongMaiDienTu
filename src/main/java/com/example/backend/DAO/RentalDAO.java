package com.example.backend.DAO;
import com.example.backend.DB.DBConnect;
import com.example.backend.models.Rental;

import java.sql.*;

public class RentalDAO {
    public void rentProduct(int userId, int productId) {
        String sql = "INSERT INTO rental (user_id, product_id, rent_date, return_date, status) " +
                "VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 'RENTED')";
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void cancelRent(int userId, int productId) {
        String sql = "UPDATE rental SET status='CANCELLED' WHERE user_id=? AND product_id=? AND status='RENTED'";
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Rental getRentalInfo(int userId, int productId) {
        String sql = "SELECT * FROM rental WHERE user_id=? AND product_id=? AND status='RENTED'";
        try (Connection conn = DBConnect.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Rental rental = new Rental();
                    rental.setUserId(rs.getInt("user_id"));
                    rental.setProductId(rs.getInt("product_id"));
                    rental.setRentDate(rs.getTimestamp("rent_date"));
                    rental.setReturnDate(rs.getTimestamp("return_date"));
                    rental.setStatus(rs.getString("status"));
                    return rental;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
