<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.eazydeals.entities.Admin"%>
<%@page import="com.eazydeals.entities.Cart"%>
<%@page import="com.eazydeals.dao.CartDao"%>
<%@page import="com.eazydeals.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.entities.Category"%>
<%@page import="com.eazydeals.helper.ConnectionProvider"%>
<%@page import="com.eazydeals.dao.CategoryDao"%>

<%
User user = (User) session.getAttribute("activeUser");
Admin admin = (Admin) session.getAttribute("activeAdmin");

CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
List<Category> categoryList = catDao.getAllCategories();
%>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">


<!-- navbar.jsp -->
<style>
.navbar-nav {
	display: flex;
	align-items: center;
}

.nav-link {
	color: #fff;
	display: flex;
	align-items: center;
}

.badge {
	position: absolute; /* Để định vị badge dựa trên icon */
	bottom: 5px; /* Đặt ở góc dưới cùng của icon */
	right: 10px; /* Đặt ở góc phải của icon */
	transform: translate(-20%, -50%);
	/* Điều chỉnh vị trí của badge để nó sát vào góc dưới bên phải của icon */
	padding: 0.2rem 0.4rem; /* Kích thước của badge */
	background-color: #dc3545; /* Màu nền của badge */
	color: #fff; /* Màu chữ của badge */
}

.cart-icon {
	position: relative;
	/* Để badge được định vị dựa trên biểu tượng giỏ hàng */
}

.menu-bar {
	background-color: #17a2b8; /* Adjusted for visibility */
}

.menu-bar .nav-item {
	margin: 0; /* Reset margin to align items properly */
}

.navbar-brand {
	margin-right: auto; /* Align "BETSHOP" to the left */
}

.menu-bar {
	background-color: #17a2b8; /* Adjusted for visibility */
}

.menu-bar .nav-item {
	margin: 0; /* Reset margin to align items properly */
}

.navbar-brand {
	margin-right: auto; /* Align "BETSHOP" to the left */
}

.menu-bar .nav-link {
	position: relative;
}

