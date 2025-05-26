package controller;

import dao.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Users;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            // Lấy thông tin từ form
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Kiểm tra mật khẩu xác nhận
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Lấy kết nối từ DBContext singleton
            conn = DBContext.getInstance().getConnection();
            
            // Kiểm tra username đã tồn tại chưa
            String checkUser = "SELECT username FROM Users WHERE username = ?";
            checkStmt = conn.prepareStatement(checkUser);
            checkStmt.setString(1, username);
            rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Thêm người dùng mới
            String sql = "INSERT INTO Users (username, password, role, fullname, email, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
            insertStmt = conn.prepareStatement(sql);
            insertStmt.setString(1, username);
            insertStmt.setString(2, password);
            insertStmt.setString(3, "user"); // Mặc định role là "user"
            insertStmt.setString(4, fullname);
            insertStmt.setString(5, email);
            insertStmt.setString(6, phone);
            insertStmt.setString(7, address);
            
            int rowsAffected = insertStmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Đăng ký thành công
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Đăng ký thất bại!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        } finally {
            // Đóng tất cả các resource theo thứ tự ngược lại
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (insertStmt != null) insertStmt.close();
                // Không đóng connection ở đây vì nó được quản lý bởi DBContext singleton
            } catch (SQLException e) {
                System.out.println("Lỗi khi đóng resources: " + e.getMessage());
            }
        }
    }
} 