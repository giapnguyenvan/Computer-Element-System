package dal;

import model.Brand;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {
    
    public List<Brand> getAllBrands() {
        DBContext db = DBContext.getInstance();
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM brand ORDER BY name";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("brand_id"));
                brand.setName(rs.getString("name"));
                brand.setDescription(rs.getString("description"));
                brands.add(brand);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return brands;
    }
    
    public Brand getBrandById(int brandId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM brand WHERE brand_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, brandId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("brand_id"));
                brand.setName(rs.getString("name"));
                brand.setDescription(rs.getString("description"));
                return brand;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
} 