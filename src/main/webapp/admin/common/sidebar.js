const currentPath = window.location.pathname;
const contextPath = window.location.pathname.split("/")[1]; // Lấy "Backend"

const sidebar = document.querySelector(".left");
sidebar.innerHTML = `
  <div class="logo">
    <img src="../images/logo.png" alt="logo" />
    <span>Furni</span>
  </div>
  <hr class="solid" />
  <div class="list-navbar">
    <ul class="list-item">
      <li class="item" id="item-product">
        <i class="fa-solid fa-fan"></i>
        <a href="/${contextPath}/admin/products">Quản lý sản phẩm</a>
      </li>
      <li class="item" id="item-category">
        <i class="fa-solid fa-layer-group"></i>
        <a href="/${contextPath}/admin/categories">Quản lý danh mục</a>
      </li>
      <li class="item" id="item-user">
        <i class="fa-solid fa-table-list"></i>
        <a href="/${contextPath}/admin/users">Quản lý người dùng</a>
      </li>
      <li class="item" id="item-order">
        <i class="fa-solid fa-gift"></i>
        <a href="/${contextPath}/admin/orders">Quản lý đơn hàng</a>
      </li>
      <li class="item" id="item-custom-order">
        <i class="fa-solid fa-scissors"></i>
        <a href="/${contextPath}/admin/custom-orders">Quản lý đơn đặt may</a>
      </li>
      <li class="item" id="item-discount">
        <i class="fa-solid fa-percent"></i>
        <a href="/${contextPath}/admin/discounts">Quản lý giảm giá</a>
      </li>
    </ul>
  </div>
  <div class="profile">
    <div class="avatar">
      <img src="https://png.pngtree.com/png-vector/20240724/ourlarge/pngtree-administrator-admin-avatar-png-image_12853673.png" alt="avatar" />
    </div>
    <p class="name">Emily Jonson</p>
    <span class="email">emilyjonson@gmail.com</span>
  </div>
  <ul class="list-item">
    <li class="item">
      <i class="fa-solid fa-right-from-bracket"></i>
      Đăng xuất
    </li>
  </ul>
`;

// === Highlight tab đang được mở ===
const items = document.querySelectorAll(".list-item li.item");
items.forEach(item => {
  const link = item.querySelector("a");
  if (link && currentPath.includes(link.getAttribute("href"))) {
    item.classList.add("active");
  }
});
