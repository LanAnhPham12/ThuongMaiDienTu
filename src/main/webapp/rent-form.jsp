<%@ page import="com.example.backend.models.Product" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.example.backend.DAO.ProductDAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String productId = request.getParameter("productId");
  Product product = ProductDAO.getProductById(Integer.parseInt(productId));

  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String today = sdf.format(new Date());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thuê sản phẩm</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
      background-color: #f4f4f4;
    }

    .rent-form-container {
      max-width: 500px;
      margin: auto;
      background: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .rent-form-container h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    .form-group {
      margin-bottom: 15px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    input[type="date"], input[type="text"] {
      width: 100%;
      padding: 8px;
      box-sizing: border-box;
    }

    img.product-image {
      display: block;
      margin: 0 auto 15px;
      max-width: 100%;
      height: auto;
      border-radius: 8px;
    }

    .submit-button {
      width: 100%;
      padding: 10px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
    }

    .submit-button:hover {
      background-color: #0056b3;
    }

    .product-name {
      text-align: center;
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>

<div class="rent-form-container">
  <h2>Thuê Sản Phẩm</h2>
  <form method="post" action="${pageContext.request.contextPath}/addRentToCart">
    <input type="hidden" name="productId" value="<%= product.getId() %>" />

    <img src="<%= product.getImages().get(0).getImageUrl() %>" alt="Ảnh sản phẩm" class="product-image" />

    <div class="product-name"><%= product.getName() %></div>
    <div style="text-align: center; color: #888; margin-bottom: 20px;">
      Giá gốc: <%= String.format("%,.0f", product.getPrice()) %> VND
    </div>


    <div class="form-group">
      <label for="rentDate">Ngày thuê:</label>
      <input type="date" id="rentDate" name="rentDate" value="<%= today %>" readonly />
    </div>

    <div class="form-group">
      <label for="returnDate">Ngày trả:</label>
      <input type="date" id="returnDate" name="returnDate" required min="<%= today %>" />
    </div>

    <button type="submit" class="submit-button">Xác nhận thuê</button>
  </form>
</div>

</body>
</html>
