
<%@ page import="com.example.backend.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.backend.models.ProductImage" %>
<%@ page import="java.awt.*" %>
<%@ page import="com.example.backend.models.Comment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Chi tiết sản phẩm</title>
  <link href="css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
  <link rel="shortcut icon" href="favicon.png" />

  <link href="css/tiny-slider.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/detail.css" />
</head>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f9f9f9;
  }

  .product-detail-container {
    display: flex;
    justify-content: space-around;
    padding: 20px;
  }

  .product-slider {
    width: 50%;
    position: relative;
    max-width: 500px;
  }

  .slider-image {
    width: 100%;
    height: auto;
    display: none;
  }

  .slider-image:first-child {
    display: block;
  }

  .prev,
  .next {
    position: absolute;
    top: 50%;
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    font-size: 30px;
    padding: 10px;
    cursor: pointer;
    transform: translateY(-50%);
  }

  .prev {
    left: 10px;
  }

  .next {
    right: 10px;
  }

  /* Phần thông tin sản phẩm */
  .product-info {
    width: 40%;
    padding: 20px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
  }

  .product-title {
    font-size: 24px;
    margin-bottom: 10px;
  }

  .product-price {
    font-size: 20px;
    color: #ff5722;
    margin-bottom: 20px;
  }

  .product-description {
    font-size: 16px;
    margin-bottom: 20px;
  }

  .add-to-cart {
    display: flex;
    justify-content: center;
  }

  .btn-add-to-cart {
    background-color: #3b5d50;
    color: white;
    padding: 10px 20px;
    font-size: 18px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  .btn-add-to-cart:hover {
    background-color: #35463f;
  }

  .list-img {
    margin-top: 20px;
    display: flex;
    gap: 20px;
    cursor: pointer;
  }

  .image {
    width: 100px;
    height: 100px;
    object-fit: cover;
  }

  .comment-section {
    background-color: white;
    padding: 20px;
    margin: 0 150px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    width: 700px;
    text-align: center;
    margin-bottom: 80px;
  }

  h2 {
    color: #333;
  }

  .input-field {
    width: 100%;
    height: 100%;
    padding: 12px;
    font-size: 14px;
    border-radius: 6px;
    border: 1px solid #ddd;
    background-color: #fff;
    position: relative;
    color: #333;
    min-height: 150px;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
  }

  .char-count {
    font-size: 12px;
    color: #888;
    margin-top: 5px;
    position: absolute;
    /* left: 15px; */
    right: 15px;
    top: 100px;
  }

  .submit-btn {
    padding: 10px 20px;
    background-color: #4caf50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 20px;
  }

  .submit-btn:hover {
    background-color: #45a049;
  }

  .comment {
    background-color: #f9f9f9;
    padding: 10px;
    margin: 10px 0;
    border-radius: 4px;
    border: 1px solid #ddd;
  }

  .comment .username {
    font-weight: bold;
    color: #333;
  }

  .comment .text {
    margin-top: 5px;
    color: #666;
  }

  h2 {
    color: #333;
    text-align: center;
  }

  .comment {
    background-color: #f9f9f9;
    padding: 15px;
    margin: 10px 0;
    border-radius: 8px;
    border: 1px solid #ddd;
  }

  .comment-header {
    display: flex;
    align-items: center;
  }

  .avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 15px;
  }

  .username {
    font-weight: bold;
    color: #333;
  }

  .text {
    margin-top: 10px;
    color: #666;
  }

  .timestamp {
    margin-top: 10px;
    font-size: 12px;
    color: #bbb;
    text-align: right;
  }
  .stars {
    font-size: 30px;
    color: #ddd;
    cursor: pointer;
  }

  .star {
    transition: color 0.3s;
    margin: 0 5px;
  }

  .star:hover {
    color: #ffbc00;
  }

  .star.selected {
    color: #ffbc00;
  }

  .action-buttons {
    display: flex;
    gap: 15px;
    justify-content: center;
    margin-top: 20px;
    flex-wrap: wrap;
  }

  .action-buttons form {
    margin: 0;
  }

  .action-buttons .btn {
    padding: 12px 25px;
    font-size: 16px;
    border: none;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s ease;
    min-width: 150px;
  }

  .btn-buy-now {
    background-color: #28a745;
  }

  .btn-buy-now:hover {
    background-color: #218838;
  }

  .btn-cart {
    background-color: #3b5d50;
  }

  .btn-cart:hover {
    background-color: #2e4a40;
  }

  .btn-rent {
    background-color: #007bff;
  }

  .btn-rent:hover {
    background-color: #0056b3;
  }

