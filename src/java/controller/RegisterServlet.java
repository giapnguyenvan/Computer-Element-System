package controller;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;
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

    /**
     * Validate address field
     * @param fieldValue the field value to validate
     * @return null if valid, error message if invalid
     */
    private String isValidAddressField(String fieldValue) {
        if (fieldValue == null || fieldValue.trim().isEmpty()) {
            return "This field is required.";
        }
        
        if (fieldValue.length() < 2 || fieldValue.length() > 100) {
            return "Length must be between 2 and 100 characters.";
        }
        
        // Check for dangerous characters
        Pattern dangerousChars = Pattern.compile("[<>{}[\\]\\\\$%]");
        if (dangerousChars.matcher(fieldValue).find()) {
            return "Contains invalid characters (<, >, {, }, [, ], \\, $, %).";
        }
        
        return null; // Valid
    }

    /**
     * Validate Vietnamese phone number
     * @param phone the phone number to validate
     * @return true if valid, false otherwise
     */
    private boolean isValidVietnamesePhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        
        // Vietnamese phone number format: 0xxxxxxxxx (10 digits starting with 0)
        Pattern phonePattern = Pattern.compile("^0[0-9]{9}$");
        return phonePattern.matcher(phone.trim()).matches();
    }

    /**
     * Build full address from address components
     * @param houseNumber house number
     * @param street street/village/quarter
     * @param ward ward/commune
     * @param district district
     * @param city city/province
     * @return full address string
     */
    private String buildFullAddress(String houseNumber, String street, String ward, String district, String city) {
        return String.format("%s, %s, %s, %s, %s", 
            houseNumber.trim(), 
            street.trim(), 
            ward.trim(), 
            district.trim(), 
            city.trim());
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
            
            // Address fields
            String houseNumber = request.getParameter("houseNumber");
            String street = request.getParameter("street");
            String ward = request.getParameter("ward");
            String district = request.getParameter("district");
            String city = request.getParameter("city");

            // Address dropdown fields
            String province = request.getParameter("province");

            // Validate phone number
            if (!isValidVietnamesePhone(phone)) {
                request.setAttribute("error", "Please enter a valid Vietnamese phone number (10 digits starting with 0).");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Validate address fields
            String addressValidationError = isValidAddressField(houseNumber);
            if (addressValidationError != null) {
                request.setAttribute("error", "House Number: " + addressValidationError);
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            addressValidationError = isValidAddressField(street);
            if (addressValidationError != null) {
                request.setAttribute("error", "Street: " + addressValidationError);
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            addressValidationError = isValidAddressField(ward);
            if (addressValidationError != null) {
                request.setAttribute("error", "Ward: " + addressValidationError);
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            addressValidationError = isValidAddressField(district);
            if (addressValidationError != null) {
                request.setAttribute("error", "District: " + addressValidationError);
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            addressValidationError = isValidAddressField(city);
            if (addressValidationError != null) {
                request.setAttribute("error", "City: " + addressValidationError);
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Validate address dropdowns
            if (province == null || province.isEmpty()) {
                request.setAttribute("error", "Please select a province/city.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            if (district == null || district.isEmpty()) {
                request.setAttribute("error", "Please select a district.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            if (ward == null || ward.isEmpty()) {
                request.setAttribute("error", "Please select a ward/commune.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            // Build shipping address
            String shippingAddress = String.format("%s, %s, %s", ward, district, province);

            // Kiểm tra mật khẩu xác nhận
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Password confirmation does not match!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            CustomerDAO customerDAO = new CustomerDAO();
            // Kiểm tra email đã tồn tại chưa
            if (customerDAO.isEmailExists(email)) {
                // Kiểm tra xem email có tồn tại nhưng chưa xác thực không
                if (customerDAO.isEmailExistsButNotVerified(email)) {
                    // Cập nhật thông tin customer chưa xác thực thay vì tạo mới
                    try {
                        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                        boolean updateSuccess = customerDAO.updateCustomerInfo(email, fullname, phone, shippingAddress, hashedPassword);
                        
                        if (updateSuccess) {
                            // Gửi mã xác thực qua email
                            String verificationCode = String.format("%06d", new java.util.Random().nextInt(1000000));
                            try {
                                EmailUtil.sendVerificationEmail(email, verificationCode);
                                // Lưu mã xác thực vào session để kiểm tra sau
                                request.getSession().setAttribute("verification_code", verificationCode);
                                request.getSession().setAttribute("verification_email", email);
                                request.setAttribute("showVerificationPopup", true);
                                request.setAttribute("registerMessage", "Information has been updated. Please check your email to verify your account!");
                            } catch (Exception ex) {
                                request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
                            }
                        } else {
                            request.setAttribute("error", "Cannot update account information. Please try again.");
                        }
                    } catch (SQLException e) {
                        request.setAttribute("error", "Error updating information: " + e.getMessage());
                    }
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("error", "Email is already in use!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                    return;
                }
            }
            // Tạo đối tượng Customer mới
            Customer newCustomer = new Customer(0, 0, fullname, phone, shippingAddress);
            newCustomer.setEmail(email);
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
                    request.setAttribute("showVerificationPopup", true);
                    request.setAttribute("registerMessage", "Please check your email to verify your account!");
                } catch (Exception ex) {
                    request.setAttribute("error", "Cannot send verification email: " + ex.getMessage());
                }
                request.getRequestDispatcher("Register.jsp").forward(request, response);
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