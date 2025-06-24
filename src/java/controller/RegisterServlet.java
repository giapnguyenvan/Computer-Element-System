package controller;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import model.Customer;
import org.springframework.security.crypto.bcrypt.BCrypt;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Register.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

            CustomerDAO customerDAO = new CustomerDAO();
            // Kiểm tra email đã tồn tại chưa
            if (customerDAO.isEmailExists(email)) {
                request.setAttribute("error", "Email đã được sử dụng!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            // Tạo đối tượng Customer mới
            Customer newCustomer = new Customer(0, 0, fullname, phone, address);
            newCustomer.setEmail(email);
            // Mã hóa mật khẩu trước khi lưu
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            newCustomer.setPassword(hashedPassword);
            // Thực hiện đăng ký với is_verified = 0
            String sql = "INSERT INTO Customer (name, email, password, phone, shipping_address) VALUES (?, ?, ?, ?, ?)";
            try (java.sql.Connection conn = dal.DBContext.getInstance().getConnection();
                 java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, fullname);
                stmt.setString(2, email);
                stmt.setString(3, hashedPassword);
                stmt.setString(4, phone);
                stmt.setString(5, address);
                if (stmt.executeUpdate() > 0) {
                    // Gửi mã xác thực qua email
                    String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
                    try {
                        shop.utils.EmailUtil.sendVerificationEmail(email, verificationCode);
                        // Lưu mã xác thực vào session để kiểm tra sau
                        request.getSession().setAttribute("verification_code", verificationCode);
                        request.getSession().setAttribute("verification_email", email);
                        request.setAttribute("showVerificationPopup", true);
                        request.setAttribute("registerMessage", "Vui lòng kiểm tra email để xác thực tài khoản!");
                    } catch (Exception ex) {
                        request.setAttribute("error", "Không thể gửi email xác thực: " + ex.getMessage());
                    }
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Đăng ký thất bại!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                }
            }
            return;
            
        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
} 