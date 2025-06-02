<%@ page import="com.example.backend.models.Cart" %>
<%@ page import="com.example.backend.models.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta
          name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no"
  />
  <meta name="author" content="Untree.co"/>
  <link rel="shortcut icon" href="favicon.png"/>

  <meta name="description" content=""/>
  <meta name="keywords" content="bootstrap, bootstrap4"/>

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/cart.css"/>
  <link href="css/bootstrap.min.css" rel="stylesheet"/>
  <link
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
          rel="stylesheet"
  />
  <link href="css/tiny-slider.css" rel="stylesheet"/>
  <link href="css/style.css" rel="stylesheet"/>
  <title>Trang giỏ hàng</title>
</head>

<body>
<!-- Start Header/Navigation -->
<div class="header"></div>
<!-- End Header/Navigation -->

<!-- Start Hero Section -->
<div class="hero">
  <div class="container">
    <div class="row justify-content-between">
      <div class="col-lg-5">
        <div class="intro-excerpt">
          <h1>Cart</h1>
        </div>
      </div>
      <div class="col-lg-7"></div>
    </div>
  </div>
</div>
<!-- End Hero Section -->

<section class="cart">
  <div class="container">
    <div class="cart-top-wrap">
      <div class="cart-top">
        <div class="cart-top-cart cart-top-item">
          <i class="fa-solid fa-cart-shopping"></i>
        </div>

        <div class="cart-top-address cart-top-item">
          <i class="fa-solid fa-location-dot"></i>
        </div>

        <div class="cart-top-payment cart-top-item">
          <i class="fa-solid fa-money-check"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="container">
    <div class="cart-content" style="display: flex; gap: 20px">
      <!-- Cột trái -->
      <div class="cart-content-left" style="flex: 1; max-width: 70%">
        <%
          Cart cart = (Cart) session.getAttribute("cart");
          java.text.NumberFormat currencyFormatter = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("vi", "VN"));

          if (cart != null && !cart.getItems().isEmpty()) {
        %>
        <form action="update-cart" method="post">
          <table>
            <thead>
            <tr>
              <th class="product-name">Ảnh</th>
              <th class="product-name">Tên Sản Phẩm</th>
              <th class="product-price">Giá</th>
              <th class="product-quantity">Số Lượng</th>
              <th class="product-total">Thành Tiền</th>
              <th class="product-remove">Xóa</th>
            </tr>
            </thead>
            <tbody>
            <%
              for (CartItem item : cart.getItems().values()) {
                String formattedPrice = currencyFormatter.format(item.getProduct().getPrice());
                double totalPriceItem = item.getQuantity() * item.getProduct().getPrice();
                String formattedTotalPriceItem = currencyFormatter.format(totalPriceItem);
            %>
            <tr>
              <td>
                <img src="<%=item.getProduct().getImages().get(0).getImageUrl()%>" alt="product_img" style="width: 80px;"/>
              </td>
              <td><%=item.getProduct().getName()%></td>
              <td><%=formattedPrice%></td>
              <td>
                <input type="number"
                       name="quantity_<%=item.getProduct().getId()%>"
                       value="<%=item.getQuantity()%>"
                       min="1"
                       class="form-control form-control-sm text-center border-0"
                       data-cart-item-id="<%=item.getProduct().getId()%>"
                       data-cart-item-price="<%=item.getProduct().getPrice()%>"
                       style="width: 60px;">
              </td>
              <td class="text-right font-weight-semibold align-middle p-4" data-cart-item-total>
                <%=formattedTotalPriceItem%>
              </td>
              <td><a href="/remove-from-cart?productId=<%=item.getProduct().getId()%>">x</a></td>
            </tr>
            <%
              }
            %>
            </tbody>
          </table>
          <button type="submit" class="btn btn-primary mt-3">Cập nhật giỏ hàng</button>
        </form>
        <%
        } else {
        %>
        <p>Giỏ hàng của bạn đang trống.</p>
        <% } %>

        <%-- Hiển thị sản phẩm thuê nếu có --%>
        <% if (cart != null && !cart.getRentalItems().isEmpty()) { %>
        <h3>Sản phẩm thuê</h3>
        <table class="table table-bordered">
          <thead>
          <tr>
            <th>Ảnh</th>
            <th>Tên sản phẩm</th>
            <th>Giá thuê/ngày</th>
            <th>Ngày thuê</th>
            <th>Ngày trả</th>
            <th>Số ngày</th>
            <th>Tổng tiền</th>
          </tr>
          </thead>
          <tbody>
          <%
            for (com.example.backend.models.RentalItem rental : cart.getRentalItems()) {
              String rentalPricePerDay = currencyFormatter.format(rental.getProduct().getRentalPrice());
              String totalRentalPrice = currencyFormatter.format(rental.getTotalPrice());
          %>
          <tr>
            <td>
              <img src="<%=rental.getProduct().getImages().get(0).getImageUrl()%>" alt="product_img" style="width: 80px;" />
            </td>
            <td><%=rental.getProduct().getName()%></td>
            <td><%=rentalPricePerDay%></td>
            <td><%=rental.getRentDate()%></td>
            <td><%=rental.getReturnDate()%></td>
            <td><%=rental.getRentalDays()%></td>
            <td><%=totalRentalPrice%></td>
          </tr>
          <%
            }
          %>
          </tbody>
        </table>
        <% } %>

      </div>

      <!-- Cột phải -->
      <div class="cart-content-right" style="flex: 1; max-width: 30%">
        <%
          if (cart != null && !cart.getItems().isEmpty()) {
            String formattedTotalPrice = currencyFormatter.format(cart.getTotalPrice());
        %>
        <table class="table table-bordered">
          <tr>
            <th colspan="2">TỔNG TIỀN GIỎ HÀNG</th>
          </tr>
          <tr>
            <td>TỔNG SẢN PHẨM</td>
            <td><%=cart.getItems().size()%></td>
          </tr>
          <tr>
            <td>TỔNG TIỀN HÀNG</td>
            <td>
              <p data-cart-total><%= formattedTotalPrice %></p>
            </td>
          </tr>
          <tr>
            <td>TẠM TÍNH</td>
            <td>
              <p style="color: black; font-weight: bold" data-cart-total><%= formattedTotalPrice %></p>
            </td>
          </tr>
        </table>
        <%
          }
        %>

        <div class="cart-content-right-button d-flex flex-column gap-2">
          <a class="btn btn-outline-secondary" href="shop?categoryId=3">TIẾP TỤC MUA HÀNG</a>
          <a class="btn btn-primary" href="delivery.jsp">THANH TOÁN</a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Start Footer Section -->
<footer class="footer-section"></footer>
<!-- End Footer Section -->

<script>
  document.addEventListener("DOMContentLoaded", function () {
    function updateCartTotals() {
      let cartTotal = 0;

      document.querySelectorAll("tbody tr").forEach(row => {
        const qtyInput = row.querySelector("input[type=number]");
        if (!qtyInput) return;
        const price = parseFloat(qtyInput.dataset.cartItemPrice);
        const quantity = parseInt(qtyInput.value);
        const totalCell = row.querySelector("[data-cart-item-total]");
        const total = price * quantity;

        totalCell.innerText = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(total);
        cartTotal += total;
      });

      document.querySelectorAll("[data-cart-total]").forEach(el => {
        el.innerText = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(cartTotal);
      });
    }

    updateCartTotals();

    document.querySelectorAll("input[type=number]").forEach(input => {
      input.addEventListener("input", updateCartTotals);
    });
  });
</script>

<script src="js/bootstrap.bundle.min.js"></script>
<script src="js/tiny-slider.js"></script>
<script src="js/custom.js"></script>
<script src="js/header.jsp"></script>
<script src="js/footer.js"></script>
</body>
</html>
