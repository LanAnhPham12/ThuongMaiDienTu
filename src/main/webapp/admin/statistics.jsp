<%@ page import="com.example.backend.models.ProductStat" %>
<%@ page import="com.example.backend.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thống kê hệ thống</title>
    <link rel="stylesheet" href="stylesheet/categoryManagement.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
</head>
<body>
<div class="container">
    <!-- Left -->
    <div class="left">
    </div>
    <div class="right">
        <div class="navbar">
        </div>
        <div class="content">
            <h2 style="font-weight: bold">📊 Tổng quan thống kê</h2>
            <table style="margin-top: 20px">
                <tr>
                    <th>💰 Doanh thu</th>
                    <th>📦 Đơn hàng</th>
                    <th>🔁 Lượt thuê</th>
                    <th>🛍️ Sản phẩm</th>
                </tr>
                <tr>
                    <td style="text-align: center"><%= request.getAttribute("totalRevenue") %> VNĐ</td>
                    <td style="text-align: center"><%= request.getAttribute("totalOrders") %></td>
                    <td style="text-align: center"><%= request.getAttribute("totalRentals") %></td>
                    <td style="text-align: center"><%= request.getAttribute("totalProducts") %></td>
                </tr>
            </table>

            <h3 style="font-weight: bold; margin-top: 30px">🔥 Top sản phẩm bán chạy</h3>
            <table style="margin-top: 20px">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng đã bán</th>
                </tr>
                <%
                    List<ProductStat> topSelling = (List<ProductStat>) request.getAttribute("topSelling");
                    if (topSelling != null) {
                        for (ProductStat p : topSelling) {
                %>
                <tr>
                    <td style="text-align: center"><%= p.getName() %></td>
                    <td style="text-align: center"><%= p.getSoldQuantity() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>

            <h3 style="font-weight: bold; margin-top: 30px">⚠️ Sản phẩm sắp hết hàng (<= 5)</h3>
            <table style="margin-top: 20px">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Tồn kho</th>
                </tr>
                <%
                    List<Product> lowStock = (List<Product>) request.getAttribute("lowStock");
                    if (lowStock != null && !lowStock.isEmpty()) {
                        for (Product p : lowStock) {
                %>
                <tr>
                    <td style="text-align: center"><%= p.getName() %></td>
                    <td style="text-align: center"><%= p.getStock() %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="2" style="text-align: center; padding: 10px;">
                        <p style="margin-top: 20px; font-style: italic; color: #666;">
                            Không có sản phẩm nào sắp hết hàng
                        </p>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>

            <h3 style="font-weight: bold; margin-top: 30px">👥 Người dùng theo vai trò</h3>
            <table style="margin-top: 20px">
                <tr>
                    <th>Vai trò</th>
                    <th>Số lượng</th>
                </tr>
                <%
                    Map<String, Integer> usersByRole = (Map<String, Integer>) request.getAttribute("usersByRole");
                    if (usersByRole != null) {
                        for (Map.Entry<String, Integer> entry : usersByRole.entrySet()) {
                %>
                <tr>
                    <td style="text-align: center"><%= entry.getKey() %></td>
                    <td style="text-align: center"><%= entry.getValue() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>

            <h3 style="font-weight: bold; margin-top: 30px">✅ Người dùng theo trạng thái</h3>
            <table style="margin-top: 20px">
                <tr>
                    <th>Trạng thái</th>
                    <th>Số lượng</th>
                </tr>
                <%
                    Map<String, Integer> usersByStatus = (Map<String, Integer>) request.getAttribute("usersByStatus");
                    if (usersByStatus != null) {
                        for (Map.Entry<String, Integer> entry : usersByStatus.entrySet()) {
                %>
                <tr>
                    <td style="text-align: center"><%= entry.getKey() %></td>
                    <td style="text-align: center"><%= entry.getValue() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
                </div>
        </div>
    </div>
</div>

</body>
<script src="<%= request.getContextPath() %>/admin/common/sidebar.js"></script>
<script src="<%= request.getContextPath() %>/admin/common/navbar.js"></script>
<script type="module">
    import activeElement from "/admin/common/common.js"
    const element = document.getElementById("item-category")
    activeElement(element)
</script>
</html>
