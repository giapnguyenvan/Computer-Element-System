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
                out.print("{\"success\":false,\"error\":\"Unable to send verification email: " + ex.getMessage() + "\"}");
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
                    out.print("{\"success\":false,\"error\":\"Unable to update email: " + ex.getMessage() + "\"}");
                }
            } else {
                out.print("{\"success\":false,\"error\":\"Verification code is incorrect or has expired.\"}");
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
                out.print("{\"success\":false,\"error\":\"Unable to send verification email: " + ex.getMessage() + "\"}");
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
                    out.print("{\"success\":false,\"error\":\"Unable to update phone number: " + ex.getMessage() + "\"}");
                }
            } else {
                out.print("{\"success\":false,\"error\":\"Verification code is incorrect or has expired.\"}");
            }
            return;
        }

        if ("editName".equals(action)) {
            String newName = request.getParameter("newName");

            if (newName == null || newName.trim().isEmpty()) {
                out.print("{\"success\":false,\"error\":\"Name cannot be empty.\"}");
                return;
            }

            try {
                CustomerDAO dao = new CustomerDAO();
                dao.updateName(email, newName);

                // Update session info if you store full Customer object
                Customer currentUser = (Customer) session.getAttribute("customerAuth");
                if (currentUser != null) {
                    currentUser.setName(newName);
                    session.setAttribute("customerAuth", currentUser);
                }

                out.print("{\"success\":true}");
            } catch (Exception ex) {
                out.print("{\"success\":false,\"error\":\"Unable to update name: " + ex.getMessage() + "\"}");
            }
            return;
        }

        if ("initiatePasswordChange".equals(action)) {
            String newPassword = request.getParameter("newPassword");
            if (newPassword == null || newPassword.length() < 8) {
                out.print("{\"success\":false,\"error\":\"Password must be at least 8 characters long.\"}");
                return;
            }
            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
            session.setAttribute("pending_new_password", newPassword);
            session.setAttribute("password_verification_code", verificationCode);
            try {
                EmailUtil.sendVerificationEmail(email, verificationCode);
                out.print("{\"success\":true}");
            } catch (Exception ex) {
                out.print("{\"success\":false,\"error\":\"Unable to send verification email: " + ex.getMessage() + "\"}");
            }
            return;
        }

        if ("verifyPasswordToken".equals(action)) {
            String token = request.getParameter("token");
            String code = (String) session.getAttribute("password_verification_code");
            String newPassword = (String) session.getAttribute("pending_new_password");
            if (code != null && code.equals(token) && newPassword != null) {
                try {
                    CustomerDAO dao = new CustomerDAO();
                    dao.updatePassword(email, newPassword);
                    session.removeAttribute("password_verification_code");
                    session.removeAttribute("pending_new_password");
                    out.print("{\"success\":true}");
                } catch (Exception ex) {
                    out.print("{\"success\":false,\"error\":\"Unable to update password: " + ex.getMessage() + "\"}");
                }
            } else {
                out.print("{\"success\":false,\"error\":\"Verification code is incorrect or has expired.\"}");
            }
            return;
        }

        if ("editGender".equals(action)) {
            String newGender = request.getParameter("newGender");

            if (newGender == null || newGender.trim().isEmpty()) {
                out.print("{\"success\":false,\"error\":\"Gender cannot be empty.\"}");
                return;
            }

            try {
                CustomerDAO dao = new CustomerDAO();
                dao.updateGender(email, newGender); // ⬅️ call your DAO method

                // Update session info
                Customer currentUser = (Customer) session.getAttribute("customerAuth");
                if (currentUser != null) {
                    currentUser.setGender(newGender);
                    session.setAttribute("customerAuth", currentUser);
                }

                out.print("{\"success\":true}");
            } catch (Exception ex) {
                out.print("{\"success\":false,\"error\":\"Unable to update gender: " + ex.getMessage() + "\"}");
            }
            return;
        }

        if ("editDoB".equals(action)) {
            String newDoB = request.getParameter("newDoB");
            if (newDoB == null || newDoB.trim().isEmpty()) {
                out.print("{\"success\":false,\"error\":\"Date of Birth cannot be empty.\"}");
                return;
            }
            try {
                // Parse dd/MM/yyyy
                String[] parts = newDoB.split("/");
                if (parts.length != 3) throw new Exception("Invalid date format");
                int day = Integer.parseInt(parts[0]);
                int month = Integer.parseInt(parts[1]);
                int year = Integer.parseInt(parts[2]);
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.setLenient(false);
                cal.set(year, month - 1, day, 0, 0, 0);
                java.util.Date dob = cal.getTime();
                CustomerDAO dao = new CustomerDAO();
                boolean updated = dao.updateDateOfBirth(email, dob);
                if (updated) {
                    Customer currentUser = (Customer) session.getAttribute("customerAuth");
                    if (currentUser != null) {
                        currentUser.setDateOfBirth(dob);
                        session.setAttribute("customerAuth", currentUser);
                    }
                    out.print("{\"success\":true}");
                } else {
                    out.print("{\"success\":false,\"error\":\"Failed to update Date of Birth.\"}");
                }
            } catch (Exception ex) {
                out.print("{\"success\":false,\"error\":\"Invalid date: " + ex.getMessage() + "\"}");
            }
            return;
        }

        if ("editAddress".equals(action)) {
            String newAddress = request.getParameter("newAddress");
            if (newAddress == null || newAddress.trim().isEmpty()) {
                out.print("{\"success\":false,\"error\":\"Address cannot be empty.\"}");
                return;
            }
            try {
                CustomerDAO dao = new CustomerDAO();
                boolean updated = dao.updateShippingAddress(email, newAddress);
                if (updated) {
                    Customer currentUser = (Customer) session.getAttribute("customerAuth");
                    if (currentUser != null) {
                        currentUser.setShipping_address(newAddress);
                        session.setAttribute("customerAuth", currentUser);
                    }
                    out.print("{\"success\":true}");
                } else {
                    out.print("{\"success\":false,\"error\":\"Failed to update address.\"}");
                }
            } catch (Exception ex) {
                out.print("{\"success\":false,\"error\":\"Unable to update address: " + ex.getMessage() + "\"}");
            }
            return;
        }
    }
}
