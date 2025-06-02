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
<html>
<head>
  <title>Form thuê sản phẩm</title>
</head>
<body>
<h2>Thuê sản phẩm</h2>
<form method="post" action="${pageContext.request.contextPath}/addRentToCart">
  <input type="hidden" name="productId" value="<%= product.getId() %>"/>

  <div>
    <img src="<%= product.getImages().get(0).getImageUrl() %>" alt="Ảnh sản phẩm" style="width:150px;"/>
  </div>
  <div>
    <strong>Tên sản phẩm: </strong><%= product.getName() %>
  </div>
  <div>
    <label>Ngày thuê:</label>
    <label>
      <input type="date" name="rentDate" value="<%= today %>" readonly />
    </label>
  </div>
  <div>
    <label>Ngày trả:</label>
    <label>
      <input type="date" name="returnDate" required min="<%= today %>" />
    </label>
  </div>
  <button type="submit">Xác nhận thuê</button>
</form>
</body>
</html>
