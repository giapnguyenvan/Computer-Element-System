/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

// Import các thư viện cần thiết cho Servlet, xử lý session, cookie, mã hóa, truy xuất dữ liệu
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import model.User;
import dal.CustomerDAO;
import model.Customer;
import util.JwtUtil;

/**
 * Servlet xử lý chức năng đăng nhập cho cả Customer và User (Admin/Staff)
 */
public class LoginServlet extends HttpServlet {
   
    /** 
     * Xử lý request cho cả GET và POST (mặc định, không dùng trong login)
     */
    public void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Hiển thị thông tin đơn giản (không dùng thực tế)
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Xử lý HTTP GET: Hiển thị trang đăng nhập
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Chuyển hướng sang trang login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    /** 
     * Xử lý HTTP POST: Xử lý logic đăng nhập khi người dùng submit form
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy thông tin email, password, và trạng thái "remember me" từ form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        try {
            // Thử đăng nhập với Customer (khách hàng)
            Customer customer = new dal.CustomerDAO().login(email, password);
            if (customer != null) {
                // Nếu tài khoản chưa xác thực, báo lỗi
                if (!customer.isVerified()) {
                    request.setAttribute("error", "Account is not existed");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                // Lấy thông tin chi tiết customer
                shop.entities.Customer cus = new shop.DAO.CustomerDAO().getById(customer.getCustomer_id());
                // Tạo session và lưu thông tin đăng nhập
                HttpSession session = request.getSession();
                session.setAttribute("customerAuth", customer);
                session.setAttribute("userAuth", customer);
                session.setAttribute("customer", cus);
                session.setAttribute("session_login", email);
                session.setAttribute("user_role", "customer");
                session.setAttribute("user_name", customer.getName());
                session.setAttribute("customer_id", customer.getCustomer_id());
                // Chuyển hướng về trang chủ
                response.sendRedirect(request.getContextPath() + "/homepageservlet");
                return;
            }
            // Nếu không phải customer, thử đăng nhập với User (Staff/Admin)
            User user = dal.UserDAO.getInstance().login(email, password);
            if (user != null) {
                // Nếu tài khoản chưa xác thực email, báo lỗi
                if (!user.isVerified()) {
                    request.setAttribute("error", "Email was not verified");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                // Tạo session và lưu thông tin đăng nhập
                HttpSession session = request.getSession();
                // Lấy tên đầy đủ từ DAO (nếu có)
                String fullname = dal.UserDAO.getInstance().getFullname(user.getId(), user.getRole());

                // Sinh JWT token cho user (dùng cho API hoặc xác thực nâng cao)
                String accessToken = JwtUtil.generateAccessToken(
                    user.getId(), 
                    user.getEmail(), 
                    user.getRole(), 
                    "user"
                );
                String refreshToken = JwtUtil.generateRefreshToken(
                    user.getId(), 
                    user.getEmail(), 
                    user.getRole(), 
                    "user"
                );

                session.setAttribute("userAuth", user);
                session.setAttribute("session_login", email);
                session.setAttribute("user_role", user.getRole());
                session.setAttribute("user_name", fullname != null ? fullname : user.getUsername()); // Ưu tiên fullname
                session.setAttribute("accessToken", accessToken);
                session.setAttribute("refreshToken", refreshToken);
                
                // Xử lý "Remember me": Lưu thông tin đăng nhập vào cookie nếu được chọn
                if (remember != null) {
                    String encodedEmail = URLEncoder.encode(email, StandardCharsets.UTF_8);
                    String encodedPassword = URLEncoder.encode(password, StandardCharsets.UTF_8);
                    
                    Cookie emailCookie = new Cookie("COOKIE_EMAIL", encodedEmail);
                    Cookie passwordCookie = new Cookie("COOKIE_PASSWORD", encodedPassword);
                    
                    emailCookie.setMaxAge(60*60*24); // 24 giờ
                    passwordCookie.setMaxAge(60*60*24);
                    
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                } else {
                    // Nếu không chọn, xóa cookie cũ nếu có
                    Cookie emailCookie = new Cookie("COOKIE_EMAIL", "");
                    Cookie passwordCookie = new Cookie("COOKIE_PASSWORD", "");
                    
                    emailCookie.setMaxAge(0); // Xóa cookie
                    passwordCookie.setMaxAge(0);
                    
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                }
                
                // Chuyển hướng theo vai trò: Admin, Staff, Shipper hoặc về trang chủ
                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
                } else if ("Staff".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/staffDashboard.jsp");
                } else if ("Shipper".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/shipperdashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/homepageservlet");
                }
                return;
            } else {
                // Nếu đăng nhập thất bại, báo lỗi
                request.setAttribute("error", "Email hoặc mật khẩu không đúng");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Xử lý lỗi hệ thống, báo lỗi cho người dùng
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /** 
     * Trả về mô tả ngắn về servlet
     */
    @Override
    public String getServletInfo() {
        return "Login Servlet";
    }// </editor-fold>

}
