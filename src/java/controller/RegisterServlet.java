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
import util.EmailUtil;

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
                // Kiểm tra xem email có tồn tại nhưng chưa xác thực không
                if (customerDAO.isEmailExistsButNotVerified(email)) {
                    request.setAttribute("error", "Please confirm your email address to activate your account");
                    request.getRequestDispatcher("verify.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("error", "Email đã được sử dụng!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
            }
            // Tạo đối tượng Customer mới
            Customer newCustomer = new Customer(0, 0, fullname, phone, address);
            newCustomer.setEmail(email);
            // Mã hóa mật khẩu trước khi lưu
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            newCustomer.setPassword(hashedPassword);
            
            // Thực hiện đăng ký thông qua CustomerDAO
            try {
                customerDAO.addCustomerWithEmail(newCustomer, hashedPassword);
                // Gửi mã xác thực qua email
                String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
                try {
                    EmailUtil.sendVerificationEmail(email, verificationCode);
                    // Lưu mã xác thực vào session để kiểm tra sau
                    request.getSession().setAttribute("verification_code", verificationCode);
                    request.getSession().setAttribute("verification_email", email);
                    request.setAttribute("showVerificationPopup", true);
                    request.setAttribute("registerMessage", "Vui lòng kiểm tra email để xác thực tài khoản!");
                } catch (Exception ex) {
                    request.setAttribute("error", "Không thể gửi email xác thực: " + ex.getMessage());
                }
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            } catch (SQLException e) {
                request.setAttribute("error", "Đăng ký thất bại: " + e.getMessage());
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }
            return;
            
        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
} 