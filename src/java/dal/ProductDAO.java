package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import model.Products;

public class ProductDAO {

    public Vector<Products> getAllProduct() {
        DBContext db = DBContext.getInstance();
        Vector<Products> listProduct = new Vector<>();
        String sql = """
            SELECT
                p.product_id,
                p.name,
                p.component_type_id,
                p.brand_id,
                p.series_id,
                p.model,
                p.price,
                p.import_price,
                p.stock,
                p.sku,
                p.description,
                p.status,
                p.created_at,
                b.name AS brand_name,
                ct.name AS component_type_name,
                s.name AS series_name,
                (
                    SELECT image_url
                    FROM productimage pi
                    WHERE pi.product_id = p.product_id AND pi.is_primary = TRUE
                    LIMIT 1
                ) AS image_url
            FROM
                product p
            JOIN
                brand b ON p.brand_id = b.brand_id
            JOIN
                componenttype ct ON p.component_type_id = ct.type_id
            LEFT JOIN
                series s ON p.series_id = s.series_id
            """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setComponentTypeId(rs.getInt("component_type_id"));
                p.setBrandId(rs.getInt("brand_id"));
                p.setSeriesId(rs.getObject("series_id") != null ? rs.getInt("series_id") : null);
                p.setModel(rs.getString("model"));
                p.setPrice(rs.getDouble("price"));
                p.setImportPrice(rs.getObject("import_price") != null ? rs.getDouble("import_price") : null);
                p.setStock(rs.getInt("stock"));
                p.setSku(rs.getString("sku"));
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setBrandName(rs.getString("brand_name"));
                p.setComponentTypeName(rs.getString("component_type_name"));
                p.setSeriesName(rs.getString("series_name"));
                p.setImageUrl(rs.getString("image_url"));
                listProduct.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listProduct;
    }