.menu-bar .dropdown-menu {
	background-color: #17a2b8;
	border: none;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.menu-bar .dropdown-item {
	color: #fff;
}

.menu-bar .dropdown-item:hover {
	background-color: #138496; /* Change color on hover */
	color: #fff;
}

.menu-bar .dropdown-toggle::after {
	/*content: '\f078'; /* FontAwesome down arrow */
	font-family: 'Font Awesome 5 Free'; /* Specify FontAwesome font */
	font-weight: 900; /* Use solid style */
	margin-left: 0.5rem; /* Space between text and arrow */
}

@media ( max-width : 991.98px) {
	.navbar-nav {
		flex-direction: column;
		text-align: left; /* Align dropdown items to the left */
		width: 100%;
	}
	.navbar-nav .nav-item {
		margin: 5px 0;
	}
	.menu-bar .dropdown-menu {
		position: absolute; /* Ensure dropdown menu is positioned absolutely */
		top: 100%; /* Align dropdown to the bottom of the button */
		left: 0; /* Align dropdown to the left edge */
		right: auto; /* Prevent the dropdown from aligning to the right */
		width: 100%;
		/* Make sure dropdown menu spans the width of its container */
	}
}

.menu-bar .d-none.d-lg-flex {
	justify-content: flex-start;
	/* Align items to the left for large screens */
}
</style>
</head>
<body>
	<div class="container-fluid p-0">
		<!-- Top Bar -->
		<div
			class="bg-dark text-white py-4 d-flex justify-content-between align-items-center"
			style="padding: 0px 150px;">
			<div class="d-flex align-items-center">
				<a href="mailto:support@sapo.vn" class="text-white mr-3"> <i
					class="fas fa-envelope"></i> support@sapo.vn
				</a> <a href="tel:19006750" class="text-white"> <i
					class="fas fa-phone"></i> 1900 6750
				</a>
			</div>
			<%
			if (user == null) {
			%>
			<div class="d-flex align-items-center">
				<a href="register.jsp" class="text-white mr-3">ĐĂNG KÝ</a> <span
					class="divider"
					style="display: inline-block; width: 1px; height: 20px;  background-color: #fff; margin: 0 10px;"></span>
				<a href="login.jsp" class="text-white">ĐĂNG NHẬP</a>
			</div>
			<%
			} else {
			%>
			<div class="d-flex align-items-center">
				<a href="profile.jsp" class="text-white mr-3"><%=user.getUserName()%></a>
				<span
					class="divider"
					style="display: inline-block; width: 1px; height: 20px;  background-color: #fff; margin: 0 10px;"></span>
				<a href="LogoutServlet?user=user" class="text-white">ĐĂNG XUẤT</a>
			</div>
			<%
			}
			%>
		</div>

		<!-- Main Navbar -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-secondary"
			style="padding: 20px 150px;">
			<a class="navbar-brand" href="#">BETSHOP</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<form class="form-inline mx-auto" role="search"
					action="products.jsp">
					<input name="search" class="form-control mr-sm-2" type="search"
						placeholder="Tìm kiếm" aria-label="Search" style="width: 500px;">
					<button class="btn btn-primary my-2 my-sm-0" type="submit">Tìm
						kiếm</button>
				</form>
				<%
				if (user != null) {
					CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
					int cartCount = cartDao.getCartCountByUserId(user.getUserId());
				%>
				<div class="navbar-nav">
					<a class="nav-item nav-link text-white" href="wishlist.jsp"><i
						class="fas fa-heart"></i></a>
					<li class="nav-item active pe-3"><a
						class="nav-link position-relative d-flex align-items-center"
						aria-current="page" href="cart.jsp"> <i
							class="fas fa-shopping-cart cart-icon" style="color: #ffffff;"></i>
							<span class="position-relative ms-2 badge rounded-pill bg-danger">
								<%=cartCount%>
						</span> <span class="ms-2">Giỏ hàng</span>
					</a></li>
				</div>
				<%
				}
				%>

			</div>
		</nav>

		<!-- Menu Bar -->
		<div class="menu-bar">
			<div class="container">
				<div class="d-flex align-items-center py-2">
					<!-- Menu Items for Large Screens -->
					<div class="d-none d-lg-flex">
						<a class="nav-item nav-link text-white px-3" href="index.jsp">Trang
							chủ</a> <a class="nav-item nav-link text-white px-3" href="#">Giới
							thiệu</a> <a
							class="nav-item nav-link text-white px-3 dropdown-toggle"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">Danh
							mục</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="products.jsp?category=0">
									Tất cả sản phẩm</a></li>
							<%
							for (Category c : categoryList) {
							%>
							<li><a class="dropdown-item"
								href="products.jsp?category=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a></li>
							<%
							}
							%>
						</ul>

						<a class="nav-item nav-link text-white px-3" href="products.jsp">Sản
							phẩm</a> <a class="nav-item nav-link text-white px-3" href="#">Tin
							tức</a> <a class="nav-item nav-link text-white px-3" href="#">Liên
							hệ</a>
					</div>
					<!-- Dropdown Menu for Mobile -->
					<div class="d-lg-none">
						<div class="dropdown">
							<button class="btn btn-info dropdown-bs-toggle" type="button"
								id="dropdownMenuButton" data-bs-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false">Menu</button>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
								<a class="dropdown-item" href="#">Trang chủ</a> <a
									class="dropdown-item" href="#">Giới thiệu</a> <a
									class="dropdown-item" href="#">Sản phẩm</a> <a
									class="dropdown-item" href="#">Tin tức</a> <a
									class="dropdown-item" href="#">Liên hệ</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Include Bootstrap JS and dependencies in the footer of your main JSP or HTML file -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>