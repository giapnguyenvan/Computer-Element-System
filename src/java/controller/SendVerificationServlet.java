package controller;

import util.EmailUtil;
import jakarta.mail.MessagingException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Random;
import dal.CustomerDAO;
import java.sql.SQLException;

@WebServlet("/send-verification")
public class SendVerificationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String action = request.getParameter("action"); // "register" hoặc "resend"

        // Kiểm tra email có tồn tại và chưa xác thực không
        try {
            CustomerDAO customerDAO = new CustomerDAO();
            if (!customerDAO.isEmailExistsButNotVerified(email)) {
                response.setContentType("text/plain");
                response.getWriter().write("Email not found or already verified");
                return;
            }
        } catch (SQLException e) {
            response.setContentType("text/plain");
            response.getWriter().write("Database error: " + e.getMessage());
            return;
        }

        // Sinh mã xác thực 6 số ngẫu nhiên
        String verificationCode = String.format("%06d", new Random().nextInt(1000000));

        // Lưu vào session để kiểm tra sau
        HttpSession session = request.getSession();
        session.setAttribute("verification_code", verificationCode);
        session.setAttribute("verification_email", email);
        session.setAttribute("verification_action", action);

        try {
            // Gửi email với mã xác thực 6 số
            EmailUtil.sendVerificationEmail(email, verificationCode);
            
            // Trả về response cho AJAX
            response.setContentType("text/plain");
            response.getWriter().write("success");
        } catch (MessagingException e) {
            response.setContentType("text/plain");
            response.getWriter().write("Failed to send email: " + e.getMessage());
        }
    }
}
