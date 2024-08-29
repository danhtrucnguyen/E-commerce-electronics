<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.DecimalFormatSymbols" %>
<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.eazydeals.dao.CartDao"%>
<%@page errorPage="error_exception.jsp"%>

<%
    User activeUser = (User) session.getAttribute("activeUser");
    if (activeUser == null) {
        Message message = new Message("Bạn chưa đăng nhập! Vui lòng đăng nhập trước!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("login.jsp");
        return;
    }
 // Tạo DecimalFormatSymbols tùy chỉnh với dấu phân cách hàng nghìn là dấu chấm
    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
    symbols.setGroupingSeparator('.'); // Dấu phân cách hàng nghìn là dấu chấm
    symbols.setDecimalSeparator(',');  // Dấu phân cách thập phân là dấu phẩy
    String from = (String) session.getAttribute("from");
    DecimalFormat df = new DecimalFormat("#,###", symbols); // Định dạng số với dấu phân cách hàng nghìn
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán</title>
    <%@ include file="Components/common_css_js.jsp" %>
</head>
<body>
    <!-- Navbar -->
    <%@ include file="Components/navbar.jsp" %>

    <div class="container mt-5" style="font-size: 17px;">
        <div class="row">

            <!-- Cột bên trái -->
            <div class="col-md-8">
                <div class="card">
                    <div class="container px-3 py-3">
                        <div class="card">
                            <div class="container-fluid text-white" style="background-color: #389aeb;">
                                <h4>Địa Chỉ Giao Hàng</h4>
                            </div>
                        </div>
                        <div class="mt-3 mb-3">
                            <h5><%= activeUser.getUserName() %> &nbsp; <%= activeUser.getUserPhone() %></h5>
                            <%
                                StringBuilder str = new StringBuilder();
                                str.append(activeUser.getUserAddress()).append(" - ");
                                str.append(activeUser.getUserWard()).append(" - ");
                                str.append(activeUser.getUserDistrict()).append(" - ");
                                str.append(activeUser.getUserCity());
                                out.println(str.toString());
                            %>
                            <br>
                            <div class="text-end">
                                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    Thay Đổi Địa Chỉ
                                </button>
                            </div>
                        </div>
                        <hr>
                        <div class="card">
                            <div class="container-fluid text-white" style="background-color: #389aeb;">
                                <h4>Chọn Phương Thức Thanh Toán</h4>
                            </div>
                        </div>
                        <form action="OrderOperationServlet" method="post">
                            <div class="form-check mt-2">
                                <input class="form-check-input" type="radio" name="paymentMode" value="Card Payment" required>
                                <label class="form-check-label">Thẻ Tín Dụng / Thẻ Ghi Nợ / Thẻ ATM</label><br>
                                <div class="mb-3">
                                    <input class="form-control mt-3" type="number" placeholder="Nhập số thẻ" name="cardno">
                                    <div class="row gx-5">
                                        <div class="col mt-3">
                                            <input class="form-control" type="number" placeholder="Nhập CVV" name="cvv">
                                        </div>
                                        <div class="col mt-3">
                                            <input class="form-control" type="text" placeholder="Hết hạn đến, ví dụ '07/23'">
                                        </div>
                                    </div>
                                    <input class="form-control mt-3" type="text" placeholder="Nhập tên chủ thẻ" name="name">
                                </div>
                                <input class="form-check-input" type="radio" name="paymentMode" value="Cash on Delivery">
                                <label class="form-check-label">Thanh Toán Khi Nhận Hàng</label>
                            </div>
                            <div class="text-end">
                                <button type="submit" class="btn btn-lg btn-outline-primary mt-3">Đặt Hàng</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Kết thúc cột -->

            <!-- Cột bên phải -->
            <div class="col-md-4">
                <div class="card">
                    <div class="container px-3 py-3">
                        <h4>Chi Tiết Giá</h4>
                        <hr>
                        <%
                            float totalPrice;
                            if (from != null && from.trim().equals("cart")) {
                                CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                                int totalProduct = cartDao.getCartCountByUserId(activeUser.getUserId());
                                totalPrice = (float) session.getAttribute("totalPrice");
                        %>
                        <table class="table table-borderless">
                            <tr>
                                <td>Tổng Số Sản Phẩm</td>
                                <td><%= totalProduct %></td>
                            </tr>
                            <tr>
                                <td>Tổng Giá</td>
                                <td><%= df.format(totalPrice) %>&#8363;</td>
                            </tr>
                            <tr>
                                <td>Phí Vận Chuyển</td>
                                <td>20.000&#8363;</td>
                            </tr>
                            <tr>
                                <td><h5>Số Tiền Cần Thanh Toán:</h5></td>
                                <td><h5><%= df.format(totalPrice + 20000) %>&#8363;</h5></td>
                            </tr>
                        </table>
                        <%
                            } else {
                                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                                int pid = (int) session.getAttribute("pid");
                                float price = productDao.getProductPriceById(pid);
                                totalPrice = price;
                        %>
                        <table class="table table-borderless">
                            <tr>
                                <td>Tổng Số Sản Phẩm</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>Tổng Giá</td>
                                <td><%= df.format(price) %>&#8363;</td>
                            </tr>
                            <tr>
                                <td>Phí Vận Chuyển</td>
                                <td>20.000&#8363;</td>
                            </tr>
                            <tr>
                                <td><h5>Số Tiền Cần Thanh Toán:</h5></td>
                                <td><h5><%= df.format(price + 20000) %>&#8363;</h5></td>
                            </tr>
                        </table>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <!-- Kết thúc cột -->
        </div>
    </div>

    <!-- Modal Thay Đổi Địa Chỉ -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Thay Đổi Địa Chỉ</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="UpdateUserServlet" method="post">
                    <input type="hidden" name="operation" value="changeAddress">
                    <div class="modal-body mx-3">
                        <div class="mt-2">
                            <label class="form-label fw-bold">Địa Chỉ</label>
                            <textarea name="user_address" rows="3" placeholder="Nhập địa chỉ (Khu vực và Đường)" class="form-control" required></textarea>
                        </div>
                        <div class="mt-2">
                            <label class="form-label fw-bold">Thành Phố</label> 
                            <input class="form-control" type="text" name="city" placeholder="Thành phố/Quận/Huyện" required>
                        </div>
                        <div class="mt-2">
                            <label class="form-label fw-bold">Mã Bưu Chính</label> 
                            <input class="form-control" type="number" name="pincode" placeholder="Mã bưu chính" maxlength="6" required>
                        </div>
                        <div class="mt-2">
                            <label class="form-label fw-bold">Tỉnh/Thành Phố</label> 
                            <select name="state" class="form-select">
                                <option selected>--Chọn Tỉnh/Thành Phố--</option>
                                <option value="Hà Nội">Hà Nội</option>
                                <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                                <option value="Đà Nẵng">Đà Nẵng</option>
                                <option value="Hải Phòng">Hải Phòng</option>
                                <option value="Cần Thơ">Cần Thơ</option>
                                <!-- Các tỉnh/thành phố khác -->
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@include file="Components/footer.jsp"%>
</body>
</html>