</style>

<body>
<div class="header"></div>

<%
  Product product = (Product) request.getAttribute("product");
  List<ProductImage> images = product != null ? product.getImages() : null;
%>

<div class="product-detail-container">
  <!-- Slider hình ảnh sản phẩm -->
  <div class="product-slider">
    <div class="slider">
      <% if (images != null) {
        for (ProductImage image : images) {
      %>
      <img src="<%= image.getImageUrl() %>" alt="Sản phẩm" class="slider-image" style="width: 500px; height: 500px" />
      <%  }
      } else { %>
      <p>Không có hình ảnh</p>
      <% } %>

      <div class="list-img">
        <% if (images != null) {
          for (ProductImage image : images) {
        %>
        <img src="<%= image.getImageUrl() %>" alt="Sản phẩm" class="image" />
        <% } } %>
      </div>
    </div>
    <button class="prev" onclick="moveSlide(-1)">❮</button>
    <button class="next" onclick="moveSlide(1)">❯</button>
  </div>

  <!-- Thông tin sản phẩm -->
  <div class="product-info">
    <h1 class="product-title" style="font-weight: bold">
      <%= product != null ? product.getName() : "Sản phẩm không tồn tại" %>
    </h1>

    <div class="rating" style="margin-bottom: 20px;">
      <span style="color: gold; font-size: 20px">&#9733;</span>
      <span style="color: gold; font-size: 20px">&#9733;</span>
      <span style="color: gold; font-size: 20px">&#9733;</span>
      <span style="color: gold; font-size: 20px">&#9733;</span>
      <p style="font-size: 24px">Có 1 bình luận</p>
    </div>

    <%
      java.text.NumberFormat currencyFormatter = java.text.NumberFormat.getCurrencyInstance(new java.util.Locale("vi", "VN"));
      String formattedPrice = product != null ? currencyFormatter.format(product.getPrice()) : "";
    %>
    <p class="product-price" style="color: gray; font-weight: bold">
      <%= formattedPrice.replace("₫", "VNĐ") %>
    </p>

    <div class="product-description" style="margin-bottom: 40px">
      <p style="font-size: 30px; color: black">Mô tả</p>
      <%= product != null ? product.getDescription() : "" %>
    </div>

    <div class="action-buttons">
      <form method="post" action="${pageContext.request.contextPath}/buy-now">
        <input type="hidden" name="productId" value="<%= product.getId() %>">
        <input type="hidden" name="quantity" value="1">
        <button type="submit" class="btn btn-buy-now">Mua ngay</button>
      </form>

      <form method="post" action="${pageContext.request.contextPath}/add-to-cart">
        <input type="hidden" name="productId" value="<%= product.getId() %>">
        <input type="hidden" name="quantity" value="1">
        <button type="submit" class="btn btn-cart">Thêm vào giỏ hàng</button>
      </form>

      <form method="get" action="${pageContext.request.contextPath}/rent-form.jsp">
        <input type="hidden" name="productId" value="<%= product.getId() %>">
        <button type="submit" class="btn btn-rent">Thuê sản phẩm</button>
      </form>
    </div>
  </div>
</div>

