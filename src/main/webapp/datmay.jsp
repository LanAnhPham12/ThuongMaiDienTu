<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="author" content="Untree.co" />
<link rel="shortcut icon" href="favicon.png" />
<meta name="description" content="" />
<meta name="keywords" content="bootstrap, bootstrap4" />

<!-- Bootstrap CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet" />
<link href="css/tiny-slider.css" rel="stylesheet" />
<link href="css/style.css" rel="stylesheet" />
<title>Đặt may theo yêu cầu</title>

<style>
.form-container {
	background-color: white;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	margin-top: 50px;
}

.form-container h2 {
	text-align: center;
	font-weight: bold;
	margin-bottom: 30px;
}

.btn-submit {
	background-color: #c28b51;
	color: white;
	font-weight: bold;
	border: none;
}

.btn-submit:hover {
	background-color: #a9743e;
}
</style>
</head>
<body>
	<!-- Header -->
	<div class="header"></div>

	<div class="container">
		<div class="form-container">
			<h2>ĐẶT MAY THEO YÊU CẦU</h2>
			<form action="custom-order" method="post"
				enctype="multipart/form-data">
				<!-- Thông tin cơ bản -->
				<div class="mb-3">
					<label for="fullName" class="form-label">Họ và tên</label> <input
						type="text" class="form-control" id="fullName" name="fullName"
						required />
				</div>

				<div class="mb-3">
					<label for="phone" class="form-label">Số điện thoại</label> <input
						type="text" class="form-control" id="phone" name="phone" required />
				</div>

				<!-- ✅ Chiều cao + Cân nặng -->
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="height" class="form-label">Chiều cao (cm)</label> <input
							type="text" class="form-control" id="height" name="height"
							placeholder="VD: 160" />
					</div>
					<div class="col-md-6 mb-3">
						<label for="weight" class="form-label">Cân nặng (kg)</label> <input
							type="text" class="form-control" id="weight" name="weight"
							placeholder="VD: 50" />
					</div>
				</div>

				<!-- Loại áo dài -->
				<div class="mb-3">
					<label class="form-label">Loại áo dài</label><br />
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="designType"
							value="Truyền thống" checked /> <label class="form-check-label">Truyền
							thống</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="designType"
							value="Cách tân" /> <label class="form-check-label">Cách
							tân</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="designType"
							value="Cưới" /> <label class="form-check-label">Cưới</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="designType"
							value="Lễ hội" /> <label class="form-check-label">Lễ hội</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="designType"
							value="Biểu diễn" /> <label class="form-check-label">Biểu
							diễn</label>
					</div>
				</div>


				<!-- Màu vải -->
				<div class="mb-3">
					<label for="fabricColor" class="form-label">Màu vải mong
						muốn</label> <input type="text" class="form-control" id="fabricColor"
						name="fabricColor" placeholder="VD: Trắng ngà, Đỏ đô, Tím pastel"
						required />
				</div>

				<!-- Chất liệu -->
				<div class="mb-3">
					<label class="form-label">Chất liệu</label><br />
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="material"
							value="Lụa" checked /> <label class="form-check-label">Lụa</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="material"
							value="Ren" /> <label class="form-check-label">Ren</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="material"
							value="Voan" /> <label class="form-check-label">Voan</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="material"
							value="Nhung" /> <label class="form-check-label">Nhung</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="material"
							value="Cotton" /> <label class="form-check-label">Cotton</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="material"
							value="Thun lạnh" /> <label class="form-check-label">Thun
							lạnh</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="material"
							value="Organza" /> <label class="form-check-label">Organza</label>
					</div>
				</div>

				<!-- Size -->
				<div class="mb-3">
					<label for="size" class="form-label">Chọn size</label> <select
						class="form-select" id="size" name="size">
						<option value="S">S</option>
						<option value="M">M</option>
						<option value="L">L</option>
						<option value="XL">XL</option>
						<option value="Tự nhập">Tự nhập số đo</option>
					</select>
				</div>

				<!-- Số đo -->
				<div class="row">
					<div class="col-md-4 mb-3">
						<label for="bust" class="form-label">Vòng ngực (cm)</label> <input
							type="number" class="form-control" id="bust" name="bust" />
					</div>
					<div class="col-md-4 mb-3">
						<label for="waist" class="form-label">Vòng eo (cm)</label> <input
							type="number" class="form-control" id="waist" name="waist" />
					</div>
					<div class="col-md-4 mb-3">
						<label for="hip" class="form-label">Vòng mông (cm)</label> <input
							type="number" class="form-control" id="hip" name="hip" />
					</div>
					<div class="col-md-6 mb-3">
						<label for="sleeveLength" class="form-label">Chiều dài tay
							áo (cm)</label> <input type="number" class="form-control"
							id="sleeveLength" name="sleeveLength" />
					</div>
					<div class="col-md-6 mb-3">
						<label for="length" class="form-label">Chiều dài áo (cm)</label> <input
							type="number" class="form-control" id="length" name="length" />
					</div>
				</div>

				<!-- File mẫu -->
				<div class="mb-3">
					<label for="designFile" class="form-label">Tải ảnh mẫu
						thiết kế</label> <input type="file" class="form-control" id="designFile"
						name="designFile" accept=".jpg,.jpeg,.png,.pdf" />
				</div>

				<!-- Ghi chú -->
				<div class="mb-3">
					<label for="message" class="form-label">Ghi chú thêm</label>
					<textarea class="form-control" id="message" name="message" rows="4"
						placeholder="VD: May gấp trước ngày cưới, thêu tên ở tay áo..."></textarea>
				</div>

				<!-- Submit -->
				<div class="text-center">
					<button type="submit" class="btn btn-submit px-5 py-2">GỬI
						ĐƠN</button>
				</div>
			</form>
		</div>
	</div>

	<!-- Footer -->
	<footer class="footer-section"></footer>

	<!-- JS -->
	<script src="js/bootstrap.bundle.min.js"></script>
	<script src="js/tiny-slider.js"></script>
	<script src="js/custom.js"></script>
	<script src="js/header.jsp"></script>
	<script src="js/footer.js"></script>
</body>
</html>
