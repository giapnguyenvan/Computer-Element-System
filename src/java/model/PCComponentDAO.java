package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PCComponentDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public PCComponentDAO() {
        try {
            DBContext dbContext = new DBContext();
            conn = dbContext.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<PCComponent> getComponentsByType(String type) {
        List<PCComponent> components = new ArrayList<>();
        String query = "SELECT * FROM PCComponents WHERE type = ? AND stock > 0";
        
        try {
            if (conn == null) {
                try {
                    DBContext dbContext = new DBContext();
                    conn = dbContext.getConnection();
                } catch (Exception e) {
                    e.printStackTrace();
                    return components;
                }
            }
            
            ps = conn.prepareStatement(query);
            ps.setString(1, type);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                PCComponent component = new PCComponent(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    rs.getString("image"),
                    rs.getInt("stock"),
                    rs.getString("specifications")
                );
                components.add(component);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return components;
    }

    public PCComponent getComponentById(int id) {
        String query = "SELECT * FROM PCComponents WHERE id = ?";
        
        try {
            if (conn == null) {
                try {
                    DBContext dbContext = new DBContext();
                    conn = dbContext.getConnection();
                } catch (Exception e) {
                    e.printStackTrace();
                    return null;
                }
            }
            
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return new PCComponent(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("type"),
                    rs.getDouble("price"),
                    rs.getString("description"),
                    rs.getString("image"),
                    rs.getInt("stock"),
                    rs.getString("specifications")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return null;
    }

    public boolean updateStock(int componentId, int quantity) {
        String query = "UPDATE PCComponents SET stock = stock - ? WHERE id = ? AND stock >= ?";
        
        try {
            if (conn == null) {
                try {
                    DBContext dbContext = new DBContext();
                    conn = dbContext.getConnection();
                } catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }
            }
            
            ps = conn.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setInt(2, componentId);
            ps.setInt(3, quantity);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
} 