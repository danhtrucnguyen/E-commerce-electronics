<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.dao.UserDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.eazydeals.entities.OrderedProduct"%>
<%@page import="com.eazydeals.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.dao.OrderedProductDao"%>
<%@page import="com.eazydeals.dao.OrderDao"%>
<%@page import="com.eazydeals.helper.ConnectionProvider"%>

<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("Bạn chưa đăng nhập! Vui lòng đăng nhập trước!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
OrderedProductDao ordProdDao = new OrderedProductDao(ConnectionProvider.getConnection());
List<Order> orderList = orderDao.getAllOrder();
UserDao userDao = new UserDao(ConnectionProvider.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xem Đơn Hàng</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbarAdmin.jsp"%>

	<!-- Chi tiết đơn hàng -->

	<div class="container-fluid px-3 py-3">
		<%
		if (orderList == null || orderList.size() == 0) {
		%>
		<div class="container mt-5 mb-5 text-center">
			<img src="Images/empty-cart.png" style="max-width: 200px;" class="img-fluid">
			<h4 class="mt-3">Không có đơn hàng nào</h4>
		</div>
		<%
		} else {
		%>
		<div class="container-fluid">
			<table class="table table-hover">
				<tr class="table-primary" style="font-size: 18px;">
					<th class="text-center">Sản Phẩm</th>
					<th>ID Đơn Hàng</th>
					<th>Chi Tiết Sản Phẩm</th>
					<th>Địa Chỉ Giao Hàng</th>
					<th>Ngày & Giờ</th>
					<th>Loại Thanh Toán</th>
					<th>Trạng Thái</th>
					<th colspan="2" class="text-center">Hành Động</th>
				</tr>
				<%
				for (Order order : orderList) {
					List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
					for (OrderedProduct orderProduct : ordProdList) {
				%>
				<form action="UpdateOrderServlet?oid=<%=order.getId()%>" method="post">
				<tr>
					<td class="text-center"><img src="Product_imgs/<%=orderProduct.getImage()%>" style="width: 50px; height: 50px; width: auto;"></td>
					<td><%=order.getOrderId()%></td>
					<td><%=orderProduct.getName()%><br>Số lượng: <%=orderProduct.getQuantity()%><br>Tổng Giá: &#8363;<%=orderProduct.getPrice() * orderProduct.getQuantity()%></td>
					<td><%=userDao.getUserName(order.getUserId())%><br>Điện thoại: <%=userDao.getUserPhone(order.getUserId())%><br><%=userDao.getUserAddress(order.getUserId())%></td>
					<td><%=order.getDate()%></td>
					<td><%=order.getPayementType()%></td>
					<td><%=order.getStatus()%></td>
					<td>
						<select id="operation" name="status" class="form-select">
							<option>--Chọn Hành Động--</option>
							<option value="Order Confirmed">Đơn Hàng Đã Xác Nhận</option>
							<option value="Shipped">Đã Gửi</option>
							<option value="Out For Delivery">Đang Giao Hàng</option>
							<option value="Delivered">Đã Giao</option>
						</select>
					</td>
					<td>
						<%
						if (order.getStatus().equals("Delivered")) {
						%>
						<button type="submit" class="btn btn-success disabled">Cập Nhật</button>
						<%
						} else {
						%>
						<button type="submit" class="btn btn-secondary">Cập Nhật</button> 
						<%
						 }
						 %>
					</td>
				</tr>
				</form>
				<%
				}
				}
				%>
			</table>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>
