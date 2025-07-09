package dal;

import model.MenuAttributeValue;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Connection;

public class MenuAttributeValueDAO {

    // Get all menu attribute values
    public static ArrayList<MenuAttributeValue> getAllMenuAttributeValues() {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttributeValue> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute_value";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttributeValue menuAttributeValue = new MenuAttributeValue(
                        rs.getInt("value_id"),
                        rs.getInt("attribute_id"),
                        rs.getString("value"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttributeValue);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Get menu attribute value by ID
    public static MenuAttributeValue getMenuAttributeValueById(int valueId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM menu_attribute_value WHERE value_id = ?";
        MenuAttributeValue menuAttributeValue = null;
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, valueId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                menuAttributeValue = new MenuAttributeValue(
                        rs.getInt("value_id"),
                        rs.getInt("attribute_id"),
                        rs.getString("value"),
                        rs.getString("url"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuAttributeValue;
    }

    // Get menu attribute values by attribute ID
    public static ArrayList<MenuAttributeValue> getMenuAttributeValuesByAttributeId(int attributeId) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttributeValue> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute_value WHERE attribute_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, attributeId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttributeValue menuAttributeValue = new MenuAttributeValue(
                        rs.getInt("value_id"),
                        rs.getInt("attribute_id"),
                        rs.getString("value"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttributeValue);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Add new menu attribute value
    public static void addMenuAttributeValue(MenuAttributeValue menuAttributeValue) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO menu_attribute_value(attribute_id, value, url, status) VALUES (?, ?, ?, ?)";
        System.out.println("Executing SQL for addMenuAttributeValue: " + sql); // DEBUG
        System.out.println("Params: " + menuAttributeValue.getAttributeId() + ", " + menuAttributeValue.getValue() + ", " + menuAttributeValue.getUrl() + ", " + menuAttributeValue.getStatus()); // DEBUG
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuAttributeValue.getAttributeId());
            statement.setString(2, menuAttributeValue.getValue());
            statement.setString(3, menuAttributeValue.getUrl());
            statement.setString(4, menuAttributeValue.getStatus());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error adding MenuAttributeValue: " + e.getMessage()); // DEBUG
        }
    }

    // Update menu attribute value
    public static void updateMenuAttributeValue(MenuAttributeValue menuAttributeValue) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE menu_attribute_value SET attribute_id = ?, value = ?, url = ?, status = ? WHERE value_id = ?";
        System.out.println("Executing SQL for updateMenuAttributeValue: " + sql); // DEBUG
        System.out.println("Params: " + menuAttributeValue.getAttributeId() + ", " + menuAttributeValue.getValue() + ", " + menuAttributeValue.getUrl() + ", " + menuAttributeValue.getStatus() + ", " + menuAttributeValue.getValueId()); // DEBUG
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuAttributeValue.getAttributeId());
            statement.setString(2, menuAttributeValue.getValue());
            statement.setString(3, menuAttributeValue.getUrl());
            statement.setString(4, menuAttributeValue.getStatus());
            statement.setInt(5, menuAttributeValue.getValueId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating MenuAttributeValue: " + e.getMessage()); // DEBUG
        }
    }

    // Delete menu attribute value
    public static void deleteMenuAttributeValue(int valueId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM menu_attribute_value WHERE value_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, valueId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get active menu attribute values
    public static ArrayList<MenuAttributeValue> getActiveMenuAttributeValues() {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttributeValue> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute_value WHERE status = 'Activate'";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttributeValue menuAttributeValue = new MenuAttributeValue(
                        rs.getInt("value_id"),
                        rs.getInt("attribute_id"),
                        rs.getString("value"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttributeValue);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Get active menu attribute values by attribute ID
    public static ArrayList<MenuAttributeValue> getActiveMenuAttributeValuesByAttributeId(int attributeId) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttributeValue> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute_value WHERE attribute_id = ? AND status = 'Activate'";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, attributeId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttributeValue menuAttributeValue = new MenuAttributeValue(
                        rs.getInt("value_id"),
                        rs.getInt("attribute_id"),
                        rs.getString("value"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttributeValue);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Search menu attribute values by value
    public static ArrayList<MenuAttributeValue> searchMenuAttributeValues(String value) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttributeValue> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute_value WHERE value LIKE ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + value + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                MenuAttributeValue menuAttributeValue = new MenuAttributeValue(
                        rs.getInt("value_id"),
                        rs.getInt("attribute_id"),
                        rs.getString("value"),
                        rs.getString("url"),
                        rs.getString("status")
                );
                list.add(menuAttributeValue);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Get menu attribute values with pagination, sorting and searching
    public static ArrayList<MenuAttributeValue> getMenuAttributeValues(String search, String sortOrder, int offset, int limit) {
        ArrayList<MenuAttributeValue> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM (");
        sql.append("    SELECT ROW_NUMBER() OVER (");
        
        // Add sorting
        if ("asc".equals(sortOrder)) {
            sql.append("ORDER BY value ASC");
        } else if ("desc".equals(sortOrder)) {
            sql.append("ORDER BY value DESC");
        } else if ("status_asc".equals(sortOrder)) {
            sql.append("ORDER BY status ASC");
        } else if ("status_desc".equals(sortOrder)) {
            sql.append("ORDER BY status DESC");
        } else {
            sql.append("ORDER BY value_id ASC");
        }
        
        sql.append(") AS RowNum, mav.*, ma.name as attribute_name ");
        sql.append("FROM menu_attribute_value mav ");
        sql.append("LEFT JOIN menu_attribute ma ON mav.attribute_id = ma.attribute_id ");
        
        // Add search condition if provided
        if (search != null && !search.trim().isEmpty()) {
            sql.append("WHERE mav.value LIKE ? OR mav.url LIKE ? OR ma.name LIKE ? ");
        }
        
        sql.append(") AS ResultSet ");
        sql.append("WHERE RowNum BETWEEN ? AND ?");
        
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            // Set search parameters if search is provided
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            
            // Set pagination parameters
            ps.setInt(paramIndex++, offset + 1); // SQL Server starts from 1
            ps.setInt(paramIndex, offset + limit);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MenuAttributeValue menuAttributeValue = new MenuAttributeValue(
                    rs.getInt("value_id"),
                    rs.getInt("attribute_id"),
                    rs.getString("value"),
                    rs.getString("url"),
                    rs.getString("status")
                );
                list.add(menuAttributeValue);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Count total menu attribute values with search
    public static int countMenuAttributeValues(String search) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM menu_attribute_value mav ");
        sql.append("LEFT JOIN menu_attribute ma ON mav.attribute_id = ma.attribute_id ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append("WHERE mav.value LIKE ? OR mav.url LIKE ? OR ma.name LIKE ? ");
        }
        
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(1, searchPattern);
                ps.setString(2, searchPattern);
                ps.setString(3, searchPattern);
            }
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }
} 