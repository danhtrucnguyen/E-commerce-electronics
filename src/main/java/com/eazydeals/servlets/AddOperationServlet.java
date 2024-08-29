//package com.eazydeals.servlets;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import jakarta.servlet.http.Part;
//
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.io.InputStream;
//import com.eazydeals.dao.CategoryDao;
//import com.eazydeals.dao.ProductDao;
//import com.eazydeals.entities.Category;
//import com.eazydeals.entities.Message;
//import com.eazydeals.entities.Product;
//import com.eazydeals.helper.ConnectionProvider;
//
//@MultipartConfig
//public class AddOperationServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//
//		String operation = request.getParameter("operation");
//		CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
//		ProductDao pdao = new ProductDao(ConnectionProvider.getConnection());
//		HttpSession session = request.getSession();
//		Message message = null;
//
//		if (operation.trim().equals("addCategory")) {
//
//			String categoryName = request.getParameter("category_name");
//			Part part = request.getPart("category_img");
//			Category category = new Category(categoryName, part.getSubmittedFileName());
//			boolean flag = catDao.saveCategory(category);
//
//			String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
//					+ part.getSubmittedFileName();
//
//			try {
//				FileOutputStream fos = new FileOutputStream(path);
//				InputStream is = part.getInputStream();
//				byte[] data = new byte[is.available()];
//				is.read(data);
//				fos.write(data);
//				fos.flush();
//				fos.close();
//
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//
//			if (flag) {
//				message = new Message("Category added successfully!!", "success", "alert-success");
//			} else {
//				message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
//			}
//			session.setAttribute("message", message);
//			response.sendRedirect("admin.jsp");
//
//		} else if (operation.trim().equals("addProduct")) {
//
//			// add product to database
//			String pName = request.getParameter("name");
//			String pDesc = request.getParameter("description");
//			int pPrice = Integer.parseInt(request.getParameter("price"));
//			int pDiscount = Integer.parseInt(request.getParameter("discount"));
//			if (pDiscount < 0 || pDiscount > 100) {
//				pDiscount = 0;
//			}
//			int pQuantity = Integer.parseInt(request.getParameter("quantity"));
//			Part part = request.getPart("photo");
//			int categoryType = Integer.parseInt(request.getParameter("categoryType"));
//
//			Product product = new Product(pName, pDesc, pPrice, pDiscount, pQuantity, part.getSubmittedFileName(),
//					categoryType);
//			boolean flag = pdao.saveProduct(product);
//
//			String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
//					+ part.getSubmittedFileName();
//			try {
//				FileOutputStream fos = new FileOutputStream(path);
//				InputStream is = part.getInputStream();
//				byte[] data = new byte[is.available()];
//				is.read(data);
//				fos.write(data);
//				fos.flush();
//				fos.close();
//
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			if (flag) {
//				message = new Message("Product added successfully!!", "success", "alert-success");
//			} else {
//				message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
//			}
//			session.setAttribute("message", message);
//			response.sendRedirect("admin.jsp");
//			
//		} else if (operation.trim().equals("updateCategory")) {
//
//			int cid = Integer.parseInt(request.getParameter("cid"));
//			String name = request.getParameter("category_name");
//			Part part = request.getPart("category_img");
//			if (part.getSubmittedFileName().isEmpty()) {
//				String image = request.getParameter("image");
//				Category category = new Category(cid, name, image);
//				catDao.updateCategory(category);
//			} else {
//				Category category = new Category(cid, name, part.getSubmittedFileName());
//				catDao.updateCategory(category);
//				String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
//						+ part.getSubmittedFileName();
//				try {
//					FileOutputStream fos = new FileOutputStream(path);
//					InputStream is = part.getInputStream();
//					byte[] data = new byte[is.available()];
//					is.read(data);
//					fos.write(data);
//					fos.flush();
//					fos.close();
//
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//			message = new Message("Category updated successfully!!", "success", "alert-success");
//			session.setAttribute("message", message);
//			response.sendRedirect("display_category.jsp");
//			
//		} else if (operation.trim().equals("deleteCategory")) {
//
//			int cid = Integer.parseInt(request.getParameter("cid"));
//			catDao.deleteCategory(cid);
//			response.sendRedirect("display_category.jsp");
//
//		} else if (operation.trim().equals("updateProduct")) {
//
//			int pid = Integer.parseInt(request.getParameter("pid"));
//			String name = request.getParameter("name");
//			float price = Float.parseFloat(request.getParameter("price"));
//			String description = request.getParameter("description");
//			int quantity = Integer.parseInt(request.getParameter("quantity"));
//			int discount = Integer.parseInt(request.getParameter("discount"));
//			if (discount < 0 || discount > 100) {
//				discount = 0;
//			}
//			Part part = request.getPart("product_img");
//			int cid = Integer.parseInt(request.getParameter("categoryType"));
//			if (cid == 0) {
//				cid = Integer.parseInt(request.getParameter("category"));
//			}
//			if (part.getSubmittedFileName().isEmpty()) {
//				String image = request.getParameter("image");
//				Product product = new Product(pid, name, description, price, discount, quantity, image, cid);
//				pdao.updateProduct(product);
//			} else {
//
//				Product product = new Product(pid, name, description, price, discount, quantity,
//						part.getSubmittedFileName(), cid);
//				pdao.updateProduct(product);
//				// product image upload
//				String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
//						+ part.getSubmittedFileName();
//				try {
//					FileOutputStream fos = new FileOutputStream(path);
//					InputStream is = part.getInputStream();
//					byte[] data = new byte[is.available()];
//					is.read(data);
//					fos.write(data);
//					fos.flush();
//					fos.close();
//
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//			message = new Message("Product updated successfully!!", "success", "alert-success");
//			session.setAttribute("message", message);
//			response.sendRedirect("display_products.jsp");
//
//		} else if (operation.trim().equals("deleteProduct")) {
//
//			int pid = Integer.parseInt(request.getParameter("pid"));
//			pdao.deleteProduct(pid);
//			response.sendRedirect("display_products.jsp");
//
//		}
//		return;
//	}
//
//	@Override
//	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doPost(req, resp);
//	}
//}
package com.eazydeals.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import com.eazydeals.dao.CategoryDao;
import com.eazydeals.dao.ProductDao;
import com.eazydeals.entities.Category;
import com.eazydeals.entities.Message;
import com.eazydeals.entities.Product;
import com.eazydeals.helper.ConnectionProvider;

@MultipartConfig
public class AddOperationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operation = request.getParameter("operation");
        CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
        ProductDao pdao = new ProductDao(ConnectionProvider.getConnection());
        HttpSession session = request.getSession();
        Message message = null;

        if (operation.trim().equals("addCategory")) {
            String categoryName = request.getParameter("category_name");
            Part part = request.getPart("category_img");

            // Process the image file if it is not null and not empty
            String fileName = part != null ? part.getSubmittedFileName() : null;
            if (fileName != null && !fileName.isEmpty()) {
                String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator + fileName;
                try (FileOutputStream fos = new FileOutputStream(path);
                     InputStream is = part.getInputStream()) {
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            Category category = new Category(categoryName, fileName);
            boolean flag = catDao.saveCategory(category);

            if (flag) {
                message = new Message("Category added successfully!!", "success", "alert-success");
            } else {
                message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
            }
            session.setAttribute("message", message);
            response.sendRedirect("admin.jsp");

        } 
//        else if (operation.trim().equals("addProduct")) {
//            // Add product to database
//            String pName = request.getParameter("name");
//            String pDesc = request.getParameter("description");
//            int pPrice = Integer.parseInt(request.getParameter("price"));
//            int pDiscount = Integer.parseInt(request.getParameter("discount"));
//            if (pDiscount < 0 || pDiscount > 100) {
//                pDiscount = 0;
//            }
//            int pQuantity = Integer.parseInt(request.getParameter("quantity"));
//            Part part = request.getPart("photo");
//
//            String fileName = part != null ? part.getSubmittedFileName() : null;
//            Product product = new Product(pName, pDesc, pPrice, pDiscount, pQuantity, fileName,
//                    Integer.parseInt(request.getParameter("categoryType")));
//
//            boolean flag = pdao.saveProduct(product);
//
//            if (fileName != null && !fileName.isEmpty()) {
//            	String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator + part.getSubmittedFileName();
//                try (FileOutputStream fos = new FileOutputStream(path);
//                     InputStream is = part.getInputStream()) {
//                    byte[] data = new byte[is.available()];
//                    is.read(data);
//                    fos.write(data);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//
//            if (flag) {
//                message = new Message("Product added successfully!!", "success", "alert-success");
//            } else {
//                message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
//            }
//            session.setAttribute("message", message);
//            response.sendRedirect("admin.jsp");
        else if (operation.trim().equals("addProduct")) {
            // Lấy thông tin sản phẩm từ request
            String pName = request.getParameter("name");
            String pDesc = request.getParameter("description");
            int pPrice = Integer.parseInt(request.getParameter("price"));
            int pDiscount = Integer.parseInt(request.getParameter("discount"));
            if (pDiscount < 0 || pDiscount > 100) {
                pDiscount = 0;
            }
            int pQuantity = Integer.parseInt(request.getParameter("quantity"));
            Part part = request.getPart("photo");

            // Xử lý tệp ảnh
            String fileName = part != null ? part.getSubmittedFileName() : null;
            if (fileName != null && !fileName.isEmpty()) {
                String imagePath = "Product_imgs" + File.separator + fileName;
                String path = request.getServletContext().getRealPath("/") + imagePath;
                
                try (FileOutputStream fos = new FileOutputStream(path);
                     InputStream is = part.getInputStream()) {
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                } catch (IOException e) {
                    e.printStackTrace();
                    message = new Message("Lỗi khi lưu ảnh! Thử lại!!", "error", "alert-danger");
                    session.setAttribute("message", message);
                    response.sendRedirect("admin.jsp");
                    return;
                }
            }

            // Tạo sản phẩm và lưu vào cơ sở dữ liệu
            Product product = new Product(pName, pDesc, pPrice, pDiscount, pQuantity, fileName,
                    Integer.parseInt(request.getParameter("categoryType")));
            boolean flag = pdao.saveProduct(product);

            // Thiết lập thông báo thành công hoặc lỗi
            if (flag) {
                message = new Message("Sản phẩm đã được thêm thành công!!", "success", "alert-success");
            } else {
                message = new Message("Có gì đó không đúng! Thử lại!!", "error", "alert-danger");
            }
            session.setAttribute("message", message);
            response.sendRedirect("admin.jsp");
        

        } else if (operation.trim().equals("updateCategory")) {
            int cid = Integer.parseInt(request.getParameter("cid"));
            String name = request.getParameter("category_name");
            Part part = request.getPart("category_img");

            String fileName = part != null ? part.getSubmittedFileName() : null;
            if (fileName != null && !fileName.isEmpty()) {
                String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator + fileName;
                try (FileOutputStream fos = new FileOutputStream(path);
                     InputStream is = part.getInputStream()) {
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                Category category = new Category(cid, name, fileName);
                catDao.updateCategory(category);
            } else {
                String image = request.getParameter("image");
                Category category = new Category(cid, name, image);
                catDao.updateCategory(category);
            }

            message = new Message("Category updated successfully!!", "success", "alert-success");
            session.setAttribute("message", message);
            response.sendRedirect("display_category.jsp");

        } else if (operation.trim().equals("deleteCategory")) {
            int cid = Integer.parseInt(request.getParameter("cid"));
            catDao.deleteCategory(cid);
            response.sendRedirect("display_category.jsp");

        } else if (operation.trim().equals("updateProduct")) {
            int pid = Integer.parseInt(request.getParameter("pid"));
            String name = request.getParameter("name");
            float price = Float.parseFloat(request.getParameter("price"));
            String description = request.getParameter("description");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int discount = Integer.parseInt(request.getParameter("discount"));
            if (discount < 0 || discount > 100) {
                discount = 0;
            }
            Part part = request.getPart("product_img");
            int cid = Integer.parseInt(request.getParameter("categoryType"));
            if (cid == 0) {
                cid = Integer.parseInt(request.getParameter("category"));
            }

            String fileName = part != null ? part.getSubmittedFileName() : null;
            if (fileName != null && !fileName.isEmpty()) {
                Product product = new Product(pid, name, description, price, discount, quantity, fileName, cid);
                pdao.updateProduct(product);

                String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator + fileName;
                try (FileOutputStream fos = new FileOutputStream(path);
                     InputStream is = part.getInputStream()) {
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                String image = request.getParameter("image");
                Product product = new Product(pid, name, description, price, discount, quantity, image, cid);
                pdao.updateProduct(product);
            }

            message = new Message("Product updated successfully!!", "success", "alert-success");
            session.setAttribute("message", message);
            response.sendRedirect("display_products.jsp");

        } else if (operation.trim().equals("deleteProduct")) {
            int pid = Integer.parseInt(request.getParameter("pid"));
            pdao.deleteProduct(pid);
            response.sendRedirect("display_products.jsp");

        }
        return;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
