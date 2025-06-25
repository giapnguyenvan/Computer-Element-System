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
                request.setAttribute("error", "Password confirmation does not match!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            CustomerDAO customerDAO = new CustomerDAO();
            // Kiểm tra email đã tồn tại chưa
            if (customerDAO.isEmailExists(email)) {
                // Kiểm tra xem email có tồn tại nhưng chưa xác thực không
                if (customerDAO.isEmailExistsButNotVerified(email)) {
                    // Cập nhật thông tin customer chưa xác thực thay vì tạo mới
                    try {
                        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                        boolean updateSuccess = customerDAO.updateCustomerInfo(email, fullname, phone, address, hashedPassword);
                        
                        if (updateSuccess) {
                            // Gửi mã xác thực qua email
                            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
                            try {
                                EmailUtil.sendVerificationEmail(email, verificationCode);
                                // Lưu mã xác thực vào session để kiểm tra sau
                                request.getSession().setAttribute("verification_code", verificationCode);
                                request.getSession().setAttribute("verification_email", email);
                                request.setAttribute("showVerificationPopup", true);
                                request.setAttribute("registerMessage", "Information has been updated. Please check your email to verify your account!");
                            } catch (Exception ex) {
                                request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
                            }
                        } else {
                            request.setAttribute("error", "Cannot update account information. Please try again.");
                        }
                    } catch (SQLException e) {
                        request.setAttribute("error", "Error updating information: " + e.getMessage());
                    }
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("error", "Email is already in use!");
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
                    request.setAttribute("registerMessage", "Please check your email to verify your account!");
                } catch (Exception ex) {
                    request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
                }
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            } catch (SQLException e) {
                // Kiểm tra xem có phải lỗi duplicate key không
                if (e.getMessage().contains("Duplicate entry") && e.getMessage().contains("customer.email")) {
                    // Email đã tồn tại, kiểm tra lại trạng thái
                    try {
                        if (customerDAO.isEmailExistsButNotVerified(email)) {
                            request.setAttribute("error", "Please confirm your email address to activate your account");
                            request.setAttribute("showVerificationPopup", true);
                        } else {
                            request.setAttribute("error", "Email is already in use!");
                        }
                    } catch (SQLException checkEx) {
                        request.setAttribute("error", "Email is already in use!");
                    }
                } else {
                    request.setAttribute("error", "Registration failed: " + e.getMessage());
                }
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }
            return;
            
        } catch (SQLException e) {
            request.setAttribute("error", "System error: " + e.getMessage());
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
} 