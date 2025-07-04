package controller;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import model.Customer;
import util.EmailUtil;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/editProfile"})
public class EditProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("session_login");
        String action = request.getParameter("action");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if ("editEmail".equals(action)) {
            String newEmail = request.getParameter("newEmail");
            // Generate and send verification code to current email
            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
            try {
                EmailUtil.sendVerificationEmail(email, verificationCode);
                session.setAttribute("pending_new_email", newEmail);
                session.setAttribute("verification_code", verificationCode);
                out.print("{\"success\":true}");
            } catch (Exception ex) {
                out.print("{\"success\":false,\"error\":\"Không thể gửi email xác nhận: " + ex.getMessage() + "\"}");
            }
            return;
        }

        if ("verifyEmailToken".equals(action)) {
            String token = request.getParameter("token");
            String code = (String) session.getAttribute("verification_code");
            String newEmail = (String) session.getAttribute("pending_new_email");
            if (code != null && code.equals(token) && newEmail != null) {
                try {
                    CustomerDAO dao = new CustomerDAO();
                    dao.updateEmail(email, newEmail);
                    session.setAttribute("session_login", newEmail); // update session
                    session.removeAttribute("verification_code");
                    session.removeAttribute("pending_new_email");
                    out.print("{\"success\":true}");
                } catch (Exception ex) {
                    out.print("{\"success\":false,\"error\":\"Không thể cập nhật email: " + ex.getMessage() + "\"}");
                }
            } else {
                out.print("{\"success\":false,\"error\":\"Mã xác nhận không đúng hoặc đã hết hạn.\"}");
            }
            return;
        }

        if ("editPhone".equals(action)) {
            String newPhone = request.getParameter("newPhone");
            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
            try {
                // Send verification code to user's email (not SMS)
                EmailUtil.sendVerificationEmail(email, verificationCode);
                session.setAttribute("pending_new_phone", newPhone);
                session.setAttribute("phone_verification_code", verificationCode);
                out.print("{\"success\":true}");
            } catch (Exception ex) {
                out.print("{\"success\":false,\"error\":\"Không thể gửi email xác nhận: " + ex.getMessage() + "\"}");
            }
            return;
        }

        if ("verifyPhoneToken".equals(action)) {
            String token = request.getParameter("token");
            String code = (String) session.getAttribute("phone_verification_code");
            String newPhone = (String) session.getAttribute("pending_new_phone");
            if (code != null && code.equals(token) && newPhone != null) {
                try {
                    CustomerDAO dao = new CustomerDAO();
                    dao.updatePhone(email, newPhone);
                    // Optionally update session attribute if you store phone in session
                    session.removeAttribute("phone_verification_code");
                    session.removeAttribute("pending_new_phone");
                    out.print("{\"success\":true}");
                } catch (Exception ex) {
                    out.print("{\"success\":false,\"error\":\"Không thể cập nhật số điện thoại: " + ex.getMessage() + "\"}");
                }
            } else {
                out.print("{\"success\":false,\"error\":\"Mã xác nhận không đúng hoặc đã hết hạn.\"}");
            }
            return;
        }
    }
}