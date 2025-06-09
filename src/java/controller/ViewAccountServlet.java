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

@WebServlet(name = "ViewAccountServlet", urlPatterns = {"/viewaccounts"})
public class ViewAccountServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Number of accounts per page

    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            AccountDAO accountDAO = new AccountDAO();
            
            // Get all accounts first
            Vector<Account> allAccounts = accountDAO.getAllAccounts(1, Integer.MAX_VALUE);
            
            // Apply role filter if specified
            String roleFilter = request.getParameter("role");
            if (roleFilter != null && !roleFilter.isEmpty()) {
                Vector<Account> filteredList = new Vector<>();
                for (Account a : allAccounts) {
                    if (a.getRole().equalsIgnoreCase(roleFilter)) {
                        filteredList.add(a);
                    }
                }
                allAccounts = filteredList;
            }
            
            // Apply search filter
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                Vector<Account> searchedList = new Vector<>();
                search = search.toLowerCase();
                for (Account a : allAccounts) {
                    if (a.getName().toLowerCase().contains(search) || 
                        a.getEmail().toLowerCase().contains(search) ||
                        a.getPhone_number().toLowerCase().contains(search)) {
                        searchedList.add(a);
                    }
                }
                allAccounts = searchedList;
            }
            
            // Apply sorting
            String sortBy = request.getParameter("sortBy");
            if (sortBy != null) {
                switch (sortBy) {
                    case "name":
                        Collections.sort(allAccounts, (a1, a2) -> 
                            a1.getName().compareToIgnoreCase(a2.getName()));
                        break;
                    case "email":
                        Collections.sort(allAccounts, (a1, a2) -> 
                            a1.getEmail().compareToIgnoreCase(a2.getEmail()));
                        break;
                    case "role":
                        Collections.sort(allAccounts, (a1, a2) -> 
                            a1.getRole().compareToIgnoreCase(a2.getRole()));
                        break;
                    case "id":
                        Collections.sort(allAccounts, (a1, a2) -> 
                            Integer.compare(a1.getId(), a2.getId()));
                        break;
                }
            }
            
            // Calculate pagination after filtering
            int totalAccounts = allAccounts.size();
            int totalPages = (int) Math.ceil((double) totalAccounts / PAGE_SIZE);
            
            // Get page number from request
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
                if (page > totalPages && totalPages > 0) page = totalPages;
            } catch (NumberFormatException e) {
                // Keep page as 1 if not specified or invalid
            }
            
            // Apply pagination to filtered and sorted results
            Vector<Account> pagedAccounts = new Vector<>();
            int startIndex = (page - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, totalAccounts);
            
            for (int i = startIndex; i < endIndex; i++) {
                pagedAccounts.add(allAccounts.get(i));
            }
            
            // Set attributes for the JSP
            request.setAttribute("accountList", pagedAccounts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalAccounts", totalAccounts);
            
            // Forward to JSP
            request.getRequestDispatcher("viewaccounts.jsp").forward(request, response);
            
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