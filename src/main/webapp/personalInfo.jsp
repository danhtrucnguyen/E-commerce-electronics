<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.entities.User"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%
User user1 = (User) session.getAttribute("activeUser");
if (user1 == null) {
    Message message = new Message("Bạn chưa đăng nhập! Vui lòng đăng nhập trước!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("login.jsp");
    return;
}
%>

<style>
label {
    font-weight: bold;
}
</style>

<div class="container px-3 py-3">
    <h3>Thông tin cá nhân</h3>
    <form id="update-user" action="UpdateUserServlet" method="post">
        <input type="hidden" name="operation" value="updateUser">
        <div class="row">
            <div class="col-md-6 mt-2">
                <label class="form-label">Tên của bạn</label>
                <input type="text" name="name" class="form-control" placeholder="Họ và tên" value="<%=user1.getUserName()%>" required>
            </div>
            <div class="col-md-6 mt-2">
                <label class="form-label">Email</label>
                <input type="email" name="email" placeholder="Địa chỉ email" class="form-control" value="<%=user1.getUserEmail()%>" required>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mt-2">
                <label class="form-label">Số điện thoại</label>
                <input type="number" name="mobile_no" placeholder="Số điện thoại" class="form-control" value="<%=user1.getUserPhone()%>" required>
            </div>
            <div class="col-md-6 mt-5">
                <label class="form-label pe-3">Giới tính</label>
                <input class="form-check-input" type="radio" name="gender" value="Male" <%=user1.getUserGender().equals("Male") ? "checked" : ""%>> 
                <span class="form-check-label pe-3 ps-1">Nam </span>
                <input class="form-check-input" type="radio" name="gender" value="Female" <%=user1.getUserGender().equals("Female") ? "checked" : ""%>> 
                <span class="form-check-label ps-1">Nữ </span>
            </div>
        </div>
        <div class="mt-2">
            <label class="form-label">Địa chỉ</label>
            <input type="text" name="address" placeholder="Nhập địa chỉ" class="form-control" value="<%=user1.getUserAddress()%>" required>
        </div>
        <div class="row">
            <div class="col-md-6 mt-2">
                <label class="form-label">Tỉnh/Thành phố</label>
                <select name="city" id="city" class="form-select">
                    <option value="<%=user1.getUserCity()%>" selected><%=user1.getUserCity()%></option>
                    <!-- Add other options here if necessary -->
                </select>
            </div>
            <div class="col-md-6 mt-2">
                <label class="form-label">Quận/Huyện</label>
                <select name="district" id="district" class="form-select">
                    <option value="<%=user1.getUserDistrict()%>" selected><%=user1.getUserDistrict()%></option>
                    <!-- Add other options here if necessary -->
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mt-2">
                <label class="form-label">Phường/Xã</label>
                <select name="ward" id="ward" class="form-select">
                    <option value="<%=user1.getUserWard()%>" selected><%=user1.getUserWard()%></option>
                    <!-- Add other options here if necessary -->
                </select>
            </div>
            <div class="col-md-6 mt-2">
                <label class="form-label">Mật khẩu</label>
                <input type="password" name="user_password" placeholder="Nhập mật khẩu" class="form-control" required>
            </div>
        </div>

        <div id="submit-btn" class="container text-center mt-4">
            <button type="submit" class="btn btn-outline-primary me-3">Cập nhật</button>
            <button type="reset" class="btn btn-outline-primary">Nhập lại</button>
        </div>
    </form>
</div>


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