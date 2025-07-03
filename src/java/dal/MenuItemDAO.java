package dal;

import model.MenuItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MenuItemDAO {
    public static List<MenuItem> getAllMenuItems() {
        List<MenuItem> list = new ArrayList<>();
        String sql = "SELECT menu_item_id, name, icon, url, parent_id, status FROM menu_item WHERE status = 'Activate'";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                MenuItem item = new MenuItem();
                item.setMenuItemId(rs.getInt("menu_item_id"));
                item.setName(rs.getString("name"));
                item.setIcon(rs.getString("icon"));
                item.setUrl(rs.getString("url"));
                Object parentId = rs.getObject("parent_id");
                item.setParentId(parentId != null ? rs.getInt("parent_id") : null);
                item.setStatus(rs.getString("status"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static MenuItem getMenuItemById(int id) {
        String sql = "SELECT menu_item_id, name, icon, url, parent_id, status FROM menu_item WHERE menu_item_id = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    MenuItem item = new MenuItem();
                    item.setMenuItemId(rs.getInt("menu_item_id"));
                    item.setName(rs.getString("name"));
                    item.setIcon(rs.getString("icon"));
                    item.setUrl(rs.getString("url"));
                    Object parentId = rs.getObject("parent_id");
                    item.setParentId(parentId != null ? rs.getInt("parent_id") : null);
                    item.setStatus(rs.getString("status"));
                    return item;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean addMenuItem(MenuItem item) {
        String sql = "INSERT INTO menu_item (name, icon, url, parent_id, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getIcon());
            ps.setString(3, item.getUrl());
            if (item.getParentId() != null) {
                ps.setInt(4, item.getParentId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            ps.setString(5, item.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateMenuItem(MenuItem item) {
        String sql = "UPDATE menu_item SET name = ?, icon = ?, url = ?, parent_id = ?, status = ? WHERE menu_item_id = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getIcon());
            ps.setString(3, item.getUrl());
            if (item.getParentId() != null) {
                ps.setInt(4, item.getParentId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            ps.setString(5, item.getStatus());
            ps.setInt(6, item.getMenuItemId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean setMenuItemStatus(int id, String status) {
        String sql = "UPDATE menu_item SET status = ? WHERE menu_item_id = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách menu item có phân trang, tìm kiếm, sắp xếp
    public static List<MenuItem> getMenuItems(String search, String sort, int offset, int limit) {
        List<MenuItem> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT menu_item_id, name, icon, url, parent_id, status FROM menu_item WHERE 1=1");
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR url LIKE ?)");
        }
        if (sort != null) {
            if ("asc".equals(sort)) sql.append(" ORDER BY name ASC");
            else if ("desc".equals(sort)) sql.append(" ORDER BY name DESC");
            else if ("status".equals(sort)) sql.append(" ORDER BY status ASC");
            else if ("status_desc".equals(sort)) sql.append(" ORDER BY status DESC");
            else sql.append(" ORDER BY menu_item_id ASC");
        } else {
            sql.append(" ORDER BY menu_item_id ASC");
        }
        sql.append(" LIMIT ? OFFSET ?");
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }
            ps.setInt(idx++, limit);
            ps.setInt(idx, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MenuItem item = new MenuItem();
                    item.setMenuItemId(rs.getInt("menu_item_id"));
                    item.setName(rs.getString("name"));
                    item.setIcon(rs.getString("icon"));
                    item.setUrl(rs.getString("url"));
                    Object parentId = rs.getObject("parent_id");
                    item.setParentId(parentId != null ? rs.getInt("parent_id") : null);
                    item.setStatus(rs.getString("status"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số menu item (có thể lọc theo search)
    public static int countMenuItems(String search) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM menu_item WHERE 1=1");
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR url LIKE ?)");
        }
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
} 