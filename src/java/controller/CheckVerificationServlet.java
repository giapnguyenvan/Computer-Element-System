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
                    // Xác thực thành công, lưu thông tin để hiển thị popup
                    session.setAttribute("verification_success", true);
                    session.setAttribute("verified_email", email);
                    
                    // Chuyển hướng đến trang login với thông báo thành công
                    response.sendRedirect("login.jsp?verification=success&email=" + java.net.URLEncoder.encode(email, "UTF-8"));
                    return;
                } else {
                    request.setAttribute("error", "Cannot update verification status. Please try again.");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                request.setAttribute("error", "Account verification error: " + e.getMessage());
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
        } else {
            // Mã xác thực không đúng
            request.setAttribute("error", "Invalid verification code. Please check again.");
            request.setAttribute("showVerificationPopup", true);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
}
