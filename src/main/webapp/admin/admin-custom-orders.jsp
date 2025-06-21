<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.example.backend.models.CustomOrder"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Quản lý đơn đặt may</title>
<link rel="stylesheet" href="stylesheet/orderManagement.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
	<div class="container">
		<!-- Left Sidebar -->
		<div class="left">
			<%-- Sidebar menu nếu có --%>
		</div>

		<!-- Right Content -->
		<div class="right">
			<!-- Navbar -->
			<div class="navbar">
				<%-- Navbar content nếu có --%>
			</div>

			<!-- Main Content -->
			<div class="content">
				<h2 style="font-size: 30px; font-weight: bold; margin-bottom: 40px;">Quản
					lý đơn đặt may</h2>

				<div class="tablef-container">
					<table>
						<thead>
							<tr>
								<th>Mã</th>
								<th>Họ tên</th>
								<th>Điện thoại</th>
								<th>Chiều cao</th>
								<th>Cân nặng</th>
								<th>Loại áo</th>
								<th>Màu vải</th>
								<th>Chất liệu</th>
								<th>Size</th>
								<th>Ngực</th>
								<th>Eo</th>
								<th>Mông</th>
								<th>Dài tay</th>
								<th>Dài áo</th>
								<th>Lời nhắn</th>
								<th>File mẫu</th>
								<th>Ngày tạo</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<CustomOrder> orders = (List<CustomOrder>) request.getAttribute("orders");
							DecimalFormat df = new DecimalFormat("#.##");
							if (orders != null) {
								for (CustomOrder order : orders) {
							%>
							<tr>
								<td style="text-align: center"><%=order.getId()%></td>
								<td><%=order.getFullName()%></td>
								<td><%=order.getPhone()%></td>
								<td><%=order.getHeight()%></td>
								<td><%=order.getWeight()%></td>
								<td><%=order.getDesignType()%></td>
								<td><%=order.getFabricColor()%></td>
								<td><%=order.getMaterial()%></td>
								<td><%=order.getSize()%></td>
								<td><%=df.format(order.getBust())%></td>
								<td><%=df.format(order.getWaist())%></td>
								<td><%=df.format(order.getHip())%></td>
								<td><%=df.format(order.getSleeveLength())%></td>
								<td><%=df.format(order.getLength())%></td>
								<td><%=order.getMessage()%></td>
								<td style="text-align: center">
									<%
									String fileName = order.getDesignFileName();
									if (fileName != null && !fileName.trim().isEmpty()) {
									%> <a
									href="<%=request.getContextPath() + "/uploads/" + fileName%>"
									target="_blank">Xem file</a> <%
 } else {
 %>Không có<%
 }
 %>
								</td>
								<td class="createdAt"><%=order.getCreatedAt()%></td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- JS Format Ngày -->
	<script>
		function formatDate(dateString) {
			var date = new Date(dateString);
			var day = date.getDate().toString().padStart(2, '0');
			var month = (date.getMonth() + 1).toString().padStart(2, '0');
			var year = date.getFullYear();
			return day + '/' + month + '/' + year;
		}

		window.onload = function() {
			const dateCells = document.querySelectorAll(".createdAt");
			dateCells.forEach(function(cell) {
				const formatted = formatDate(cell.textContent);
				cell.textContent = formatted;
			});
		}
	</script>

	<!-- Sidebar/Navbar script -->
	<script
		src="<%=request.getContextPath()%>/admin/common/sidebar.js?v=1.0"></script>
	<script
		src="<%=request.getContextPath()%>/admin/common/navbar.js?v=1.0"></script>
</body>
</html>