<div class="overview" style="padding: 0 140px">
  <h1 style="
          font-size: 40px;
          margin-bottom: 40px;
          padding: 10px 25px;
          background-color: #f2f4f7;
          color: black;
        ">
    Tổng quan
  </h1>
  <ul class="list-overview" style="width: 40%">
    <li style="
            list-style-type: none;
            display: flex;
            justify-content: space-between;
          ">
      <p style="font-size: 18px; font-weight: bold; width: 50%">
        Phạm vi làm mát:
      </p>

      <p style="width: 50%; font-size: 18px">Phòng 25 - 30m²</p>
      <hr style="border-top: 3px solid #bbb" />
    </li>
    <li style="
            list-style-type: none;
            display: flex;
            justify-content: space-between;
            font-size: 20px;
            width: 100%;
          ">
      <p style="font-size: 18px; font-weight: bold; width: 50%">
        Công suất:
      </p>
      <p style="width: 50%; font-size: 18px">150W</p>
      <hr style="border-top: 3px solid #bbb" />
    </li>
    <li style="
            list-style-type: none;
            display: flex;
            justify-content: space-between;
            width: 100%;
            font-size: 20px;
          ">
      <p style="font-size: 18px; font-weight: bold; width: 50%">
        Dung tích bình nước:
      </p>
      <p style="width: 50%; font-size: 18px">40 lít</p>
      <hr style="border-top: 3px solid #bbb" />
    </li>
    <li style="
            list-style-type: none;
            display: flex;
            justify-content: space-between;
            width: 100%;
          ">
      <p style="font-size: 18px; font-weight: bold; width: 50%">
        Độ ồn cao nhất:
      </p>
      <p style="width: 50%; font-size: 18px">65dB</p>
      <hr style="border-top: 3px solid #bbb" />
    </li>
    <li style="
            list-style-type: none;
            display: flex;
            justify-content: space-between;
            width: 100%;
          ">
      <p style="font-size: 18px; font-weight: bold; width: 50%">
        Bảng điều khiển:
      </p>
      <p style="width: 50%; font-size: 18px">Cảm ứng Có remote</p>
      <hr style="border-top: 3px solid #bbb" />
    </li>
    <li style="
            list-style-type: none;
            display: flex;
            justify-content: space-between;
            width: 100%;
          ">
      <p style="font-size: 18px; font-weight: bold; width: 50%">
        Năm ra mắt:
      </p>
      <p style="width: 50%; font-size: 18px">2019</p>
      <hr style="border-top: 3px solid #bbb" />
    </li>
  </ul>
</div>
<div class="comment-section">
  <h2>Bình luận</h2>
  <%
    List<Comment> comments = (List<Comment>) request.getAttribute("comments");
    System.out.println(comments);
    for(Comment comment: comments){
  %>
  <!-- Danh sách các bình luận hiển thị ở đây -->
  <div class="comment">
    <div class="comment-header">
      <img src="https://www.w3schools.com/w3images/avatar2.png" alt="Avatar" class="avatar">
      <div class="username"><%= comment.getUsername()%></div>
    </div>
    <div class="text"><%=  comment.getText()%></div>
    <div style="display: flex; align-items: center; justify-content: space-between;">
      <div class="stars" id="stars">
        <% for(int i =0 ; i < comment.getRating(); i++){%>
        <span style="color: gold;">&#9733;</span>
        <%} %>
      </div>
      <%
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String formattedDate = sdf.format(comment.getTimestamp());
      %>
      <div class="timestamp"><%=formattedDate%></div>
    </div>
  </div>

  <% }%>
  <form class="comment-form" action="/addComment" method="post">
    <div style="position: relative;">
      <input type="hidden" name="productId" value="<%=product.getId()%>">
      <textarea id="comment-textarea" name="text" placeholder="Viết bình luận của bạn..." class="input-field"
                maxlength="200"></textarea>
      <div class="rating-container">
        <h3>Đánh giá sản phẩm</h3>
        <div class="stars" id="stars">
          <span class="star" data-value="1">&#9733;</span>
          <span class="star" data-value="2">&#9733;</span>
          <span class="star" data-value="3">&#9733;</span>
          <span class="star" data-value="4">&#9733;</span>
          <span class="star" data-value="5">&#9733;</span>
        </div>
        <input type="hidden" id="rating" name="rating">
        <div class="rating-result">
          <p id="rating-text" style="margin-top: 20px;">Chưa đánh giá</p>
        </div>
      </div>
      <div class="char-count">
        <span id="char-count">200</span> ký tự còn lại
      </div>

    </div>
    <button type="submit" id="submit-comment" class="submit-btn" style="background-color: #3b5d50;">Gửi bình luận và đánh giá</button>
  </form>
