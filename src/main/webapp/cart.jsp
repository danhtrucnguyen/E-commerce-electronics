<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page import="com.eazydeals.entities.Cart"%>
<%@page import="com.eazydeals.dao.CartDao"%>
<%@page errorPage="error_exception.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ Hàng</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.qty {
	display: inline-block;
	padding: 3px 6px;
	width: 46px;
	height: 32px;
	border-radius: 2px;
	background-color: #fff;
	border: 1px solid #c2c2c2;
	margin: 0 5px;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<%
	float totalPrice = 0;
	CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
	List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
	if (listOfCart == null || listOfCart.size() == 0) {
	%>
	<div class="container text-center py-5 px-5">
		<img src="Images/empty-cart.png" style="max-width: 250px;"
			class="img-fluid">
		<h4 class="mt-5">Giỏ hàng của bạn trống!</h4>
		<p>Thêm sản phẩm vào giỏ hàng ngay.</p>
		<a href="products.jsp" class="btn btn-primary btn-lg" role="button"
			aria-disabled="true">Mua sắm ngay</a>
	</div>
	<%
	} else {
	%>
	
	<div class="container mt-5">
		<%@include file="Components/alert_message.jsp"%>
		<div class="card px-3 py-3">
			<table class="table table-hover">
				<thead>
					<tr class="table-primary text-center" style="font-size: 18px;">
						<th>Sản phẩm</th>
						<th>Tên sản phẩm</th>
						<th>Giá</th>
						<th>Số lượng</th>
						<th>Tổng giá</th>
						<th>Xóa</th>
					</tr>
				</thead>
				<tbody>
					<%
					ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
					for (Cart c : listOfCart) {
						Product prod = productDao.getProductsByProductId(c.getProductId());						
					%>
					<tr class="text-center">
						<td><img src="Product_imgs\<%=prod.getProductImages()%>"
							style="width: 50px; height: 50px; width: auto;"></td>
						<td class="text-start"><%=prod.getProductName()%></td>
						<td><%=prod.getProductPriceAfterDiscount()%>&#8363;</td>
						<td><a
							href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=1"
							role="button" class="btn btn-light"
							style="border-radius: 50%; font-size: 8px;"> <i
								class="fa-regular fa-plus fa-2xl"></i>
						</a>
						<div class="qty"><%=c.getQuantity()%></div>
							<%if(c.getQuantity() > 1){ %>
							<a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=2"
							role="button" class="btn btn-light" id="qtyDesc"
							style="border-radius: 50%; font-size: 8px;"> <i
								class="fa-solid fa-minus fa-2xl"></i></a>
							<%}else{ %>
							<a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=2"
							role="button" class="btn btn-light disabled" id="qtyDesc"
							style="border-radius: 50%; font-size: 8px;"> <i
								class="fa-solid fa-minus fa-2xl"></i></a>
							<%} %>
						</td>

						<td><%=c.getQuantity() * prod.getProductPriceAfterDiscount()%>&#8363;</td>
						<td><a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=3" class="btn btn-secondary" role="button">Xóa</a></td>
					</tr>
					<%
					totalPrice += c.getQuantity() * prod.getProductPriceAfterDiscount();
					}
					%>
					<tr>
						<td class="text-end" colspan="8"><h4 class='pe-5'>Tổng số tiền : <%=totalPrice%>&#8363;</h4></td>
					</tr>
				</tbody>
			</table>
			<div class="text-end">
				<a href="products.jsp" class="btn btn-outline-primary" role="button" aria-disabled="true">Tiếp tục mua sắm</a>&nbsp; 
				<a href="checkout.jsp" id="checkout-btn" class="btn btn-outline-primary" role="button" aria-disabled="true">Thanh toán</a>
			</div>

		</div>
	</div>
	<%
	}
	%>
	<%@include file="Components/footer.jsp"%>
	<script>
		$(document).ready(function(){
			$('#checkout-btn').click(function(){
			<%
			session.setAttribute("totalPrice", totalPrice);
			session.setAttribute("from", "cart");
			%>	
			});
		});
	</script>
	
</body>
</html>