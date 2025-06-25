package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import dal.CustomerDAO;
import java.sql.SQLException;

@WebServlet("/check-verification")
public class CheckVerificationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String inputCode = request.getParameter("code");
        HttpSession session = request.getSession();
        String sessionCode = (String) session.getAttribute("verification_code");
        String email = (String) session.getAttribute("verification_email");

        if (sessionCode != null && sessionCode.equals(inputCode)) {
            // Xác thực thành công
            session.removeAttribute("verification_code");
            session.removeAttribute("verification_email");
            session.setAttribute("email_verified", true);

            // Cập nhật is_verified = 1 cho customer
            try {
                CustomerDAO customerDAO = new CustomerDAO();
                boolean updateSuccess = customerDAO.updateIsVerified(email, true);
                
                if (updateSuccess) {
                    // Xác thực thành công, chuyển về trang login
                    session.setAttribute("successMessage", "Tài khoản đã được xác thực thành công! Bạn có thể đăng nhập ngay bây giờ.");
                    response.sendRedirect("login.jsp");
                    return;
                } else {
                    request.setAttribute("error", "Không thể cập nhật trạng thái xác thực. Vui lòng thử lại.");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                request.setAttribute("error", "Lỗi xác thực tài khoản: " + e.getMessage());
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
        } else {
            // Mã xác thực không đúng
            request.setAttribute("error", "Mã xác thực không đúng. Vui lòng kiểm tra lại.");
            request.setAttribute("showVerificationPopup", true);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
}
