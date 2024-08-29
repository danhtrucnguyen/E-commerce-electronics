<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="com.eazydeals.helper.ConnectionProvider"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
List<Product> productList = productDao.getAllLatestProducts();
List<Product> topDeals = productDao.getDiscountedProducts();
DecimalFormatSymbols symbols = new DecimalFormatSymbols();
symbols.setGroupingSeparator('.'); // Dấu phân cách hàng nghìn là dấu chấm
symbols.setDecimalSeparator(',');  // Dấu phân cách thập phân là dấu phẩy

// Tạo DecimalFormat với các ký tự định dạng tùy chỉnh
DecimalFormat df = new DecimalFormat("#,###.##", symbols);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.cus-card {
	border-radius: 50%;
	border-color: transparent;
	max-height: 200px;
	max-width: 200px;
}

.real-price {
	font-size: 20px !important;
	font-weight: 600;
}

.product-price {
	font-size: 17px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 15px !important;
	color: #027a3e;
}
</style>
</head>
<body>
	<!-- navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!-- Danh sách danh mục -->
	<div class="container-fluid px-3 py-3"
		style="background-color: #e3f7fc;">
		<div class="row">
			<div class="card-group">
				<%-- Lặp qua danh sách danh mục --%>
				<%
				for (Category c : categoryList) {
				%>
				<div class="col text-center">
					<a href="products.jsp?category=<%=c.getCategoryId()%>"
						style="text-decoration: none;">
						<div class="card cus-card h-100">
							<div class="container text-center">
								<img src="Product_imgs\<%=c.getCategoryImage()%>" class="mt-3 "
									style="max-width: 100%; max-height: 100px; width: auto; height: auto;">
							</div>
							<h6><%=c.getCategoryName()%></h6>
						</div>
					</a>
				</div>
				<%-- Kết thúc lặp danh mục --%>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<!-- kết thúc danh sách danh mục -->

	<!-- Carousel -->
	<div id="carouselAutoplaying"
		class="carousel slide carousel-dark mt-3 mb-3" data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="Images/banner1.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="Images/banner2.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="Images/banner3.png" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselAutoplaying" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"
				style="color: black;"></span> <span class="visually-hidden">Trước</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselAutoplaying" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Kế tiếp</span>
		</button>
	</div>
	<!-- kết thúc carousel -->

	<!-- sản phẩm mới nhất -->
	<div class="container-fluid py-3 px-3" style="background: #f2f2f2;">
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<div class="col">
				<div class="container text-center px-5 py-5">
					<h1>Sản Phẩm Mới Nhất</h1>
					<img src="Images/product.png" class="card-img-top"
						style="max-width: 100%; max-height: 200px; width: auto;">
				</div>
			</div>
			<%-- Lặp qua sản phẩm mới nhất --%>
			<%
			for (int i = 0; i < Math.min(3, productList.size()); i++) {
			%>
			<div class="col">
				<a href="viewProduct.jsp?pid=<%=productList.get(i).getProductId()%>"
					style="text-decoration: none;">
					<div class="card h-100">
						<div class="container text-center">
							<img
								src="Product_imgs\<%=productList.get(i).getProductImages()%>"
								class="card-img-top m-2"
								style="max-width: 100%; max-height: 200px; width: auto;">
						</div>
						<div class="card-body">
							<h5 class="card-title text-center"><%=productList.get(i).getProductName()%></h5>

							<div class="container text-center">
								<span class="real-price"><%=productList.get(i).getProductPriceAfterDiscount()%>&#8363;</span>
								&ensp;<span class="product-price"><%=productList.get(i).getProductPrice()%>&#8363;
								</span>&ensp;<span class="product-discount"><%=productList.get(i).getProductDiscount()%>&#37;
									giảm</span>
							</div>
						</div>
					</div>
				</a>
			</div>
			<%-- Kết thúc lặp sản phẩm mới nhất --%>
			<%
			}
			%>
		</div>
	</div>
	<!-- kết thúc danh sách sản phẩm mới nhất -->

	<!-- sản phẩm khuyến mãi -->
	<div class="container-fluid py-3 px-3" style="background: #f0fffe;">
		<h3>Khuyến Mãi Hot</h3>
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<%-- Lặp qua sản phẩm khuyến mãi --%>
			<%
			for (int i = 0; i < Math.min(4, topDeals.size()); i++) {
			%>
			<div class="col">
				<a href="viewProduct.jsp?pid=<%=topDeals.get(i).getProductId()%>"
					style="text-decoration: none;">
					<div class="card h-100">
						<div class="container text-center">
							<img src="Product_imgs\<%=topDeals.get(i).getProductImages()%>"
								class="card-img-top m-2"
								style="max-width: 100%; max-height: 200px; width: auto;">
						</div>
						<div class="card-body">
							<h5 class="card-title text-center"><%=topDeals.get(i).getProductName()%></h5>

							<div class="container text-center">
								<span class="real-price"><%=df.format(topDeals.get(i).getProductPriceAfterDiscount())%>&#8363;</span>
								&ensp;<span class="product-price"><%=df.format(topDeals.get(i).getProductPrice())%>&#8363;
								</span>&ensp;<span class="product-discount"><%=df.format(topDeals.get(i).getProductDiscount())%>&#37;
									giảm</span>
							</div>
						</div>
					</div>
				</a>
			</div>
			<%-- Kết thúc lặp sản phẩm khuyến mãi --%>
			<%
			}
			%>
		</div>
	</div>
	<!-- kết thúc khuyến mãi -->

	<!-- thông báo xác nhận đơn hàng thành công -->
	<%
	String order = (String) session.getAttribute("order");
	if (order != null) {
	%>
	<script type="text/javascript">
        console.log("testing..4...");
        Swal.fire({
          icon: 'success',
          title: 'Đơn hàng đã được đặt, cảm ơn bạn!',
          text: 'Xác nhận sẽ được gửi đến <%=user.getUserEmail()%>',
          width: 600,
          padding: '3em',
          showConfirmButton: false,
          timer: 3500,
          backdrop: `
            rgba(0,0,123,0.4)
          `
        });
    </script>
	<%
	}
	session.removeAttribute("order");
	%>
	<!-- kết thúc thông báo -->
		<%@include file="Components/footer.jsp"%>
	
</body>
</html>
