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


<style>
    .navbar {
        background-color: #17a2b8;
        font-weight: 800;
    }

    .navbar-brand {
        color: #f8f9fa !important;
    }

    .navbar-toggler {
        border-color: #f8f9fa;
    }

    .navbar-toggler-icon {
        color: #f8f9fa;
    }

    .nav-link {
        color: #f8f9fa !important;
    }

    .nav-link:hover {
        color: #ffc107 !important;
    }

    .dropdown-menu {
        background-color: #ffffff !important;
        border-color: #ffc107;
    }

    .dropdown-menu li a {
        color: #333 !important;
    }

    .dropdown-menu li a:hover {
        background-color: #ffc107 !important;
        color: #ffffff !important;
    }

    .btn-outline-light {
        color: #f8f9fa;
        border-color: #f8f9fa;
    }

    .btn-outline-light:hover {
        background-color: #ffc107;
        border-color: #ffc107;
    }

    .badge {
        background-color: #dc3545;
    }

    .fa-solid {
        color: #f8f9fa;
    }
</style>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="<%= admin != null ? "admin.jsp" : "index.jsp" %>">
            <i class="fa-sharp fa-solid fa-house"></i>&ensp;Electronics
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"><i class="fa fa-bars"></i></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <% if (admin != null) { %>
                <!-- Admin Navbar -->
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <button type="button" class="btn nav-link" data-bs-toggle="modal" data-bs-target="#add-category">
                            <i class="fa-solid fa-plus fa-xs"></i> Thêm danh mục
                        </button>
                    </li>
                    <li class="nav-item">
                        <button type="button" class="btn nav-link" data-bs-toggle="modal" data-bs-target="#add-product">
                            <i class="fa-solid fa-plus fa-xs"></i> Thêm sản phẩm
                        </button>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin.jsp"><%= admin.getName() %></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet?user=admin">
                            <i class="fa-solid fa-user-slash fa-sm"></i>&nbsp;Đăng xuất
                        </a>
                    </li>
                </ul>
            <% } else { %>
                <!-- User and General Navbar -->
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="products.jsp">Sản phẩm</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Danh mục
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="products.jsp?category=0">Tất cả sản phẩm</a></li>
                            <% for (Category c : categoryList) { %>
                                <li><a class="dropdown-item" href="products.jsp?category=<%= c.getCategoryId() %>"><%= c.getCategoryName() %></a></li>
                            <% } %>
                        </ul>
                    </li>
                </ul>
                <form class="d-flex pe-5" role="search" action="products.jsp" method="get">
                    <input name="search" class="form-control me-2" type="search" placeholder="Search for products" aria-label="Search" size="50">
                    <button class="btn btn-outline-light" type="submit" style="width: 110px;">Tìm kiếm</button>
                </form>

                <% if (user != null) {
                    CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                    int cartCount = cartDao.getCartCountByUserId(user.getUserId());
                %>
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="cart.jsp">
                                <i class="fa-solid fa-cart-shopping"></i>&nbsp;Cart
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill">
                                    <%= cartCount %>
                                </span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="profile.jsp"><%= user.getUserName() %></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LogoutServlet?user=user">
                                <i class="fa-solid fa-user-slash"></i>&nbsp;Đăng xuất
                            </a>
                        </li>
                    </ul>
                <% } else { %>
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="register.jsp">
                                <i class="fa-solid fa-user-plus"></i>&nbsp;Đăng ký
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">
                                <i class="fa-solid fa-user-lock"></i>&nbsp;Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="adminlogin.jsp">Admin</a>
                        </li>
                    </ul>
                <% } %>
            <% } %>
        </div>
    </div>
</nav>
