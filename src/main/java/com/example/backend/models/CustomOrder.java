package com.example.backend.models;

import java.sql.Timestamp;

public class CustomOrder {
	private int id;
	private String fullName, phone, height, weight, message, designFileName;
	private String designType, fabricColor, material, size;
	private float bust, waist, hip, sleeveLength, length;
	private Timestamp createdAt;

	// Constructor dùng khi lưu mới
	public CustomOrder(String fullName, String phone, String height, String weight, String designType,
			String fabricColor, String material, String size, float bust, float waist, float hip, float sleeveLength,
			float length, String message, String designFileName) {
		this.fullName = fullName;
		this.phone = phone;
		this.height = height;
		this.weight = weight;
		this.designType = designType;
		this.fabricColor = fabricColor;
		this.material = material;
		this.size = size;
		this.bust = bust;
		this.waist = waist;
		this.hip = hip;
		this.sleeveLength = sleeveLength;
		this.length = length;
		this.message = message;
		this.designFileName = designFileName;
	}

	// Constructor khi lấy từ DB
	public CustomOrder(int id, String fullName, String phone, String height, String weight, String message,
			String designFileName, String designType, String fabricColor, String material, String size, String bust,
			String waist, String hip, String sleeveLength, String dressLength, Timestamp createdAt) {
		this(fullName, phone, height, weight, designType, fabricColor, material, size, Float.parseFloat(bust),
				Float.parseFloat(waist), Float.parseFloat(hip), Float.parseFloat(sleeveLength),
				Float.parseFloat(dressLength), message, designFileName);
		this.id = id;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getDesignFileName() {
		return designFileName;
	}

	public void setDesignFileName(String designFileName) {
		this.designFileName = designFileName;
	}

	public String getDesignType() {
		return designType;
	}

	public void setDesignType(String designType) {
		this.designType = designType;
	}

	public String getFabricColor() {
		return fabricColor;
	}

	public void setFabricColor(String fabricColor) {
		this.fabricColor = fabricColor;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public float getBust() {
		return bust;
	}

	public void setBust(float bust) {
		this.bust = bust;
	}

	public float getWaist() {
		return waist;
	}

	public void setWaist(float waist) {
		this.waist = waist;
	}

	public float getHip() {
		return hip;
	}

	public void setHip(float hip) {
		this.hip = hip;
	}

	public float getSleeveLength() {
		return sleeveLength;
	}

	public void setSleeveLength(float sleeveLength) {
		this.sleeveLength = sleeveLength;
	}

	public float getLength() {
		return length;
	}

	public void setLength(float length) {
		this.length = length;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

}