    public int getTotalProductsByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM product WHERE component_type_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, componentTypeId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public List<Products> getProductsWithPagingByComponentType(int componentTypeId, int page, int productsPerPage) {
        DBContext db = DBContext.getInstance();
        List<Products> list = new ArrayList<>();
        String sql = """
            SELECT
                p.product_id,
                p.name,
                p.component_type_id,
                p.brand_id,
                p.series_id,
                p.model,
                p.price,
                p.import_price,
                p.stock,
                p.sku,
                p.description,
                p.status,
                p.created_at,
                b.name AS brand_name,
                ct.name AS component_type_name,
                s.name AS series_name,
                (
                    SELECT image_url
                    FROM productimage pi
                    WHERE pi.product_id = p.product_id AND pi.is_primary = TRUE
                    LIMIT 1
                ) AS image_url
            FROM
                product p
            JOIN
                brand b ON p.brand_id = b.brand_id
            JOIN
                componenttype ct ON p.component_type_id = ct.type_id
            LEFT JOIN
                series s ON p.series_id = s.series_id
            WHERE
                p.component_type_id = ?
            ORDER BY p.product_id
            LIMIT ? OFFSET ?
            """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, componentTypeId);
            ptm.setInt(2, productsPerPage);
            ptm.setInt(3, (page - 1) * productsPerPage);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setComponentTypeId(rs.getInt("component_type_id"));
                p.setBrandId(rs.getInt("brand_id"));
                p.setSeriesId(rs.getObject("series_id") != null ? rs.getInt("series_id") : null);
                p.setModel(rs.getString("model"));
                p.setPrice(rs.getDouble("price"));
                p.setImportPrice(rs.getObject("import_price") != null ? rs.getDouble("import_price") : null);
                p.setStock(rs.getInt("stock"));
                p.setSku(rs.getString("sku"));
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setBrandName(rs.getString("brand_name"));
                p.setComponentTypeName(rs.getString("component_type_name"));
                p.setSeriesName(rs.getString("series_name"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Products getProductById(int productId) {
        DBContext db = DBContext.getInstance();
        Products p = null;
        String sql = """
            SELECT
                p.product_id,
                p.name,
                p.component_type_id,
                p.brand_id,
                p.series_id,
                p.model,
                p.price,
                p.import_price,
                p.stock,
                p.sku,
                p.description,
                p.status,
                p.created_at,
                b.name AS brand_name,
                ct.name AS component_type_name,
                s.name AS series_name,
                (
                    SELECT image_url
                    FROM productimage pi
                    WHERE pi.product_id = p.product_id AND pi.is_primary = TRUE
                    LIMIT 1
                ) AS image_url
            FROM
                product p
            JOIN
                brand b ON p.brand_id = b.brand_id
            JOIN
                componenttype ct ON p.component_type_id = ct.type_id
            LEFT JOIN
                series s ON p.series_id = s.series_id
            WHERE p.product_id = ?
            """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                p = new Products();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setComponentTypeId(rs.getInt("component_type_id"));
                p.setBrandId(rs.getInt("brand_id"));
                p.setSeriesId(rs.getObject("series_id") != null ? rs.getInt("series_id") : null);
                p.setModel(rs.getString("model"));
                p.setPrice(rs.getDouble("price"));
                p.setImportPrice(rs.getObject("import_price") != null ? rs.getDouble("import_price") : null);
                p.setStock(rs.getInt("stock"));
                p.setSku(rs.getString("sku"));
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setBrandName(rs.getString("brand_name"));
                p.setComponentTypeName(rs.getString("component_type_name"));
                p.setSeriesName(rs.getString("series_name"));
                p.setImageUrl(rs.getString("image_url"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return p;
    }

    public void insertProduct(Products p) {
        DBContext db = DBContext.getInstance();
        String sql = """
        INSERT INTO product (name, component_type_id, brand_id, series_id, model, price, import_price, stock, sku, description, status, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, p.getName());
            ptm.setInt(2, p.getComponentTypeId());
            ptm.setInt(3, p.getBrandId());
            if (p.getSeriesId() != null) {
                ptm.setInt(4, p.getSeriesId());
            } else {
                ptm.setNull(4, java.sql.Types.INTEGER);
            }
            ptm.setString(5, p.getModel());
            ptm.setDouble(6, p.getPrice());
            if (p.getImportPrice() != null) {
                ptm.setDouble(7, p.getImportPrice());
            } else {
                ptm.setNull(7, java.sql.Types.DOUBLE);
            }
            ptm.setInt(8, p.getStock());
            ptm.setString(9, p.getSku());
            ptm.setString(10, p.getDescription());
            ptm.setString(11, p.getStatus());
            ptm.setTimestamp(12, p.getCreatedAt());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public boolean updateProduct(Products p) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE product SET
                name = ?,
                component_type_id = ?,
                brand_id = ?,
                series_id = ?,
                model = ?,
                price = ?,
                import_price = ?,
                stock = ?,
                sku = ?,
                description = ?,
                status = ?,
                created_at = ?
            WHERE product_id = ?
            """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, p.getName());
            ptm.setInt(2, p.getComponentTypeId());
            ptm.setInt(3, p.getBrandId());
            if (p.getSeriesId() != null) {
                ptm.setInt(4, p.getSeriesId());
            } else {
                ptm.setNull(4, java.sql.Types.INTEGER);
            }
            ptm.setString(5, p.getModel());
            ptm.setDouble(6, p.getPrice());
            if (p.getImportPrice() != null) {
                ptm.setDouble(7, p.getImportPrice());
            } else {
                ptm.setNull(7, java.sql.Types.DOUBLE);
            }
            ptm.setInt(8, p.getStock());
            ptm.setString(9, p.getSku());
            ptm.setString(10, p.getDescription());
            ptm.setString(11, p.getStatus() != null ? p.getStatus() : "Active");
            ptm.setTimestamp(12, p.getCreatedAt());
            ptm.setInt(13, p.getProductId());
            int rowsAffected = ptm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public Vector<String> getAllBrands() {
        DBContext db = DBContext.getInstance();
        Vector<String> brands = new Vector<>();
        String sql = "SELECT DISTINCT name FROM brand";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                brands.add(rs.getString("name"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return brands;
    }

    public Vector<String> getBrandsByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<String> brands = new Vector<>();
        String sql = """
            SELECT DISTINCT b.name
            FROM product p
            JOIN brand b ON p.brand_id = b.brand_id
            WHERE p.component_type_id = ?
            ORDER BY b.name
            """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, componentTypeId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                brands.add(rs.getString("name"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return brands;
    }

    public Vector<String> getSeriesByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<String> series = new Vector<>();
        String sql = """
            SELECT DISTINCT s.name
            FROM series s
            JOIN product p ON p.series_id = s.series_id
            WHERE p.component_type_id = ? AND s.name IS NOT NULL
            ORDER BY s.name
            """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, componentTypeId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                series.add(rs.getString("name"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return series;
    }

    public Vector<String> getModelStringByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<String> models = new Vector<>();
        String sql = "SELECT DISTINCT model FROM product WHERE component_type_id = ? AND model IS NOT NULL";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, componentTypeId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                models.add(rs.getString("model"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return models;
    }

    public Vector<Products> getProductsByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<Products> listProduct = new Vector<>();
        String sql = """
            SELECT
                p.product_id,
                p.name,
                p.component_type_id,
                p.brand_id,
                p.series_id,
                p.model,
                p.price,
                p.import_price,
                p.stock,
                p.sku,
                p.description,
                p.status,
                p.created_at,
                b.name AS brand_name,
                ct.name AS component_type_name,
                s.name AS series_name,
                (
                    SELECT image_url
                    FROM productimage pi
                    WHERE pi.product_id = p.product_id AND pi.is_primary = TRUE
                    LIMIT 1
                ) AS image_url
            FROM
                product p
            JOIN
                brand b ON p.brand_id = b.brand_id
            JOIN
                componenttype ct ON p.component_type_id = ct.type_id
            LEFT JOIN
                series s ON p.series_id = s.series_id
            WHERE
                p.component_type_id = ?
            """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, componentTypeId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setComponentTypeId(rs.getInt("component_type_id"));
                p.setBrandId(rs.getInt("brand_id"));
                p.setSeriesId(rs.getObject("series_id") != null ? rs.getInt("series_id") : null);
                p.setModel(rs.getString("model"));
                p.setPrice(rs.getDouble("price"));
                p.setImportPrice(rs.getObject("import_price") != null ? rs.getDouble("import_price") : null);
                p.setStock(rs.getInt("stock"));
                p.setSku(rs.getString("sku"));
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setBrandName(rs.getString("brand_name"));
                p.setComponentTypeName(rs.getString("component_type_name"));
                p.setSeriesName(rs.getString("series_name"));
                p.setImageUrl(rs.getString("image_url"));
                listProduct.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listProduct;
    }

    public int getBrandIdByName(String brandName) {
        String sql = "SELECT brand_id FROM brand WHERE name = ?";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setString(1, brandName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("brand_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void insertBrand(String brandName) {
        String sql = "INSERT INTO brand(name) VALUES(?)";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setString(1, brandName);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int getComponentTypeIdByName(String typeName) {
        String sql = "SELECT type_id FROM componenttype WHERE name = ?";
        try {
            PreparedStatement ptm = DBContext.getInstance().getConnection().prepareStatement(sql);
            ptm.setString(1, typeName);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt("type_id");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public void insertComponentType(String typeName) {
        String sql = "INSERT INTO componenttype(name) VALUES(?)";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setString(1, typeName);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Products importFilter(String name, int brandId, int componentTypeId) {
        DBContext db = DBContext.getInstance();
        String sql = """
        SELECT
            p.product_id,
            p.name,
            p.component_type_id,
            p.brand_id,
            p.series_id,
            p.model,
            p.price,
            p.import_price,
            p.stock,
            p.sku,
            p.description,
            p.status,
            p.created_at,
            b.name AS brand_name,
            ct.name AS component_type_name,
            s.name AS series_name,
            (
                SELECT image_url
                FROM productimage pi
                WHERE pi.product_id = p.product_id AND pi.is_primary = TRUE
                LIMIT 1
            ) AS image_url
        FROM product p
        JOIN brand b ON p.brand_id = b.brand_id
        JOIN componenttype ct ON p.component_type_id = ct.type_id
        LEFT JOIN series s ON p.series_id = s.series_id
        WHERE p.name = ? AND p.brand_id = ? AND p.component_type_id = ?
        LIMIT 1
    """;

        try (PreparedStatement ptm = db.getConnection().prepareStatement(sql)) {
            ptm.setString(1, name);
            ptm.setInt(2, brandId);
            ptm.setInt(3, componentTypeId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Products p = new Products();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setComponentTypeId(rs.getInt("component_type_id"));
                p.setBrandId(rs.getInt("brand_id"));
                p.setSeriesId(rs.getObject("series_id") != null ? rs.getInt("series_id") : null);
                p.setModel(rs.getString("model"));
                p.setPrice(rs.getDouble("price"));
                p.setImportPrice(rs.getObject("import_price") != null ? rs.getDouble("import_price") : null);
                p.setStock(rs.getInt("stock"));
                p.setSku(rs.getString("sku"));
                p.setDescription(rs.getString("description"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setBrandName(rs.getString("brand_name"));
                p.setComponentTypeName(rs.getString("component_type_name"));
                p.setSeriesName(rs.getString("series_name"));
                p.setImageUrl(rs.getString("image_url"));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStock(Products p) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE product SET stock = ? WHERE product_id = ?";

        try (PreparedStatement ptm = db.getConnection().prepareStatement(sql)) {
            ptm.setInt(1, p.getStock());
            ptm.setInt(2, p.getProductId());
            return ptm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePriceStock(Products p) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE product SET price = ?, import_price = ?, stock = ? WHERE product_id = ?";

        try (PreparedStatement ptm = db.getConnection().prepareStatement(sql)) {
            ptm.setDouble(1, p.getPrice());
            if (p.getImportPrice() != null) {
                ptm.setDouble(2, p.getImportPrice());
            } else {
                ptm.setNull(2, java.sql.Types.DOUBLE);
            }
            ptm.setInt(3, p.getStock());
            ptm.setInt(4, p.getProductId());
            return ptm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deactivateProduct(int productId) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE product SET status = 'Inactive' WHERE product_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productId);
            return ptm.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public boolean updateProductImage(int productId, String imageUrl) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE productimage SET image_url = ? WHERE product_id = ? AND is_primary = TRUE";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, imageUrl);
            ptm.setInt(2, productId);
            int rowsAffected = ptm.executeUpdate();
            
            // If no primary image exists, insert one
            if (rowsAffected == 0) {
                sql = "INSERT INTO productimage (product_id, image_url, alt_text, is_primary) VALUES (?, ?, ?, TRUE)";
                ptm = db.getConnection().prepareStatement(sql);
                ptm.setInt(1, productId);
                ptm.setString(2, imageUrl);
                ptm.setString(3, "Product Image");
                return ptm.executeUpdate() > 0;
            }
            
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        Vector<Products> list = dao.getAllProduct();
        for (Products p : list) {
            System.out.println(p);
        }
    }
}
