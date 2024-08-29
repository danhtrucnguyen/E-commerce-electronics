<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tạo Mật Khẩu Mới</title>
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

	<div class="container-fluid ">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body px-5">

						<div class="container text-center">
							<img src="Images/forgot-password.png" style="max-width: 100px;" class="img-fluid">
						</div>
						<h3 class="text-center mt-3">Cập Nhật Mật Khẩu</h3>
						<%@include file="Components/alert_message.jsp"%>

						<form action="ChangePasswordServlet" method="post">
							<div class="mb-3 mt-3">
								<label class="form-label">Mật Khẩu Mới</label> 
								<input type="password" name="password" id="password" placeholder="Nhập mật khẩu mới" class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Xác Nhận Mật Khẩu</label> 
								<input type="password" id="confirm_password" placeholder="Xác nhận mật khẩu" class="form-control" required>
							</div>
							<div class="container text-center">
								<button type="submit" class="btn btn-outline-primary me-3">Gửi</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="Components/footer.jsp"%>
	<script type="text/javascript">
		var password = document.getElementById("password");
		var confirm_password = document.getElementById("confirm_password");

		function validatePassword() {
			if (password.value != confirm_password.value) {
				confirm_password.setCustomValidity("Mật khẩu không khớp");
			} else {
				confirm_password.setCustomValidity('');
			}
		}
		password.onchange = validatePassword;
		confirm_password.onkeyup = validatePassword;
	</script>
</body>
</html>
