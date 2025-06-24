package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import dal.UserDAO;

@WebServlet("/check-verification")
public class CheckVerificationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String inputCode = request.getParameter("code");
        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verification_code");
        String email = (String) session.getAttribute("verification_email");
        String action = (String) session.getAttribute("verification_action");

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            // Xác thực thành công
            session.removeAttribute("verification_code");
            session.setAttribute("email_verified", true);

            // Cập nhật is_verified = 1 cho customer
            try {
                dal.CustomerDAO customerDAO = new dal.CustomerDAO();
                customerDAO.updateIsVerified(email, true);
            } catch (Exception e) {
                request.setAttribute("error", "Lỗi xác thực tài khoản: " + e.getMessage());
                request.getRequestDispatcher("verify.jsp").forward(request, response);
                return;
            }

            // Sau khi xác thực thành công, chuyển về trang login
            request.setAttribute("message", "Tài khoản đã được xác thực. Bạn có thể đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        } else {
            request.setAttribute("error", "Invalid verification code. Please try again.");
            request.getRequestDispatcher("verify.jsp").forward(request, response);
        }
    }
}
