<%@ page import="com.example.backend.models.Cart" %>
<%@ page import="com.example.backend.models.CartItem" %>
<%@ page import="com.example.backend.models.Product" %>
<%@ page import="com.example.backend.models.RentalItem" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link href="css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="css/delivery.css"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"/>
  <link href="css/style.css" rel="stylesheet"/>
  <title>Trang giao hàng</title>
</head>

<body>
<div class="header"></div>

<div class="hero">
  <div class="container">
    <div class="row justify-content-between">
      <div class="col-lg-5">
        <div class="intro-excerpt"><h1>Delivery</h1></div>
      </div>
    </div>
  </div>
</div>

<section class="delivery">
  <div class="container">
    <div class="delivery" style="display: flex; gap: 20px">
      <div class="delivery-content-right" style="flex: 1;">
        <form action="placeOrder" method="POST">

          <%
            Cart cart = (Cart) session.getAttribute("cart");
            double totalAmount = 0;
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
          %>

          <!-- SẢN PHẨM MUA -->
          <h4>Sản phẩm mua</h4>
          <table class="table table-bordered">
            <tr>
              <th>Mã sản phẩm</th>
              <th>Tên sản phẩm</th>
              <th>Số lượng</th>
              <th>Thành tiền</th>
            </tr>
            <%
              if (cart != null && !cart.getItems().isEmpty()) {
                for (CartItem item : cart.getItems().values()) {
                  double itemTotal = item.getProduct().getPrice() * item.getQuantity();
                  totalAmount += itemTotal;
            %>
            <tr>
              <td><%= item.getProduct().getId() %></td>
              <td><%= item.getProduct().getName() %></td>
              <td><%= item.getQuantity() %></td>
              <td><%= currencyFormatter.format(itemTotal) %> VNĐ</td>
            </tr>
            <%
              }
            } else {
            %>
            <tr><td colspan="4">Không có sản phẩm mua</td></tr>
            <% } %>
          </table>

          <!-- SẢN PHẨM THUÊ -->
          <h4>Sản phẩm thuê</h4>
          <table class="table table-bordered">
            <tr>
              <th>Mã sản phẩm</th>
              <th>Tên sản phẩm thuê</th>
              <th>Số ngày thuê</th>
              <th>Thành tiền</th>
            </tr>
            <%
              if (cart != null && !cart.getRentalItems().isEmpty()) {
                for (RentalItem rental : cart.getRentalItems()) {
                  double rentalTotal = rental.getTotalPrice();
                  totalAmount += rentalTotal;
            %>
            <tr>
              <td><%= rental.getProduct().getId() %></td>
              <td>
                <%= rental.getProduct().getName() %><br/>
                <small>(Từ <%= rental.getRentDate() %> đến <%= rental.getReturnDate() %>)</small>
              </td>
              <td><%= rental.getRentalDays() %> ngày</td>
              <td><%= currencyFormatter.format(rentalTotal) %> VNĐ</td>
            </tr>
            <%
              }
            } else {
            %>
            <tr><td colspan="4">Không có sản phẩm thuê</td></tr>
            <% } %>
          </table>

          <!-- TỔNG TIỀN -->
          <table class="table table-bordered">
            <tr>
              <td colspan="3"><strong>Tổng</strong></td>
              <td><%= currencyFormatter.format(totalAmount) %> VNĐ</td>
            </tr>
            <%
              double vat = totalAmount * 0.001;
              double totalAfterVAT = totalAmount - vat;
            %>
            <tr>
              <td colspan="3"><strong>Thuế VAT</strong></td>
              <td><%= currencyFormatter.format(vat) %></td>
            </tr>
            <tr>
              <td colspan="3"><strong>Tổng tiền hàng</strong></td>
              <td><%= currencyFormatter.format(totalAfterVAT) %> VNĐ</td>
            </tr>
          </table>

          <!-- THÔNG TIN GIAO HÀNG -->
          <label for="shippingAddress">Địa chỉ giao hàng:</label>
          <input type="text" id="shippingAddress" name="shippingAddress" required class="form-control mb-2"/>

          <label for="paymentMethod">Phương thức thanh toán:</label>
          <select id="paymentMethod" name="paymentMethod" required class="form-control mb-3">
            <option value="Credit Card">Credit Card</option>
            <option value="Cash on Delivery">Cash on Delivery</option>
          </select>

          <!-- Hidden tổng tiền gửi đi -->
          <input type="hidden" name="totalAmount" value="<%= totalAmount * 1.1 %>"/>

          <!-- Nút hành động -->
          <div class="delivery-content-left-button now">
            <a href="cart.jsp"><span>&#171;</span> Quay lại giỏ hàng</a>
            <button type="submit" class="btn btn-primary" style="font-weight: bold;">
              THANH TOÁN VÀ GIAO HÀNG
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

<footer class="footer-section"></footer>

<script src="js/bootstrap.bundle.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/header.jsp"></script>
<script src="js/footer.js"></script>
</body>
</html>
