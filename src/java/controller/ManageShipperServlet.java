package controller;

import dal.ShipperDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Shipper;
import java.util.Collections;
import java.math.BigDecimal;
import java.util.Date;

@WebServlet(name = "ManageShipperServlet", urlPatterns = {"/manageshipper"})
public class ManageShipperServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Number of shipper items per page
    private final ShipperDAO shipperDAO;

    public ManageShipperServlet() {
        shipperDAO = new ShipperDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        try {
            if (action != null) {
                switch (action) {
                    case "add":
                        addShipper(request, response);
                        return;
                    case "update":
                        updateShipper(request, response);
                        return;
                    case "delete":
                        deleteShipper(request, response);
                        return;
                }
            }
            
            // Default action: list shippers
            listShippers(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "An error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageshipper");
        }
    }

    private void listShippers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get page number from request
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                // Keep page as 1 if not specified or invalid
            }
            
            // Get all shippers (we'll handle pagination in the servlet)
            List<Shipper> shipperList = shipperDAO.getAllShippers();
            
            // Apply status filter if specified
            String statusFilter = request.getParameter("status");
            if (statusFilter != null && !statusFilter.isEmpty()) {
                List<Shipper> filteredList = new java.util.ArrayList<>();
                for (Shipper s : shipperList) {
                    if (statusFilter.equals(s.getStatus())) {
                        filteredList.add(s);
                    }
                }
                shipperList = filteredList;
            }
            
            // Apply vehicle type filter
            String vehicleTypeFilter = request.getParameter("vehicleType");
            if (vehicleTypeFilter != null && !vehicleTypeFilter.isEmpty()) {
                List<Shipper> filteredList = new java.util.ArrayList<>();
                for (Shipper s : shipperList) {
                    if (vehicleTypeFilter.equals(s.getVehicle_type())) {
                        filteredList.add(s);
                    }
                }
                shipperList = filteredList;
            }
            
            // Apply search filter
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                List<Shipper> searchedList = new java.util.ArrayList<>();
                search = search.toLowerCase();
                for (Shipper s : shipperList) {
                    if (s.getName().toLowerCase().contains(search) || 
                        s.getPhone().toLowerCase().contains(search) ||
                        (s.getEmail() != null && s.getEmail().toLowerCase().contains(search))) {
                        searchedList.add(s);
                    }
                }
                shipperList = searchedList;
            }
            
            // Apply sorting
            String sortBy = request.getParameter("sortBy");
            if (sortBy != null) {
                switch (sortBy) {
                    case "name":
                        Collections.sort(shipperList, (s1, s2) -> 
                            s1.getName().compareToIgnoreCase(s2.getName()));
                        break;
                    case "rating":
                        Collections.sort(shipperList, (s1, s2) -> 
                            s2.getRating().compareTo(s1.getRating()));
                        break;
                    case "deliveries":
                        Collections.sort(shipperList, (s1, s2) -> 
                            Integer.compare(s2.getTotal_deliveries(), s1.getTotal_deliveries()));
                        break;
                    case "joinDate":
                        Collections.sort(shipperList, (s1, s2) -> 
                            s2.getJoin_date().compareTo(s1.getJoin_date()));
                        break;
                }
            }
            
            // Handle pagination
            int totalShippers = shipperList.size();
            int totalPages = (int) Math.ceil((double) totalShippers / PAGE_SIZE);
            int startIndex = (page - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, totalShippers);
            
            List<Shipper> paginatedList = shipperList.subList(startIndex, endIndex);
            
            // Set attributes for the JSP
            request.setAttribute("shipperList", paginatedList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalShippers", totalShippers);
            
            // Check for any messages in session and transfer to request
            String success = (String) request.getSession().getAttribute("success");
            String error = (String) request.getSession().getAttribute("error");
            if (success != null) {
                request.setAttribute("success", success);
                request.getSession().removeAttribute("success");
            }
            if (error != null) {
                request.setAttribute("error", error);
                request.getSession().removeAttribute("error");
            }
            
            // Forward to JSP
            request.getRequestDispatcher("manageshipper.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "An error occurred while fetching shippers: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageshipper");
        }
    }

    private void addShipper(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String vehicleNumber = request.getParameter("vehicle_number");
            String vehicleType = request.getParameter("vehicle_type");
            String status = request.getParameter("status");
            String currentLocation = request.getParameter("current_location");

            // Validate required fields
            if (name == null || name.trim().isEmpty()) {
                throw new Exception("Name is required");
            }
            if (phone == null || phone.trim().isEmpty()) {
                throw new Exception("Phone is required");
            }

            // Check if phone already exists
            if (shipperDAO.isPhoneExists(phone)) {
                throw new Exception("Phone number already exists");
            }

            // Check if email already exists (if provided)
            if (email != null && !email.trim().isEmpty() && shipperDAO.isEmailExists(email)) {
                throw new Exception("Email already exists");
            }

            // Create new shipper object
            Shipper shipper = new Shipper(name, phone, email, vehicleNumber, vehicleType, status, currentLocation);
            
            // Save shipper
            shipperDAO.addShipper(shipper);
            
            // Set success message
            request.getSession().setAttribute("success", "Shipper added successfully");
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error adding shipper: " + e.getMessage());
        }
        
        // Redirect back to manage shipper page
        response.sendRedirect(request.getContextPath() + "/manageshipper");
    }

    private void updateShipper(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int shipperId = Integer.parseInt(request.getParameter("shipper_id"));
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String vehicleNumber = request.getParameter("vehicle_number");
            String vehicleType = request.getParameter("vehicle_type");
            String status = request.getParameter("status");
            String currentLocation = request.getParameter("current_location");

            // Get existing shipper
            Shipper shipper = shipperDAO.getShipperById(shipperId);
            if (shipper == null) {
                throw new Exception("Shipper not found");
            }
            
            // Update fields
            shipper.setName(name);
            shipper.setPhone(phone);
            shipper.setEmail(email);
            shipper.setVehicle_number(vehicleNumber);
            shipper.setVehicle_type(vehicleType);
            shipper.setStatus(status);
            shipper.setCurrent_location(currentLocation);
            
            // Update shipper
            shipperDAO.updateShipper(shipper);
            request.getSession().setAttribute("success", "Shipper updated successfully");
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error updating shipper: " + e.getMessage());
        }
        
        // Redirect back to manage shipper page
        response.sendRedirect(request.getContextPath() + "/manageshipper");
    }

    private void deleteShipper(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int shipperId = Integer.parseInt(request.getParameter("shipper_id"));
            
            // Delete shipper
            boolean deleted = shipperDAO.deleteShipper(shipperId);
            if (deleted) {
                request.getSession().setAttribute("success", "Shipper deleted successfully");
            } else {
                request.getSession().setAttribute("error", "Failed to delete shipper");
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error deleting shipper: " + e.getMessage());
        }
        
        // Redirect back to manage shipper page
        response.sendRedirect(request.getContextPath() + "/manageshipper");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "ManageShipper Servlet handles displaying and managing shippers";
    }
} 