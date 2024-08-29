<%@page import="com.eazydeals.entities.Message"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("Bạn chưa đăng nhập! Vui lòng đăng nhập trước!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xem Danh Mục</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbarAdmin.jsp"%>

	<!-- Category -->
	<div class="container mt-3">
	<%@include file="Components/alert_message.jsp"%>
		<table class="table table-hover">
			<tr class="table-primary text-center" style="font-size: 20px;">
				<th>Hình Ảnh</th>
				<th>Tên Danh Mục</th>
				<th>Hành Động</th>
			</tr>
			<%
			for (Category c : categoryList) {
			%>
			<tr class="text-center">
				<td><img src="Product_imgs/<%=c.getCategoryImage()%>" style="width: 60px; height: 60px; width: auto;"></td>
				<td><%=c.getCategoryName()%></td>
				<td><a href="update_category.jsp?cid=<%=c.getCategoryId()%>" role="button" class="btn btn-secondary">Cập Nhật</a>&emsp;<a href="AddOperationServlet?cid=<%=c.getCategoryId()%>&operation=deleteCategory" class="btn btn-danger" role="button">Xóa</a></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

</body>
</html>
