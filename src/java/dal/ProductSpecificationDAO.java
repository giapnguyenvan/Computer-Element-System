package dal;

import model.ProductSpecification;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductSpecificationDAO {
    
    public List<ProductSpecification> getSpecificationsByProductId(int productId) {
        DBContext db = DBContext.getInstance();
        List<ProductSpecification> specifications = new ArrayList<>();
        String sql = "SELECT * FROM productspecification WHERE product_id = ? ORDER BY spec_key";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, productId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ProductSpecification spec = new ProductSpecification();
                spec.setSpecId(rs.getInt("spec_id"));
                spec.setProductId(rs.getInt("product_id"));
                spec.setSpecKey(rs.getString("spec_key"));
                spec.setSpecValue(rs.getString("spec_value"));
                specifications.add(spec);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return specifications;
    }
    
    public boolean addSpecification(ProductSpecification spec) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO productspecification (product_id, spec_key, spec_value) VALUES (?, ?, ?)";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, spec.getProductId());
            statement.setString(2, spec.getSpecKey());
            statement.setString(3, spec.getSpecValue());
            return statement.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public boolean updateSpecification(ProductSpecification spec) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE productspecification SET spec_key = ?, spec_value = ? WHERE spec_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, spec.getSpecKey());
            statement.setString(2, spec.getSpecValue());
            statement.setInt(3, spec.getSpecId());
            return statement.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteSpecification(int specId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM productspecification WHERE spec_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, specId);
            return statement.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteSpecificationsByProductId(int productId) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM productspecification WHERE product_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, productId);
            return statement.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
} 