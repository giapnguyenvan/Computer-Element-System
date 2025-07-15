package controller;

import dal.VoucherDAO;
import model.Voucher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.List;
import java.util.Vector;
import java.util.Comparator;

@WebServlet(name="ManageVoucherServlet", urlPatterns={"/managevouchers"})
public class ManageVoucherServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;
    private final VoucherDAO voucherDAO;

    public ManageVoucherServlet() {
        voucherDAO = new VoucherDAO();
    }

    public void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            voucherDAO.autoUpdateVoucherStatuses();
            List<Voucher> allVouchers = voucherDAO.getAllVouchers();

            // Search
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                String searchLower = search.toLowerCase();
                allVouchers.removeIf(v ->
                    !(v.getCode().toLowerCase().contains(searchLower) ||
                      (v.getDescription() != null && v.getDescription().toLowerCase().contains(searchLower))));
            }

            // Sort
            String sortBy = request.getParameter("sortBy");
            if (sortBy != null) {
                switch (sortBy) {
                    case "newest":
                        allVouchers.sort(Comparator.comparing(Voucher::getStart_date, Comparator.nullsLast(Comparator.reverseOrder())));
                        break;
                    case "oldest":
                        allVouchers.sort(Comparator.comparing(Voucher::getStart_date, Comparator.nullsLast(Comparator.naturalOrder())));
                        break;
                    case "code":
                        allVouchers.sort(Comparator.comparing(Voucher::getCode, String.CASE_INSENSITIVE_ORDER));
                        break;
                    case "status":
                        allVouchers.sort(Comparator.comparing(Voucher::getStatus, String.CASE_INSENSITIVE_ORDER));
                        break;
                }
            } else {
                // Default sort by newest
                allVouchers.sort(Comparator.comparing(Voucher::getStart_date, Comparator.nullsLast(Comparator.reverseOrder())));
            }

            // Pagination
            int totalVouchers = allVouchers.size();
            int totalPages = (int) Math.ceil((double) totalVouchers / PAGE_SIZE);
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
                if (page > totalPages && totalPages > 0) page = totalPages;
            } catch (NumberFormatException e) {}
            int startIndex = (page - 1) * PAGE_SIZE;
            int endIndex = Math.min(startIndex + PAGE_SIZE, totalVouchers);
            List<Voucher> pagedVouchers = allVouchers.subList(startIndex, endIndex);

            request.setAttribute("voucherList", pagedVouchers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalVouchers", totalVouchers);

            request.getRequestDispatcher("ManageVoucher.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching vouchers: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null || action.equals("list")) {
                processRequest(request, response);
            } else {
                response.sendRedirect("managevouchers");
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("ManageVoucher.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addVoucher(request, response);
                    break;
                case "update":
                    updateVoucher(request, response);
                    break;
                case "delete":
                    deleteVoucher(request, response);
                    break;
                default:
                    response.sendRedirect("managevouchers");
                    break;
            }
        } catch (Exception ex) {
            request.setAttribute("error", "Error: " + ex.getMessage());
            request.getRequestDispatcher("ManageVoucher.jsp").forward(request, response);
        }
    }

    private void addVoucher(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            Voucher v = new Voucher();
            v.setCode(request.getParameter("code"));
            v.setDescription(request.getParameter("description"));
            v.setDiscount_type(request.getParameter("discount_type"));
            v.setDiscount_value(new java.math.BigDecimal(request.getParameter("discount_value")));
            v.setMin_order_amount(new java.math.BigDecimal(request.getParameter("min_order_amount")));
            v.setMax_uses(request.getParameter("max_uses").isEmpty() ? null : Integer.parseInt(request.getParameter("max_uses")));
            v.setMax_uses_per_user(request.getParameter("max_uses_per_user").isEmpty() ? null : Integer.parseInt(request.getParameter("max_uses_per_user")));
            v.setStart_date(java.sql.Timestamp.valueOf(request.getParameter("start_date") + ":00"));
            v.setEnd_date(java.sql.Timestamp.valueOf(request.getParameter("end_date") + ":00"));
            v.setStatus(request.getParameter("status"));
            voucherDAO.insertVoucher(v);
            request.getSession().setAttribute("success", "Voucher added successfully");
            response.sendRedirect("managevouchers");
        } catch (Exception ex) {
            request.getSession().setAttribute("error", "Error: " + ex.getMessage());
            response.sendRedirect("managevouchers");
        }
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            Voucher v = new Voucher();
            v.setCode(request.getParameter("code"));
            v.setDescription(request.getParameter("description"));
            v.setDiscount_type(request.getParameter("discount_type"));
            v.setDiscount_value(new java.math.BigDecimal(request.getParameter("discount_value")));
            v.setMin_order_amount(new java.math.BigDecimal(request.getParameter("min_order_amount")));
            v.setMax_uses(request.getParameter("max_uses").isEmpty() ? null : Integer.parseInt(request.getParameter("max_uses")));
            v.setMax_uses_per_user(request.getParameter("max_uses_per_user").isEmpty() ? null : Integer.parseInt(request.getParameter("max_uses_per_user")));
            v.setStart_date(java.sql.Timestamp.valueOf(request.getParameter("start_date") + ":00"));
            v.setEnd_date(java.sql.Timestamp.valueOf(request.getParameter("end_date") + ":00"));
            v.setStatus(request.getParameter("status"));
            voucherDAO.updateVoucher(v);
            request.getSession().setAttribute("success", "Voucher updated successfully");
            response.sendRedirect("managevouchers");
        } catch (Exception ex) {
            request.getSession().setAttribute("error", "Error: " + ex.getMessage());
            response.sendRedirect("managevouchers");
        }
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            String code = request.getParameter("code");
            voucherDAO.deleteVoucher(code);
            request.getSession().setAttribute("success", "Voucher deleted successfully");
            response.sendRedirect("managevouchers");
        } catch (Exception ex) {
            request.getSession().setAttribute("error", "Error: " + ex.getMessage());
            response.sendRedirect("managevouchers");
        }
    }
} 