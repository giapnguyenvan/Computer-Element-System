package dal;

import model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CategoryDAO {

    // Lấy tất cả categories
    public static ArrayList<Category> getAllCategories() {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> listCategory = new ArrayList<>();
        String sql = """
                    SELECT * 
                    FROM categories
                    """;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                listCategory.add(category);
            }
        } catch (SQLException ex) {
            return listCategory;
        }
        return listCategory;
    }

    // Tìm category theo tên
    public static ArrayList<Category> searchCategory(String categoryName) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        String sql = """
                    SELECT * 
                    FROM categories 
                    WHERE name LIKE ?
                    """;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + categoryName + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(category);
            }
        } catch (SQLException ex) {
            return list;
        }
        return list;
    }

    // Thêm category mới
    public static Category addCategory(Category category) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                        INSERT INTO categories(name, description)
                        VALUES (?, ?)
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, category.getName());
            statement.setString(2, category.getDescription());
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return category;
        }
    }

    // Cập nhật category
    public static Category updateCategory(Category category) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                        UPDATE categories 
                        SET name = ?, description = ? 
                        WHERE id = ?
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, category.getName());
            statement.setString(2, category.getDescription());
            statement.setInt(3, category.getId());
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return category;
        }
    }

    // Xóa category
    public static Category deleteCategory(int id) {
        DBContext db = DBContext.getInstance();
        Category category = getCategoryById(id);
        if (category == null) {
            return null;
        }

        int rs = 0;
        try {
            String sql = """
                        DELETE FROM categories 
                        WHERE id = ?
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return category;
        }
    }

    // Lấy category theo ID
    public static Category getCategoryById(int categoryId) {
        DBContext db = DBContext.getInstance();
        String sql = """
                    SELECT * 
                    FROM categories 
                    WHERE id = ?
                    """;
        Category category = null;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, categoryId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                category = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) {
            return null;
        }
        return category;
    }

    //Them phan trang
    public static ArrayList<Category> getCategoriesByPage(int page, int size) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        int offset = (page - 1) * size;
        String sql = """
                SELECT * FROM categories
                LIMIT ? OFFSET ?
                """;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, size);
            statement.setInt(2, offset);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(category);
            }
        } catch (SQLException e) {
            return list;
        }
        return list;
    }

    //Phuong thuc dem tong so ban ghi.
    //Dung de biet co bao nhieu trang.
    public static int getTotalCategories() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) AS total FROM categories";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            return 0;
        }
        return 0;
    }

    // Lấy danh sách có sắp xếp theo tên
    public static ArrayList<Category> getCategoriesByPageAndSort(int page, int size, String sortOrder) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        int offset = (page - 1) * size;
        String sql;
        
        if (sortOrder == null || sortOrder.equals("default")) {
            sql = "SELECT * FROM categories LIMIT ? OFFSET ?";
        } else {
            sql = "SELECT * FROM categories ORDER BY name " + 
                  (sortOrder.equals("desc") ? "DESC" : "ASC") + 
                  " LIMIT ? OFFSET ?";
        }
        
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, size);
            statement.setInt(2, offset);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Error in getCategoriesByPageAndSort: " + e.getMessage());
            return list;
        }
        return list;
    }

    // Tìm category theo tên có phân trang
    public static ArrayList<Category> searchCategoryWithPaging(String categoryName, int page, int size) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        int offset = (page - 1) * size;
        String sql = """
                    SELECT * 
                    FROM categories 
                    WHERE name LIKE ? 
                    LIMIT ? OFFSET ?
                    """;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + categoryName + "%");
            statement.setInt(2, size);
            statement.setInt(3, offset);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(category);
            }
        } catch (SQLException ex) {
            System.out.println("Error in searchCategoryWithPaging: " + ex.getMessage());
            return list;
        }
        return list;
    }

    // Đếm tổng số kết quả search
    public static int getTotalSearchResults(String categoryName) {
        DBContext db = DBContext.getInstance();
        String sql = """
                    SELECT COUNT(*) as total 
                    FROM categories 
                    WHERE name LIKE ?
                    """;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + categoryName + "%");
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalSearchResults: " + e.getMessage());
            return 0;
        }
        return 0;
    }

}