</div>
<div>
  <!-----------------------Sản phẩm liên quan --------------------------------->
  <section class = "product-related container">
    <div class="product-related-title">
      <p>SẢN PHẨM LIÊN QUAN</p>
    </div>
    <div class="product-content">
      <%
        List<Product> relatedProducts = (List<Product>) request.getAttribute("relatedProducts");
        for(Product relatedProduct : relatedProducts){
      %>
      <div class="product-related-item">
        <img src="<%=relatedProduct.getImages().get(0).getImageUrl()%>" alt="hinh anh san pham" style="width: 231px; height: 231px">
        <a href="detail?id=<%=relatedProduct.getId()%>"><%= relatedProduct.getName()%></a>
        <p>
          <%

            String formattedRelatedPrice = currencyFormatter.format(relatedProduct.getPrice());
          %>
          <span class="price-new">  <%= formattedRelatedPrice.replace("₫", "VNĐ") %></span>

        </p>
      </div>
      <% }%>


    </div>

  </section>


</div>

<footer class="footer-section"></footer>
</body>
<script src="js/header.jsp"></script>
<script src="js/footer.js"></script>
<script>
  let currentSlide = 0
  const images = document.querySelectorAll(".image")
  const imagesArray = Array.from(images)
  function showSlide(index) {
    const slides = document.querySelectorAll(".slider-image")
    if (index >= slides.length) {
      currentSlide = 0
    } else if (index < 0) {
      currentSlide = slides.length - 1
    } else {
      currentSlide = index
    }

    // Ẩn tất cả các slide
    slides.forEach((slide) => (slide.style.display = "none"))
    imagesArray.forEach((img) => (img.style.border = "0"))
    imagesArray[currentSlide].style.border = "2px solid #5dad8c"
    // Hiển thị slide hiện tại
    slides[currentSlide].style.display = "block"
  }

  const activeImg = () => {
    let currentIndex = 0
    imagesArray.map((img, index) => {
      img.onclick = () => {
        if (currentIndex !== index) {
          currentIndex = index
        }
        imagesArray.forEach((img) => (img.style.border = "0"))
        imagesArray[currentIndex].style.border = "2px solid #5dad8c"
        showSlide(index)
      }
    })
  }
  activeImg()
  function moveSlide(step) {
    showSlide(currentSlide + step)
  }

  // Hiển thị slide đầu tiên khi tải trang
  document.addEventListener("DOMContentLoaded", () => {
    showSlide(currentSlide)
  })
  const textarea = document.getElementById('comment-textarea');
  const charCount = document.getElementById('char-count');

  // Cập nhật bộ đếm ký tự khi người dùng nhập
  textarea.addEventListener('input', function () {
    const maxLength = textarea.getAttribute('maxlength');  // Lấy giới hạn ký tự tối đa
    const currentLength = textarea.value.length;
    console.log(maxLength)  // Lấy số ký tự hiện tại
    const remainingChars = maxLength - currentLength;      // Tính số ký tự còn lại

    // Cập nhật hiển thị bộ đếm ký tự còn lại
    charCount.textContent = remainingChars;
  });
  const stars = document.querySelectorAll('.star');
  const ratingText = document.getElementById('rating-text');
  const submitButton = document.getElementById('submit-btn');


  // Biến lưu trữ điểm rating
  let ratingValue = 0;



  document.addEventListener("DOMContentLoaded", function() {
    const stars = document.querySelectorAll(".star");
    const ratingInput = document.getElementById("rating");

    stars.forEach(star => {
      star.addEventListener("mouseover", function() {

        const value = this.getAttribute("data-value");
        // Đổi màu sao khi hover
        stars.forEach(star => {
          if (star.getAttribute("data-value") <= value) {
            star.style.color = "gold";
          } else {
            star.style.color = "gray";
          }
        });
      });

      // star.addEventListener("mouseout", function() {
      //   // Reset màu sao khi bỏ chuột ra
      //   stars.forEach(star => {
      //     star.style.color = "gray";
      //   });
      // });

      star.addEventListener("click", function() {
        const value = this.getAttribute("data-value");
        ratingInput.value = value; // Cập nhật giá trị vào input ẩn
        // Thay đổi màu sao sau khi click
        stars.forEach(star => {
          if (star.getAttribute("data-value") <= value) {
            console.log(1)
            star.style.color = "gold";
          } else {
            star.style.color = "gray";
          }
        });
      });
    });
  });
  // Cập nhật bộ đếm ký tự khi người dùng nhập bình luận
  textarea.addEventListener('input', function() {
    const maxLength = textarea.getAttribute('maxlength');
    const currentLength = textarea.value.length;
    const remainingChars = maxLength - currentLength;
    charCount.textContent = remainingChars;
  });
