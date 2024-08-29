<%@page import="com.eazydeals.entities.Message"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<head><meta charset="UTF-8">
<title>Cập Nhật Danh Mục</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
    <!--navbar -->
    <%@include file="Components/navbarAdmin.jsp"%>

    <!-- update category -->
    <%
    int cid = Integer.parseInt(request.getParameter("cid"));
    Category category = catDao.getCategoryById(cid);
    %>
    <div class="container mt-5">
        <div class="row row-cols-1 row-cols-md-1 offset-md-2">
            <div class="col">
                <div class="card w-75">
                    <div class="card-header text-center">
                        <h3>Chỉnh Sửa Danh Mục</h3>
                    </div>
                    <form action="AddOperationServlet?cid=<%=cid%>" method="post" enctype="multipart/form-data">
                        <div class="card-body">
                            <input type="hidden" name="operation" value="updateCategory">
                            <div class="mb-3">
                                <label class="form-label"><b>Tên Danh Mục</b></label>
                                <input type="text" name="category_name" value="<%=category.getCategoryName()%>" class="form-control">
                            </div>
                            <div class="mb-3">
                                <label class="form-label"><b>Hình Ảnh Danh Mục</b></label>
                                <input class="form-control" type="file" name="category_img">
                            </div>
                            <div class="mb-3">
                                <label class="form-label"><b>Hình Ảnh Đã Tải Lên:&nbsp;</b></label>
                                <%=category.getCategoryImage()%>&emsp;
                                <img src="Product_imgs/<%=category.getCategoryImage()%>" style="width: 80px; height: 80px; width: auto;">
                                <input type="hidden" name="image" value="<%=category.getCategoryImage()%>">
                            </div>
                        </div>
                        <div class="card-footer text-center">
                            <button type="submit" class="btn btn-lg btn-primary me-3">Cập Nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- end-->
</body>
</html>
