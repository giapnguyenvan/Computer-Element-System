package shop.controller.rest;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import shop.entities.Customer;
import shop.utils.ResponseUtils;

@WebServlet(name = "UserInfoApiServlet", urlPatterns = {"/UserInfoApiServlet"})
public class UserInfoApiServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession(false);
            
            if (session == null) {
                ResponseUtils.sendErrorResponse(response, 401, "User not logged in");
                return;
            }

            // Lấy thông tin customer từ session
            Customer customer = (Customer) session.getAttribute("customer");
            
            if (customer == null) {
                ResponseUtils.sendErrorResponse(response, 401, "Customer information not found");
                return;
            }

            // Tạo JSON response với thông tin user
            JsonObject userInfo = new JsonObject();
            userInfo.addProperty("fullName", customer.getName() != null ? customer.getName() : "");
            userInfo.addProperty("phone", customer.getPhone() != null ? customer.getPhone() : "");
            userInfo.addProperty("email", customer.getEmail() != null ? customer.getEmail() : "");
            userInfo.addProperty("address", customer.getShippingAddress() != null ? customer.getShippingAddress() : "");

            JsonObject responseObj = new JsonObject();
            responseObj.addProperty("success", true);
            responseObj.addProperty("message", "User information retrieved successfully");
            responseObj.add("data", userInfo);

            ResponseUtils.sendJsonResponse(response, responseObj);

        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtils.sendErrorResponse(response, 500, "Internal server error: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "User Info API Servlet";
    }
} 