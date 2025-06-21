package com.example.backend.DAO;

import com.example.backend.DB.DBConnect;
import com.example.backend.models.CustomOrder;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class CustomOrderDAO {
	private static final String INSERT_ORDER_SQL = "INSERT INTO custom_orders" +
		    " (full_name, phone, height, weight, design_type, fabric_color, material, size, bust, waist, hip, sleeve_length, length, message, design_file)" +
		    " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	public void saveOrder(CustomOrder order) {
	    try (Connection connection = DBConnect.getInstance().getConnection();
	         PreparedStatement ps = connection.prepareStatement(INSERT_ORDER_SQL)) {

	        ps.setString(1, order.getFullName());
	        ps.setString(2, order.getPhone());
	        ps.setString(3, order.getHeight());
	        ps.setString(4, order.getWeight());
	        ps.setString(5, order.getDesignType());
	        ps.setString(6, order.getFabricColor());
	        ps.setString(7, order.getMaterial());
	        ps.setString(8, order.getSize());
	        ps.setFloat(9, order.getBust());
	        ps.setFloat(10, order.getWaist());
	        ps.setFloat(11, order.getHip());
	        ps.setFloat(12, order.getSleeveLength());
	        ps.setFloat(13, order.getLength());
	        ps.setString(14, order.getMessage());
	        ps.setString(15, order.getDesignFileName());

	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
    
	public List<CustomOrder> getAllOrders() {
	    List<CustomOrder> list = new ArrayList<>();
	    String sql = "SELECT id, full_name, phone, height, weight, message, design_file, " +
	                 "design_type, fabric_color, material, size, " +
	                 "bust, waist, hip, sleeve_length, length, created_at " +
	                 "FROM custom_orders ORDER BY created_at DESC";

	    try (Connection connection = DBConnect.getInstance().getConnection();
	         PreparedStatement ps = connection.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            CustomOrder order = new CustomOrder(
	                rs.getInt("id"),
	                rs.getString("full_name"),
	                rs.getString("phone"),
	                rs.getString("height"),
	                rs.getString("weight"),
	                rs.getString("message"),
	                rs.getString("design_file"),
	                rs.getString("design_type"),
	                rs.getString("fabric_color"),
	                rs.getString("material"),
	                rs.getString("size"),
	                String.valueOf(rs.getFloat("bust")),
	                String.valueOf(rs.getFloat("waist")),
	                String.valueOf(rs.getFloat("hip")),
	                String.valueOf(rs.getFloat("sleeve_length")),
	                String.valueOf(rs.getFloat("length")),
	                rs.getTimestamp("created_at")
	            );
	            list.add(order);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}

}