</script>

<script>
  function addToCart(productId, name, categoryId, price, brand, stock, description) {
    // Ví dụ đơn giản lưu giỏ hàng vào localStorage (bạn chỉnh theo backend của bạn)
    let cart = JSON.parse(localStorage.getItem('cart')) || [];

    // Kiểm tra sản phẩm đã có trong giỏ chưa
    let existing = cart.find(item => item.productId === productId);
    if (existing) {
      existing.quantity += 1;  // tăng số lượng nếu đã có
    } else {
      cart.push({
        productId: productId,
        name: name,
        categoryId: categoryId,
        price: price,
        brand: brand,
        stock: stock,
        description: description,
        quantity: 1
      });
    }

    localStorage.setItem('cart', JSON.stringify(cart));
    alert('Đã thêm sản phẩm vào giỏ hàng!');
  }

  // Hàm "Mua ngay" => Thêm vào giỏ rồi chuyển sang trang giỏ hàng
  function addToCartAndRedirect(productId, name, categoryId, price, brand, stock, description) {
    addToCart(productId, name, categoryId, price, brand, stock, description);
    // Chuyển trang đến trang giỏ hàng, bạn sửa đường dẫn cho phù hợp với dự án của bạn
    window.location.href = '/cart';
  }

  // Slider ảnh sản phẩm (nếu bạn cần, theo code bạn đã có)
  let slideIndex = 0;
  showSlides(slideIndex);

  function moveSlide(n) {
    showSlides(slideIndex += n);
  }

  function showSlides(n) {
    let slides = document.getElementsByClassName("slider-image");
    if (n >= slides.length) slideIndex = 0;
    if (n < 0) slideIndex = slides.length - 1;
    for (let i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
    }
    slides[slideIndex].style.display = "block";
  }
</script>





<%--<script>--%>
<%--  function addToCart(productId, name, categoryId, price, brand, stock, description) {--%>
<%--    const data = {--%>
<%--      productId: productId,--%>
<%--      name: name,--%>
<%--      categoryId: categoryId,--%>
<%--      price: price,--%>
<%--      brand: brand,--%>
<%--      stock: stock,--%>
<%--      description: description,--%>
<%--      quantity: 1--%>
<%--    };--%>

<%--    fetch('/add-to-cart', {--%>
<%--      method: 'POST',--%>
<%--      headers: {--%>
<%--        'Content-Type': 'application/x-www-form-urlencoded'--%>
<%--      },--%>
<%--      body: new URLSearchParams(data).toString()--%>
<%--    })--%>
<%--            .then(response => response.text())--%>
<%--            .then(message => {--%>
<%--              alert(message);--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--              console.error('Lỗi:', error);--%>
<%--              alert('Có lỗi xảy ra khi thêm sản phẩm.');--%>
<%--            });--%>
<%--  }--%>
<%--</script>--%>
<%--<script>--%>
<%--  function addToCartAndRedirect(productId, name, categoryId, price, brand, stock, description) {--%>
<%--    const data = {--%>
<%--      productId: productId,--%>
<%--      name: name,--%>
<%--      categoryId: categoryId,--%>
<%--      price: price,--%>
<%--      brand: brand,--%>
<%--      stock: stock,--%>
<%--      description: description,--%>
<%--      quantity: 1--%>
<%--    };--%>

<%--    // Send product data to server--%>
<%--    fetch('/add-to-cart', {--%>
<%--      method: 'POST',--%>
<%--      headers: {--%>
<%--        'Content-Type': 'application/x-www-form-urlencoded'--%>
<%--      },--%>
<%--      body: new URLSearchParams(data).toString()--%>
<%--    })--%>
<%--            .then(response => response.text())--%>
<%--            .then(message => {--%>
<%--              alert(message);--%>

<%--              // Redirect to the delivery page after adding to cart--%>
<%--              window.location.href = "delivery.jsp";--%>
<%--            })--%>
<%--            .catch(error => {--%>
<%--              console.error('Lỗi:', error);--%>
<%--              alert('Có lỗi xảy ra khi thêm sản phẩm.');--%>
<%--            });--%>
<%--  }--%>
<%--</script>--%>
</html>
