package controller;

import dal.UserDAO;
import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import model.User;
import model.Customer;
import util.EmailUtil;

@WebServlet(name = "ForgetPasswordServlet", urlPatterns = {"/forget-password"})
public class ForgetPasswordServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forget_password.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("verify".equals(action)) {
            // Xử lý xác minh mã và đặt lại mật khẩu
            String inputCode = request.getParameter("code");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            String sessionCode = (String) request.getSession().getAttribute("reset_verification_code");
            String email = (String) request.getSession().getAttribute("reset_verification_email");
            String accountType = (String) request.getSession().getAttribute("reset_account_type");

            if (inputCode == null || !inputCode.equals(sessionCode)) {
                request.setAttribute("error", "Verification code is incorrect!");
                request.getRequestDispatcher("verify_reset.jsp").forward(request, response);
                return;
            }
            if (newPassword == null || newPassword.length() < 8) {
                request.setAttribute("error", "Password must be at least 8 characters.");
                request.getRequestDispatcher("verify_reset.jsp").forward(request, response);
                return;
            }
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Password confirmation does not match.");
                request.getRequestDispatcher("verify_reset.jsp").forward(request, response);
                return;
            }
            try {
                boolean updated = false;
                if ("user".equals(accountType)) {
                    UserDAO userDAO = UserDAO.getInstance();
                    User user = userDAO.getUserByEmail(email);
                    if (user != null) {
                        updated = userDAO.updatePassword(email, newPassword);
                    }
                } else if ("customer".equals(accountType)) {
                    CustomerDAO customerDAO = new CustomerDAO();
                    Customer customer = customerDAO.getCustomerByEmail(email);
                    if (customer != null) {
                        updated = customerDAO.updatePassword(email, newPassword);
                    }
                }
                if (updated) {
                    // Xóa session code sau khi thành công
                    request.getSession().removeAttribute("reset_verification_code");
                    request.getSession().removeAttribute("reset_verification_email");
                    request.getSession().removeAttribute("reset_account_type");
                    request.setAttribute("success", "Your password has been reset successfully. Please login with your new password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Could not update password. Please try again.");
                    request.getRequestDispatcher("verify_reset.jsp").forward(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("error", "System error: " + e.getMessage());
                request.getRequestDispatcher("verify_reset.jsp").forward(request, response);
            }
            return;
        }
        String email = request.getParameter("email");
        try {
            UserDAO userDAO = UserDAO.getInstance();
            CustomerDAO customerDAO = new CustomerDAO();
            User user = null;
            Customer customer = null;
            boolean isUser = false, isCustomer = false;
            try { user = userDAO.getUserByEmail(email); isUser = (user != null); } catch (Exception ignore) {}
            try { customer = customerDAO.getCustomerByEmail(email); isCustomer = (customer != null); } catch (Exception ignore) {}

            if (isUser || isCustomer) {
                String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
                try {
                    EmailUtil.sendVerificationEmail(email, verificationCode);
                    request.getSession().setAttribute("reset_verification_code", verificationCode);
                    request.getSession().setAttribute("reset_verification_email", email);
                    request.getSession().setAttribute("reset_account_type", isUser ? "user" : "customer");
                    request.setAttribute("message", "A verification code has been sent to your email. Please enter the code to reset your password.");
                } catch (Exception ex) {
                    request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
                    request.getRequestDispatcher("forget_password.jsp").forward(request, response);
                    return;
                }
                request.getRequestDispatcher("verify_reset.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Email is incorrect or does not exist!");
                request.getRequestDispatcher("forget_password.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("forget_password.jsp").forward(request, response);
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