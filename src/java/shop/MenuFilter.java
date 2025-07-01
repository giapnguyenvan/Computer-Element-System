package shop;

import dal.MenuItemDAO;
import model.MenuItem;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebFilter("/*")
public class MenuFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Không cần làm gì
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        try {
            // Lấy menu động cho mọi request
            List<MenuItem> menuItems = MenuItemDAO.getAllMenuItems();
            httpRequest.setAttribute("menuItems", menuItems);
            
            // Debug log
            System.out.println("[MenuFilter] Đã truyền " + (menuItems != null ? menuItems.size() : 0) + " menu items cho: " + httpRequest.getRequestURI());
            
        } catch (Exception e) {
            System.err.println("[MenuFilter] Lỗi khi lấy menu items: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Tiếp tục chuỗi filter
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Không cần làm gì
    }
} 