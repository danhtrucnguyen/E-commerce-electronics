<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
label {
	font-weight: bold;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container-fluid mt-4">
		<div class="row g-0">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body px-5">

						<div class="container text-center">
							<img src="Images/signUp.png" style="max-width: 80px;"
								class="img-fluid">
						</div>
						<h3 class="text-center">Đăng kí</h3>
						<%@include file="Components/alert_message.jsp"%>

						<!--registration-form-->
						<form id="register-form" action="RegisterServlet" method="post">
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Họ và tên</label> <input type="text"
										name="user_name" class="form-control" placeholder="Tên và họ"
										required>
								</div>
								<div class="col-md-6 mt-2">
									<label class="form-label">Email</label> <input type="email"
										name="user_email" placeholder="Địa chỉ email"
										class="form-control" required>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Số điện thoại</label> <input
										type="number" name="user_mobile_no"
										placeholder="Số điện thoại" class="form-control">
								</div>
								<div class="col-md-6 mt-5">
									<label class="form-label pe-3">Giới tính</label> <input
										class="form-check-input" type="radio" name="gender"
										value="Male"> <span class="form-check-label pe-3 ps-1">Nam</span>
									<input class="form-check-input" type="radio" name="gender"
										value="Female"> <span class="form-check-label ps-1">Nữ</span>
								</div>
							</div>
							<div class="mt-2">

								<label class="form-label">Địa chỉ</label> <input type="text"
									name="user_address"
									placeholder="Nhập địa chỉ (Khu vực và Đường)"
									class="form-control" required>
							</div>
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Tỉnh/Thành phố</label> <select
										name="city" id="city" class="form-select">
										<option value="" selected>Chọn tỉnh thành</option>
									</select>

								</div>
								<div class="col-md-6 mt-2">
									<label class="form-label">Quận/Huyện</label> <select
										name="district" id="district" class="form-select">
										<option value="" selected>Chọn quận huyện</option>
									</select>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Phường/Xã</label> <select
										name="ward" id="ward" class="form-select">
										<option value="" selected>Chọn phường xã</option>
									</select>
								</div>
								<div class="col-md-6 mt-2">
									<label class="form-label">Mật khẩu</label> <input
										type="password" name="user_password"
										placeholder="Nhập mật khẩu" class="form-control" required>
								</div>
							</div>

							<div id="submit-btn" class="container text-center mt-4">
								<button type="submit" class="btn btn-outline-primary me-3">Đăng
									kí</button>
								<button type="reset" class="btn btn-outline-primary">Làm
									lại</button>
							</div>
							<div class="mt-3 text-center">
								<h6>
									Đã có tài khoản? <a href="login.jsp"
										style="text-decoration: none">Đăng nhập</a>
								</h6>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="Components/footer.jsp"%>
</body>
</html>

<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
    var citis = document.getElementById("city");
    var districts = document.getElementById("district");
    var wards = document.getElementById("ward");

    var Parameter = {
        url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
        method: "GET",
        responseType: "application/json",
    };

    var promise = axios(Parameter);
    promise.then(function (result) {
        renderCity(result.data);
    });

    function renderCity(data) {
        for (const x of data) {
            citis.options[citis.options.length] = new Option(x.Name, x.Name); // Lưu tên làm giá trị
        }
        citis.onchange = function () {
            districts.length = 1; // Xóa các tùy chọn cũ
            wards.length = 1; // Xóa các tùy chọn cũ
            if (this.value !== "") {
                const result = data.filter(n => n.Name === this.value);

                for (const k of result[0].Districts) {
                    districts.options[districts.options.length] = new Option(k.Name, k.Name); // Lưu tên làm giá trị
                }
            }
        };
        districts.onchange = function () {
            wards.length = 1; // Xóa các tùy chọn cũ
            const dataCity = data.filter((n) => n.Name === citis.value);
            if (this.value !== "") {
                const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;

                for (const w of dataWards) {
                    wards.options[wards.options.length] = new Option(w.Name, w.Name); // Lưu tên làm giá trị
                }
            }
        };
    }

	</script>
