package Product_Management.dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import Product_Management.model.*;

//Them "connection" trong DBContext

public class ProductDAO {
    public Vector<Products> getAllProduct() {
        Vector<Products> listProduct = new Vector<>();
        String sql = "SELECT * FROM products";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                String jsonSpec = rs.getString("spec_description");

                Products p = new Products(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("brand"),
                        rs.getInt("category_id"),
                        rs.getDouble("price"),
                        rs.getInt("stock"),
                        rs.getString("status"),
                        rs.getString("image_url"),
                        rs.getString("description"),
                        jsonSpec
                );
                listProduct.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listProduct;
    }
}