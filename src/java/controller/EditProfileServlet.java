package controller;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
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

        if ("editEmail".equals(action)) {
            String newEmail = request.getParameter("newEmail");
            // Send confirmation to current email
            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
            try {
                EmailUtil.sendVerificationEmail(email, verificationCode);
                session.setAttribute("pending_new_email", newEmail);
                session.setAttribute("verification_code", verificationCode);
                request.setAttribute("message", "A confirmation code has been sent to your current email. Please check your inbox.");
            } catch (Exception ex) {
                request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
            }
            // Forward back to profile page
            request.getRequestDispatcher("userprofile?action=profile").forward(request, response);
        }
    }
}