package dal;


import model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
public class CategoryDAO extends DBContext {
    
    // Lấy tất cả categories
    public Vector<Category> getAllCategories() {
        Vector<Category> listCategory = new Vector<>();
        String sql = "SELECT * FROM categories";
        try {
            PreparedStatement ptm = getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Category c = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                listCategory.add(c);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listCategory;
    }
    
    // Tìm category theo tên
    public Vector<Category> searchCategory(String categoryName) {
        Vector<Category> list = new Vector<>();
        String sql = "SELECT * FROM categories WHERE name LIKE ?";
        try {
            PreparedStatement ptm = getConnection().prepareStatement(sql);
            ptm.setString(1, "%" + categoryName + "%");
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Category c = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                list.add(c);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    // Thêm category mới
    public void insertCategory(Category c) {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        try {
            PreparedStatement ptm = getConnection().prepareStatement(sql);
            ptm.setString(1, c.getName());
            ptm.setString(2, c.getDescription());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    // Cập nhật category
    public void updateCategory(Category c) {
        String sql = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
        try {
            PreparedStatement ptm = getConnection().prepareStatement(sql);
            ptm.setString(1, c.getName());
            ptm.setString(2, c.getDescription());
            ptm.setInt(3, c.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    // Xóa category
    public void deleteCategory(int id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        try {
            PreparedStatement ptm = getConnection().prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    // Lấy category theo ID
    public Category getCategoryById(int categoryId) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        Category c = null;
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                c = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }
} 