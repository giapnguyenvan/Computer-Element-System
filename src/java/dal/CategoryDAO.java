package dal;

import model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CategoryDAO {

    // Get all component types
    public static ArrayList<Category> getAllCategories() {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> listCategory = new ArrayList<>();
        String sql = "SELECT * FROM componenttype";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("type_id"),
                        rs.getString("name"),
                        "" // No description in componenttype table
                );
                listCategory.add(category);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCategory;
    }

    // Search component types by name
    public static ArrayList<Category> searchCategory(String categoryName) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM componenttype WHERE name LIKE ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + categoryName + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("type_id"),
                        rs.getString("name"),
                        "" // No description
                );
                list.add(category);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Add new component type
    public static void addCategory(Category category) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO componenttype(name) VALUES (?)";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, category.getName());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update component type
    public static void updateCategory(Category category) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE componenttype SET name = ? WHERE type_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, category.getName());
            statement.setInt(2, category.getType_id());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete component type
    public static void deleteCategory(int id) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM componenttype WHERE type_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get component type by ID
    public static Category getCategoryById(int categoryId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM componenttype WHERE type_id = ?";
        Category category = null;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, categoryId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                category = new Category(
                        rs.getInt("type_id"),
                        rs.getString("name"),
                        "" // No description
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }

    // Get component types by page
    public static ArrayList<Category> getCategoriesByPage(int page, int size) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        int offset = (page - 1) * size;
        String sql = "SELECT * FROM componenttype LIMIT ? OFFSET ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, size);
            statement.setInt(2, offset);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("type_id"),
                        rs.getString("name"),
                        "" // No description
                );
                list.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get total number of component types
    public static int getTotalCategories() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) AS total FROM componenttype";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get component types by page with sorting
    public static ArrayList<Category> getCategoriesByPageAndSort(int page, int size, String sortOrder) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        int offset = (page - 1) * size;
        String orderBy = "ORDER BY name " + ("desc".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC");
        if ("default".equalsIgnoreCase(sortOrder)) {
            orderBy = "ORDER BY type_id ASC";
        }
        
        String sql = "SELECT * FROM componenttype " + orderBy + " LIMIT ? OFFSET ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, size);
            statement.setInt(2, offset);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("type_id"),
                        rs.getString("name"),
                        "" // No description
                );
                list.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Search component types with pagination
    public static ArrayList<Category> searchCategoryWithPaging(String categoryName, int page, int size) {
        DBContext db = DBContext.getInstance();
        ArrayList<Category> list = new ArrayList<>();
        int offset = (page - 1) * size;
        String sql = "SELECT * FROM componenttype WHERE name LIKE ? LIMIT ? OFFSET ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + categoryName + "%");
            statement.setInt(2, size);
            statement.setInt(3, offset);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("type_id"),
                        rs.getString("name"),
                        "" // No description
                );
                list.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get total search results count
    public static int getTotalSearchResults(String categoryName) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) AS total FROM componenttype WHERE name LIKE ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + categoryName + "%");
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
