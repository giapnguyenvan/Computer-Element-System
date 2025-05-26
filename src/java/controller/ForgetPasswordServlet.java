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

@WebServlet(name = "ForgetPasswordServlet", urlPatterns = {"/forget-password"})
public class ForgetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forget_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getInstance().getConnection();

            // Kiểm tra username và email có khớp không
            String checkQuery = "SELECT * FROM Users WHERE username = ? AND email = ?";
            checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, username);
            checkStmt.setString(2, email);
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Tạo mật khẩu mới ngẫu nhiên
                String newPassword = generateRandomPassword();
                
                // Cập nhật mật khẩu mới vào database
                String updateQuery = "UPDATE Users SET password = ? WHERE username = ?";
                updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, newPassword);
                updateStmt.setString(2, username);
                
                if (updateStmt.executeUpdate() > 0) {
                    // Gửi mật khẩu mới qua email (trong thực tế)
                    // TODO: Implement email sending functionality
                    
                    // Hiển thị mật khẩu mới (chỉ để demo, không nên làm trong thực tế)
                    request.setAttribute("success", "Mật khẩu mới của bạn là: " + newPassword);
                    request.getRequestDispatcher("forget_password.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không thể cập nhật mật khẩu!");
                    request.getRequestDispatcher("forget_password.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Tên đăng nhập hoặc email không đúng!");
                request.getRequestDispatcher("forget_password.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("forget_password.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (updateStmt != null) updateStmt.close();
            } catch (SQLException e) {
                System.out.println("Lỗi khi đóng resources: " + e.getMessage());
            }
        }
    }
    
    private String generateRandomPassword() {
        // Tạo mật khẩu ngẫu nhiên 8 ký tự
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            int index = (int) (chars.length() * Math.random());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
} 