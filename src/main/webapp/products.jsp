<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="com.eazydeals.dao.WishlistDao"%>
<%@page import="com.eazydeals.entities.User"%>
<%@page import="com.eazydeals.dao.CategoryDao"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.helper.ConnectionProvider"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%
User u = (User) session.getAttribute("activeUser");
WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());

String searchKey = request.getParameter("search");
String catId = request.getParameter("category");
CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
String message = "";

ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
List<Product> prodList = null;
DecimalFormatSymbols symbols = new DecimalFormatSymbols();
symbols.setGroupingSeparator('.'); // Dấu phân cách hàng nghìn là dấu chấm
symbols.setDecimalSeparator(',');  // Dấu phân cách thập phân là dấu phẩy

// Tạo DecimalFormat với các ký tự định dạng tùy chỉnh
DecimalFormat df = new DecimalFormat("#,###.##", symbols);

if (searchKey != null && !searchKey.isEmpty()) {
	message = "Hiển thị kết quả tìm kiếm cho \"" + searchKey + "\"";
	prodList = productDao.getAllProductsBySearchKey(searchKey);
} else if (catId != null && !catId.trim().isEmpty() && !catId.trim().equals("0")) {
	try {
		int categoryId = Integer.parseInt(catId.trim());
		prodList = productDao.getAllProductsByCategoryId(categoryId);
		message = "Hiển thị kết quả cho danh mục \"" + categoryDao.getCategoryName(categoryId) + "\"";
	} catch (NumberFormatException e) {
		message = "ID danh mục không hợp lệ";
		prodList = productDao.getAllProducts();
	}
} else {
	prodList = productDao.getAllProducts();
	message = "Tất cả sản phẩm";
}

if (prodList == null || prodList.isEmpty()) {
	message = "Không có sản phẩm nào cho \"" + (searchKey != null ? searchKey
	: (catId != null ? categoryDao.getCategoryName(Integer.parseInt(catId.trim())) : "Danh mục không xác định"))
	+ "\"";
	prodList = productDao.getAllProducts();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sản phẩm</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
.real-price {
	font-size: 22px !important;
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

.wishlist-icon {
	cursor: pointer;
	position: absolute;
	right: 10px;
	top: 10px;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	border: 1px solid #f0f0f0;
	box-shadow: 0 1px 4px 0 rgba(0, 0, 0, .1);
	padding-right: 40px;
	background: #fff;
}
</style>
</head>
<body style="background-color: #f0f0f0;">
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!--show products-->
	<h4 class="text-center mt-2"><%=message%></h4>
	<div class="container-fluid my-3 px-5">
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<%
			if (prodList != null) {
				for (Product p : prodList) {
			%>
			<div class="col">
				<div class="card h-100 px-2 py-2">
					<div class="container text-center position-relative">
						<img src="Product_imgs/<%=p.getProductImages()%>"
							class="card-img-top m-2"
							style="max-width: 100%; max-height: 200px; width: auto;">
						<div class="wishlist-icon">
							<%
							if (u != null) {
								if (wishlistDao.getWishlist(u.getUserId(), p.getProductId())) {
							%>
							<button
								onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=remove', '_self')"
								class="btn btn-link" type="button">
								<i class="fa-sharp fa-solid fa-heart" style="color: #ff0303;"></i>
							</button>
							<%
							} else {
							%>
							<button type="button"
								onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=add', '_self')"
								class="btn btn-link">
								<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
							</button>
							<%
							}
							} else {
							%>
							<button onclick="window.open('login.jsp', '_self')"
								class="btn btn-link" type="button">
								<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
							</button>
							<%
							}
							%>
						</div>
						<h5 class="card-title text-center"><%=p.getProductName()%></h5>
						<div class="container text-center">
							<span class="real-price"><%=df.format(p.getProductPriceAfterDiscount())%>&#8363;</span>&ensp;
                            <span class="product-price"><%=df.format(p.getProductPrice())%>&#8363;</span>&ensp;
                            <span class="product-discount"><%=p.getProductDiscount()%>&#37;
                                GIẢM</span>
						</div>
						<div class="container text-center mb-2 mt-2">
							<button type="button"
								onclick="window.open('viewProduct.jsp?pid=<%=p.getProductId()%>', '_self')"
								class="btn btn-primary text-white">Xem Chi Tiết</button>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>
	<%@include file="Components/footer.jsp"%>
</body>
</html>
