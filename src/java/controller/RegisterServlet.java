package controller;

import dal.CustomerDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
            String gender = request.getParameter("gender");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            
            // Lấy thông tin address từ các trường riêng biệt
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String addressDetail = request.getParameter("addressDetail");
            
            // Fallback to hidden inputs if regular inputs are null
            if (province == null || province.trim().isEmpty()) {
                province = request.getParameter("provinceHidden");
            }
            if (district == null || district.trim().isEmpty()) {
                district = request.getParameter("districtHidden");
            }
            if (ward == null || ward.trim().isEmpty()) {
                ward = request.getParameter("wardHidden");
            }
            
            // Ghép address thành chuỗi hoàn chỉnh
            StringBuilder addressBuilder = new StringBuilder();
            if (province != null && !province.trim().isEmpty()) {
                addressBuilder.append(province.trim());
            }
            if (district != null && !district.trim().isEmpty()) {
                if (addressBuilder.length() > 0) addressBuilder.append(", ");
                addressBuilder.append(district.trim());
            }
            if (ward != null && !ward.trim().isEmpty()) {
                if (addressBuilder.length() > 0) addressBuilder.append(", ");
                addressBuilder.append(ward.trim());
            }
            if (addressDetail != null && !addressDetail.trim().isEmpty()) {
                if (addressBuilder.length() > 0) addressBuilder.append(", ");
                addressBuilder.append(addressDetail.trim());
            }
            
            String address = addressBuilder.toString();
            
            // Ensure address is not empty - use a fallback if needed
            if (address == null || address.trim().isEmpty()) {
                address = "Address not specified";
            }
            
            // Validate address fields
            if (province == null || province.trim().isEmpty()) {
                request.setAttribute("error", "Please select a province/city.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            if (district == null || district.trim().isEmpty()) {
                request.setAttribute("error", "Please select a district.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            if (ward == null || ward.trim().isEmpty()) {
                request.setAttribute("error", "Please select a ward/commune.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu xác nhận
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Password confirmation does not match!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            CustomerDAO customerDAO = new CustomerDAO();
            UserDAO userDAO = UserDAO.getInstance();
            
            // Kiểm tra email đã tồn tại trong bảng User chưa
            try {
                if (userDAO.isEmailExists(email)) {
                    request.setAttribute("error", "Email is already in use by another account!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                request.setAttribute("error", "System error checking email: " + e.getMessage());
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            
            // Kiểm tra email đã tồn tại trong bảng Customer chưa
            if (customerDAO.isEmailExists(email)) {
                // Kiểm tra xem email có tồn tại nhưng chưa xác thực không
                if (customerDAO.isEmailExistsButNotVerified(email)) {
                    // Cập nhật thông tin customer chưa xác thực thay vì tạo mới
                    try {
                        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                        
                        // Parse date of birth
                        Date dateOfBirth = null;
                        if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                            try {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                dateOfBirth = sdf.parse(dateOfBirthStr);
                            } catch (ParseException e) {
                                request.setAttribute("error", "Invalid date format for date of birth.");
                                request.getRequestDispatcher("Register.jsp").forward(request, response);
                                return;
                            }
                        }
                        
                        boolean updateSuccess = customerDAO.updateCustomerInfoWithGenderAndDOB(email, fullname, phone, address, hashedPassword, gender, dateOfBirth);
                        
                        if (updateSuccess) {
                            // Gửi mã xác thực qua email
                            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
                            try {
                                EmailUtil.sendVerificationEmail(email, verificationCode);
                                // Lưu mã xác thực vào session để kiểm tra sau
                                request.getSession().setAttribute("verification_code", verificationCode);
                                request.getSession().setAttribute("verification_email", email);
                                
                                // Hiển thị popup verification
                                request.setAttribute("showVerificationPopup", true);
                                request.setAttribute("registerMessage", "Information has been updated. Please check your email to verify your account!");
                                request.getRequestDispatcher("Register.jsp").forward(request, response);
                                return;
                            } catch (Exception ex) {
                                request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
                                request.getRequestDispatcher("Register.jsp").forward(request, response);
                                return;
                            }
                        } else {
                            request.setAttribute("error", "Cannot update account information. Please try again.");
                            request.getRequestDispatcher("Register.jsp").forward(request, response);
                            return;
                        }
                    } catch (Exception e) {
                        request.setAttribute("error", "Error updating information: " + e.getMessage());
                        request.getRequestDispatcher("Register.jsp").forward(request, response);
                        return;
                    }
                } else {
                    request.setAttribute("error", "Email is already in use!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
            }
            // Tạo đối tượng Customer mới
            Customer newCustomer = new Customer(0, 0, fullname, phone, address);
            newCustomer.setEmail(email);
            newCustomer.setGender(gender);
            
            // Parse date of birth
            Date dateOfBirth = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dateOfBirth = sdf.parse(dateOfBirthStr);
                    newCustomer.setDateOfBirth(dateOfBirth);
                } catch (ParseException e) {
                    request.setAttribute("error", "Invalid date format for date of birth.");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
            }
            
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
                    
                    // Hiển thị popup verification
                    request.setAttribute("showVerificationPopup", true);
                    request.setAttribute("registerMessage", "Please check your email to verify your account!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                } catch (Exception ex) {
                    request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
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