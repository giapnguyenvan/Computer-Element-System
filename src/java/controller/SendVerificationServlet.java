package controller;

import util.EmailUtil;
import jakarta.mail.MessagingException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/send-verification")
public class SendVerificationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String action = request.getParameter("action"); // "register" hoặc "reset"

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
            request.setAttribute("message", "Verification code sent to your email.");
            request.getRequestDispatcher("verify.jsp").forward(request, response);
        } catch (MessagingException e) {
            request.setAttribute("error", "Failed to send email: " + e.getMessage());
            request.getRequestDispatcher("send_email.jsp").forward(request, response);
        }
    }
}
