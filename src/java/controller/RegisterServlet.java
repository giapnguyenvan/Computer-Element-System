package controller;

import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import model.Customer;

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
            String address = request.getParameter("address");

            // Kiểm tra mật khẩu xác nhận
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }

            CustomerDAO customerDAO = new CustomerDAO();
            // Kiểm tra email đã tồn tại chưa
            if (customerDAO.isEmailExists(email)) {
                request.setAttribute("error", "Email đã được sử dụng!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            // Tạo đối tượng Customer mới
            Customer newCustomer = new Customer(0, 0, fullname, phone, address);
            newCustomer.setEmail(email);
            newCustomer.setPassword(password);
            // Thực hiện đăng ký
            String sql = "INSERT INTO Customer (name, email, password, phone, shipping_address) VALUES (?, ?, ?, ?, ?)";
            try (java.sql.Connection conn = dal.DBContext.getInstance().getConnection();
                 java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, fullname);
                stmt.setString(2, email);
                stmt.setString(3, password);
                stmt.setString(4, phone);
                stmt.setString(5, address);
                if (stmt.executeUpdate() > 0) {
                    response.sendRedirect("login.jsp");
                } else {
                    request.setAttribute("error", "Đăng ký thất bại!");
                    request.getRequestDispatcher("Register.jsp").forward(request, response);
                }
            }
            return;
            
        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }
} 