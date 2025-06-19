package controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;
import model.Account;
import java.util.Collections;
import dal.CustomerDAO;
import model.Customer;

@WebServlet(name = "ViewAccountServlet", urlPatterns = {"/Account"})
public class ViewAccountServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Number of accounts per page

    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            AccountDAO accountDAO = new AccountDAO();
            CustomerDAO customerDAO = new CustomerDAO();
            
            // Phân trang cho user
            int userPage = 1;
            try { userPage = Integer.parseInt(request.getParameter("userPage")); } catch (Exception e) {}
            if (userPage < 1) userPage = 1;
            int userPageSize = 10;
            java.util.List<Account> allUsers = accountDAO.getAllAccounts(1, Integer.MAX_VALUE);
            int userTotal = allUsers.size();
            int userTotalPages = (int) Math.ceil((double) userTotal / userPageSize);
            if (userPage > userTotalPages && userTotalPages > 0) userPage = userTotalPages;
            int userStart = (userPage-1)*userPageSize;
            int userEnd = Math.min(userStart+userPageSize, userTotal);
            java.util.List<Account> userList = allUsers.subList(userStart, userEnd);
            
            // Apply role filter if specified
            String roleFilter = request.getParameter("role");
            if (roleFilter != null && !roleFilter.isEmpty()) {
                Vector<Account> filteredList = new Vector<>();
                for (Account a : userList) {
                    if (a.getRole().equalsIgnoreCase(roleFilter)) {
                        filteredList.add(a);
                    }
                }
                userList = filteredList;
            }
            
            // Apply search filter
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                Vector<Account> searchedList = new Vector<>();
                search = search.toLowerCase();
                for (Account a : userList) {
                    if (a.getUsername().toLowerCase().contains(search) || 
                        a.getEmail().toLowerCase().contains(search)) {
                        searchedList.add(a);
                    }
                }
                userList = searchedList;
            }
            
            // Apply sorting
            String sortBy = request.getParameter("sortBy");
            if (sortBy != null) {
                switch (sortBy) {
                    case "username":
                        Collections.sort(userList, (a1, a2) -> 
                            a1.getUsername().compareToIgnoreCase(a2.getUsername()));
                        break;
                    case "email":
                        Collections.sort(userList, (a1, a2) -> 
                            a1.getEmail().compareToIgnoreCase(a2.getEmail()));
                        break;
                    case "role":
                        Collections.sort(userList, (a1, a2) -> 
                            a1.getRole().compareToIgnoreCase(a2.getRole()));
                        break;
                    case "id":
                        Collections.sort(userList, (a1, a2) -> 
                            Integer.compare(a1.getId(), a2.getId()));
                        break;
                }
            }
            
            // Phân trang cho customer
            int customerPage = 1;
            try { customerPage = Integer.parseInt(request.getParameter("customerPage")); } catch (Exception e) {}
            if (customerPage < 1) customerPage = 1;
            int customerPageSize = 10;
            java.util.List<Customer> allCustomers = customerDAO.getAllCustomers();
            int customerTotal = allCustomers.size();
            int customerTotalPages = (int) Math.ceil((double) customerTotal / customerPageSize);
            if (customerPage > customerTotalPages && customerTotalPages > 0) customerPage = customerTotalPages;
            int customerStart = (customerPage-1)*customerPageSize;
            int customerEnd = Math.min(customerStart+customerPageSize, customerTotal);
            java.util.List<Customer> customerList = allCustomers.subList(customerStart, customerEnd);
            
            // Truyền sang JSP
            request.setAttribute("userList", userList);
            request.setAttribute("userCurrentPage", userPage);
            request.setAttribute("userTotalPages", userTotalPages);
            request.setAttribute("customerList", customerList);
            request.setAttribute("customerCurrentPage", customerPage);
            request.setAttribute("customerTotalPages", customerTotalPages);
            request.getRequestDispatcher("Account.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching accounts: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "ViewAccount Servlet handles displaying and filtering accounts";
    }
} 