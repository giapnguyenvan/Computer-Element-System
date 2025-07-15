/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.List;
import java.util.ArrayList;
import model.*;

/**
 *
 * @author nghia
 */
public class InventoryLogDAO {

    public Vector<InventoryLog> getAllLogs() {
        DBContext db = DBContext.getInstance();
        Vector<InventoryLog> listLogs = new Vector<>();

        String sql = """
                SELECT
                    l.log_id,
                    l.product_id,
                    p.name as product_name,
                    l.action,
                    l.quantity,
                    l.note,
                    l.created_at,
                    b.name as brand_name,
                    ct.name as component_type_name
                FROM
                    InventoryLog l
                LEFT JOIN
                    Product p ON l.product_id = p.product_id
                LEFT JOIN
                    Brand b ON p.brand_id = b.brand_id
                LEFT JOIN
                    ComponentType ct ON p.component_type_id = ct.type_id
                ORDER BY
                    l.created_at DESC
                """;

        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();

            while (rs.next()) {
                InventoryLog log = new InventoryLog(
                        rs.getInt("log_id"),
                        rs.getInt("product_id"),
                        rs.getString("action"),
                        rs.getInt("quantity"),
                        rs.getString("note"),
                        rs.getTimestamp("created_at")
                );
                listLogs.add(log);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return listLogs;
    }

    public boolean insertLog(InventoryLog log) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO InventoryLog (product_id, action, quantity, note, created_at) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ptm = db.getConnection().prepareStatement(sql)) {
            ptm.setInt(1, log.getProduct_id());
            ptm.setString(2, log.getAction());
            ptm.setInt(3, log.getQuantity());
            ptm.setString(4, log.getNote());
            ptm.setTimestamp(5, log.getCreated_at());
            return ptm.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
}
