package dal;

import model.MenuAttributeValue;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, menuAttributeValue.getAttributeId());
            statement.setString(2, menuAttributeValue.getValue());
            statement.setString(3, menuAttributeValue.getUrl());
            statement.setString(4, menuAttributeValue.getStatus());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update menu attribute value
    public static void updateMenuAttributeValue(MenuAttributeValue menuAttributeValue) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE menu_attribute_value SET attribute_id = ?, value = ?, url = ?, status = ? WHERE value_id = ?";
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
} 