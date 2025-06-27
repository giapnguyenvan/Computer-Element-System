package controller;

import model.GearvnCategory;
import model.SubCategory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/GearvnCategoryServlet")
public class GearvnCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<GearvnCategory> categories = new ArrayList<>();
        String error = null;

        try {
            Document doc = Jsoup.connect("https://gearvn.com").get();
            // Lấy menu bên trái (tùy vào cấu trúc thực tế, có thể cần chỉnh lại selector)
            Elements mainMenu = doc.select("nav.menu-danh-muc, .menu-danh-muc, .left-menu, .aside-menu, .menu-category");
            if (mainMenu.isEmpty()) {
                mainMenu = doc.select(".aside .aside-content .aside-menu");
            }
            if (!mainMenu.isEmpty()) {
                Elements mainItems = mainMenu.select("li, .menu-item, .aside-menu-item");
                for (Element mainItem : mainItems) {
                    String catName = mainItem.text();
                    Element link = mainItem.selectFirst("a, .menu-title");
                    if (link != null) catName = link.text();
                    List<SubCategory> subCategories = new ArrayList<>();
                    Element megaMenu = mainItem.selectFirst(".megamenu, .dropdown-menu, .sub-menu, .aside-dropdown-menu");
                    if (megaMenu != null) {
                        Elements subBlocks = megaMenu.select(".col, .megamenu-block, .dropdown-block, .aside-dropdown-block");
                        for (Element subBlock : subBlocks) {
                            String subTitle = subBlock.selectFirst("h3, .title, .megamenu-title, .dropdown-title") != null
                                    ? subBlock.selectFirst("h3, .title, .megamenu-title, .dropdown-title").text()
                                    : "Danh mục con";
                            List<String> items = new ArrayList<>();
                            Elements itemLinks = subBlock.select("a, li");
                            for (Element item : itemLinks) {
                                String itemText = item.text();
                                if (!itemText.isEmpty() && !itemText.equals(subTitle)) {
                                    items.add(itemText);
                                }
                            }
                            if (!items.isEmpty()) {
                                subCategories.add(new SubCategory(subTitle, items));
                            }
                        }
                    }
                    categories.add(new GearvnCategory(catName, subCategories));
                }
            } else {
                error = "Không tìm thấy menu danh mục trên trang GearVN.";
            }
        } catch (Exception e) {
            error = "Lỗi khi lấy dữ liệu từ GearVN: " + e.getMessage();
        }
        request.setAttribute("categories", categories);
        request.setAttribute("error", error);
        request.getRequestDispatcher("category.jsp").forward(request, response);
    }
} 