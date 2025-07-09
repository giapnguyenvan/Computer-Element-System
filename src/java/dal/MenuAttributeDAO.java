package dal;

import model.MenuAttribute;
import model.MenuAttributeValue;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Connection;

public class MenuAttributeDAO {

    // Get all menu attributes with sorting and searching
    public static ArrayList<MenuAttribute> getAllMenuAttributes(String search, String sortOrder) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT ma.*, mi.name as menu_item_name FROM menu_attribute ma ");
        sql.append("LEFT JOIN menu_item mi ON ma.menu_item_id = mi.menu_item_id ");
        
        // Add search condition if provided
        if (search != null && !search.trim().isEmpty()) {
            sql.append("WHERE ma.name LIKE ? OR ma.url LIKE ? OR mi.name LIKE ? ");
        }
        
        // Add sorting
        if ("asc".equals(sortOrder)) {
            sql.append("ORDER BY ma.name ASC");
        } else if ("desc".equals(sortOrder)) {
            sql.append("ORDER BY ma.name DESC");
        } else if ("status_asc".equals(sortOrder)) {
            sql.append("ORDER BY ma.status ASC");
        } else if ("status_desc".equals(sortOrder)) {
            sql.append("ORDER BY ma.status DESC");
        } else {
            sql.append("ORDER BY ma.attribute_id ASC");
        }
        
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql.toString());
            
            // Set search parameters if search is provided
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                statement.setString(1, searchPattern);
                statement.setString(2, searchPattern);
                statement.setString(3, searchPattern);
            }
            
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttribute menuAttribute = new MenuAttribute(
                    rs.getInt("attribute_id"),
                    rs.getInt("menu_item_id"),
                    rs.getString("name"),
                    rs.getString("url"),
                    rs.getString("status")
                );
                list.add(menuAttribute);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Get menu attribute by ID
    public static MenuAttribute getMenuAttributeById(int attributeId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM menu_attribute WHERE attribute_id = ?";
        MenuAttribute menuAttribute = null;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, attributeId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                menuAttribute = new MenuAttribute(
                        rs.getInt("attribute_id"),
                        rs.getInt("menu_item_id"),
                        rs.getString("name"),
                        rs.getString("url"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuAttribute;
    }

    // Get menu attributes by menu item ID
    public static ArrayList<MenuAttribute> getMenuAttributesByMenuItemId(int menuItemId) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute WHERE menu_item_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuItemId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttribute menuAttribute = new MenuAttribute(
                        rs.getInt("attribute_id"),
                        rs.getInt("menu_item_id"),
                        rs.getString("name"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttribute);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Add new menu attribute
    public static void addMenuAttribute(MenuAttribute menuAttribute) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO menu_attribute(menu_item_id, name, url, status) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuAttribute.getMenuItemId());
            statement.setString(2, menuAttribute.getName());
            statement.setString(3, menuAttribute.getUrl());
            statement.setString(4, menuAttribute.getStatus());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update menu attribute
    public static void updateMenuAttribute(MenuAttribute menuAttribute) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE menu_attribute SET menu_item_id = ?, name = ?, url = ?, status = ? WHERE attribute_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuAttribute.getMenuItemId());
            statement.setString(2, menuAttribute.getName());
            statement.setString(3, menuAttribute.getUrl());
            statement.setString(4, menuAttribute.getStatus());
            statement.setInt(5, menuAttribute.getAttributeId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete menu attribute
    public static void deleteMenuAttribute(int attributeId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM menu_attribute WHERE attribute_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, attributeId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get active menu attributes
    public static ArrayList<MenuAttribute> getActiveMenuAttributes() {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute WHERE status = 'Activate'";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttribute menuAttribute = new MenuAttribute(
                        rs.getInt("attribute_id"),
                        rs.getInt("menu_item_id"),
                        rs.getString("name"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttribute);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Get active menu attributes by menu item ID
    public static ArrayList<MenuAttribute> getActiveMenuAttributesByMenuItemId(int menuItemId) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute WHERE menu_item_id = ? AND status = 'Activate'";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuItemId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttribute menuAttribute = new MenuAttribute(
                        rs.getInt("attribute_id"),
                        rs.getInt("menu_item_id"),
                        rs.getString("name"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttribute);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // New method to get active menu attributes with their values by menu item ID
    public static ArrayList<MenuAttribute> getActiveMenuAttributesWithValuesByMenuItemId(int menuItemId) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> attributes = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute WHERE menu_item_id = ? AND status = 'Activate'";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuItemId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttribute menuAttribute = new MenuAttribute(
                        rs.getInt("attribute_id"),
                        rs.getInt("menu_item_id"),
                        rs.getString("name"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                // Set the list of MenuAttributeValues for this MenuAttribute
                menuAttribute.setMenuAttributeValues(MenuAttributeValueDAO.getActiveMenuAttributeValuesByAttributeId(menuAttribute.getAttributeId()));
                attributes.add(menuAttribute);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return attributes;
    }

    // Search menu attributes by name, url, or menu item name
    public static ArrayList<MenuAttribute> searchMenuAttributes(String name) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        String sql = "SELECT ma.*, mi.name as menu_item_name FROM menu_attribute ma " +
                     "LEFT JOIN menu_item mi ON ma.menu_item_id = mi.menu_item_id " +
                     "WHERE ma.name LIKE ? OR ma.url LIKE ? OR mi.name LIKE ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            String searchPattern = "%" + name + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttribute menuAttribute = new MenuAttribute(
                        rs.getInt("attribute_id"),
                        rs.getInt("menu_item_id"),
                        rs.getString("name"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttribute);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Lấy danh sách menu attribute có phân trang, tìm kiếm, sắp xếp
    public static ArrayList<MenuAttribute> getMenuAttributes(String search, String sortOrder, int offset, int limit) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT ma.*, mi.name as menu_item_name FROM menu_attribute ma ");
        sql.append("LEFT JOIN menu_item mi ON ma.menu_item_id = mi.menu_item_id ");
        
        // Add search condition if provided
        if (search != null && !search.trim().isEmpty()) {
            sql.append("WHERE ma.name LIKE ? OR ma.url LIKE ? OR mi.name LIKE ? ");
        }
        
        // Add sorting
        if ("asc".equals(sortOrder)) {
            sql.append("ORDER BY ma.name ASC");
        } else if ("desc".equals(sortOrder)) {
            sql.append("ORDER BY ma.name DESC");
        } else if ("status_asc".equals(sortOrder)) {
            sql.append("ORDER BY ma.status ASC");
        } else if ("status_desc".equals(sortOrder)) {
            sql.append("ORDER BY ma.status DESC");
        } else {
            sql.append("ORDER BY ma.attribute_id ASC");
        }
        
        sql.append(" LIMIT ? OFFSET ?");

        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql.toString());
            
            // Set search parameters if search is provided
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                statement.setString(paramIndex++, searchPattern);
                statement.setString(paramIndex++, searchPattern);
                statement.setString(paramIndex++, searchPattern);
            }
            statement.setInt(paramIndex++, limit);
            statement.setInt(paramIndex, offset);
            
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttribute menuAttribute = new MenuAttribute(
                    rs.getInt("attribute_id"),
                    rs.getInt("menu_item_id"),
                    rs.getString("name"),
                    rs.getString("url"),
                    rs.getString("status")
                );
                list.add(menuAttribute);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Count total menu attributes (can be filtered by search)
    public static int countMenuAttributes(String search) {
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM menu_attribute ma ");
        sql.append("LEFT JOIN menu_item mi ON ma.menu_item_id = mi.menu_item_id ");

        if (search != null && !search.trim().isEmpty()) {
            sql.append("WHERE ma.name LIKE ? OR ma.url LIKE ? OR mi.name LIKE ? ");
        }

        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql.toString());
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                statement.setString(1, searchPattern);
                statement.setString(2, searchPattern);
                statement.setString(3, searchPattern);
            }
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }
} 