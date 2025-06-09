/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import java.util.Vector;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="AccountControl", urlPatterns={"/Account_control"})
public class AccountControl extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("Account");
            return;
        }

        try {
            AccountDAO accountDAO = new AccountDAO();
            String redirectUrl = "Account";

            switch (action) {
                case "add" -> handleAddAccount(request, accountDAO);
                    
                case "update" -> handleUpdateAccount(request, accountDAO);
                    
                case "delete" -> handleDeleteAccount(request, accountDAO);
                    
                case "updatePassword" -> handleUpdatePassword(request, accountDAO);
                    
                case "search" -> {
                    handleSearchAccounts(request, accountDAO);
                    return; // Return here as we'll forward to a different page
                }
                default -> {
                    request.setAttribute("error", "Invalid action specified");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }
            }

            // Preserve the current page and filters in the redirect
            String page = request.getParameter("page");
            String role = request.getParameter("role");
            String search = request.getParameter("search");

            if (page != null) redirectUrl += "?page=" + page;
            if (role != null) redirectUrl += (redirectUrl.contains("?") ? "&" : "?") + "role=" + role;
            if (search != null) redirectUrl += (redirectUrl.contains("?") ? "&" : "?") + "search=" + search;

            response.sendRedirect(redirectUrl);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    } 

    private void handleAddAccount(HttpServletRequest request, AccountDAO accountDAO) throws Exception {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone_number = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        // Validate email uniqueness
        if (accountDAO.isEmailExists(email)) {
            throw new Exception("Email already exists");
        }

        // Create new account
        Account newAccount = new Account(
            0, // ID will be auto-generated
            name,
            email,
            password, // Note: In production, this should be hashed
            phone_number,
            address,
            role
        );

        if (!accountDAO.insertAccount(newAccount)) {
            throw new Exception("Failed to add account");
        }
    }

    private void handleUpdateAccount(HttpServletRequest request, AccountDAO accountDAO) throws Exception {
        int accountId = Integer.parseInt(request.getParameter("account_id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone_number = request.getParameter("phone_number");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        // Get existing account
        Account existingAccount = accountDAO.getAccountById(accountId);
        if (existingAccount == null) {
            throw new Exception("Account not found");
        }

        // Check email uniqueness only if email is changed
        if (!existingAccount.getEmail().equals(email) && accountDAO.isEmailExists(email)) {
            throw new Exception("Email already exists");
        }

        // Update account details
        existingAccount.setName(name);
        existingAccount.setEmail(email);
        existingAccount.setPhone_number(phone_number);
        existingAccount.setAddress(address);
        existingAccount.setRole(role);

        if (!accountDAO.updateAccount(existingAccount)) {
            throw new Exception("Failed to update account");
        }
    }

    private void handleDeleteAccount(HttpServletRequest request, AccountDAO accountDAO) throws Exception {
        int accountId = Integer.parseInt(request.getParameter("account_id"));
        
        // Verify account exists
        Account existingAccount = accountDAO.getAccountById(accountId);
        if (existingAccount == null) {
            throw new Exception("Account not found");
        }

        // Delete the account
        if (!accountDAO.deleteAccount(accountId)) {
            throw new Exception("Failed to delete account");
        }
    }

    private void handleUpdatePassword(HttpServletRequest request, AccountDAO accountDAO) throws Exception {
        int accountId = Integer.parseInt(request.getParameter("account_id"));
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        // Basic password validation
        if (!newPassword.equals(confirmPassword)) {
            throw new Exception("Passwords do not match");
        }

        // Verify account exists
        Account existingAccount = accountDAO.getAccountById(accountId);
        if (existingAccount == null) {
            throw new Exception("Account not found");
        }

        // Update password
        if (!accountDAO.updatePassword(accountId, newPassword)) { // Note: In production, this should be hashed
            throw new Exception("Failed to update password");
        }
    }

    private void handleSearchAccounts(HttpServletRequest request, AccountDAO accountDAO) throws Exception {
        String searchTerm = request.getParameter("search");
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // Use default page 1 if not specified
        }
        int pageSize = 10; // You can make this configurable

        Vector<Account> searchResults = accountDAO.searchAccounts(searchTerm, page, pageSize);
        int totalAccounts = accountDAO.getTotalAccountCount(); // This should be filtered by search term in production

        request.setAttribute("accounts", searchResults);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (int) Math.ceil(totalAccounts / (double) pageSize));
        request.setAttribute("searchTerm", searchTerm);
        ServletResponse response = null;

        request.getRequestDispatcher("accounts.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Account Management Controller Servlet";
    }// </editor-fold>

    public static void main(String[] args) {
        // Create DAO instance for testing
        AccountDAO accountDAO = new AccountDAO();
        
        try {
            System.out.println("=== Starting Account Management System Tests ===\n");
            
            // Test Case 1: Add new account
            System.out.println("Test Case 1: Adding new account");
            System.out.println("------------------------------");
            Account newAccount = new Account(
                0,
                "Test User",
                "test" + System.currentTimeMillis() + "@example.com", // Ensure unique email
                "password123",
                "1234567890",
                "123 Test Street",
                "customer"
            );
            boolean added = accountDAO.insertAccount(newAccount);
            System.out.println("Added new account: " + (added ? "SUCCESS ✓" : "FAILED ✗"));
            
            // Test Case 2: Search accounts
            System.out.println("\nTest Case 2: Searching for accounts");
            System.out.println("--------------------------------");
            Vector<Account> searchResults = accountDAO.searchAccounts("Test", 1, 10);
            System.out.println("Found " + searchResults.size() + " accounts");
            searchResults.forEach(account -> 
                System.out.println("- " + account.getName() + " (" + account.getEmail() + ")")
            );
            
            // Test Case 3: Update account
            System.out.println("\nTest Case 3: Updating account");
            System.out.println("----------------------------");
            if (!searchResults.isEmpty()) {
                Account accountToUpdate = searchResults.get(0);
                String originalName = accountToUpdate.getName();
                accountToUpdate.setName("Updated Test User");
                accountToUpdate.setPhone_number("9876543210");
                boolean updated = accountDAO.updateAccount(accountToUpdate);
                System.out.println("Updating account '" + originalName + "': " + (updated ? "SUCCESS ✓" : "FAILED ✗"));
                
                // Verify update
                Account updatedAccount = accountDAO.getAccountById(accountToUpdate.getId());
                System.out.println("Updated account details: " + updatedAccount.getName() + 
                                 " (Phone: " + updatedAccount.getPhone_number() + ")");
            }
            
            // Test Case 4: Get accounts by role
            System.out.println("\nTest Case 4: Getting accounts by role");
            System.out.println("---------------------------------");
            Vector<Account> accountsByRole = accountDAO.getAccountsByRole("customer");
            System.out.println("Found " + accountsByRole.size() + " accounts with role 'customer'");
            accountsByRole.forEach(account -> 
                System.out.println("- " + account.getName() + " (Role: " + account.getRole() + ")")
            );
            
            // Test Case 5: Error handling
            System.out.println("\nTest Case 5: Error handling tests");
            System.out.println("------------------------------");
            
            // Test 5.1: Invalid account ID
            System.out.println("5.1 Testing invalid account ID:");
            Account invalidAccount = accountDAO.getAccountById(-1);
            System.out.println("Invalid account ID test: " + 
                             (invalidAccount == null ? "SUCCESS ✓" : "FAILED ✗"));
            
            // Test 5.2: Duplicate email
            System.out.println("5.2 Testing duplicate email:");
            try {
                Account duplicateAccount = new Account(
                    0,
                    "Duplicate User",
                    searchResults.get(0).getEmail(), // Using existing email
                    "password123",
                    "1234567890",
                    "123 Test Street",
                    "customer"
                );
                accountDAO.insertAccount(duplicateAccount);
                System.out.println("Duplicate email test: FAILED ✗");
            } catch (Exception e) {
                System.out.println("Duplicate email test: SUCCESS ✓");
            }
            
            System.out.println("\n=== Account Management System Tests Completed ===");
            
        } catch (Exception e) {
            System.out.println("\n❌ ERROR during testing: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
