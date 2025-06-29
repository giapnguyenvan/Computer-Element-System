package dal;

import model.MenuAttribute;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MenuAttributeDAO {

    // Get all menu attributes
    public static ArrayList<MenuAttribute> getAllMenuAttributes() {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute";
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

    // Search menu attributes by name
    public static ArrayList<MenuAttribute> searchMenuAttributes(String name) {
        DBContext db = DBContext.getInstance();
        ArrayList<MenuAttribute> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_attribute WHERE name LIKE ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + name + "%");
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
} 