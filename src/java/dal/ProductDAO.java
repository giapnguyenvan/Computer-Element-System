package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import model.*;

//Them "connection" trong DBContext
//----------------------------Get all product
public class ProductDAO {

    public Vector<Products> getAllProduct() {
        DBContext db = DBContext.getInstance();
        Vector<Products> listProduct = new Vector<>();
        // This query is updated to match the new database schema
        String sql = """
                     SELECT
                         p.product_id,
                         p.name,
                         p.description,
                         p.price,
                         p.stock,
                         p.status,
                         p.import_price,
                         p.created_at,
                         p.component_type_id,
                         p.brand_id,
                         b.name as brand_name,
                         ct.name as component_type_name,
                         (SELECT image_url FROM ProductImage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
                     FROM
                         Product p
                     JOIN
                         Brand b ON p.brand_id = b.brand_id
                     JOIN
                         ComponentType ct ON p.component_type_id = ct.type_id
                     """;

        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                // Using the new constructor for Products
                Products p = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null // specDescription - can be set separately if needed
                );
                listProduct.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listProduct;
    }

    public int getTotalCPUProducts() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM Product WHERE component_type_id = 1"; // CPU type_id = 1
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public List<Products> getCPUProductsWithPaging(int page, int productsPerPage) {
        DBContext db = DBContext.getInstance();
        List<Products> list = new ArrayList<>();
        String sql = """
                     SELECT p.*, b.name as brand_name, ct.name as component_type_name,
                            (SELECT image_url FROM ProductImage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
                     FROM Product p
                     JOIN Brand b ON p.brand_id = b.brand_id
                     JOIN ComponentType ct ON p.component_type_id = ct.type_id
                     WHERE p.component_type_id = 1
                     ORDER BY p.product_id
                     LIMIT ? OFFSET ?
                     """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productsPerPage);
            ptm.setInt(2, (page - 1) * productsPerPage);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int getTotalGPUProducts() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM Product WHERE component_type_id = 2"; // GPU type_id = 2
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public List<Products> getGPUProductsWithPaging(int page, int productsPerPage) {
        DBContext db = DBContext.getInstance();
        List<Products> list = new ArrayList<>();
        String sql = """
                     SELECT p.*, b.name as brand_name, ct.name as component_type_name,
                            (SELECT image_url FROM ProductImage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
                     FROM Product p
                     JOIN Brand b ON p.brand_id = b.brand_id
                     JOIN ComponentType ct ON p.component_type_id = ct.type_id
                     WHERE p.component_type_id = 2
                     ORDER BY p.product_id
                     LIMIT ? OFFSET ?
                     """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productsPerPage);
            ptm.setInt(2, (page - 1) * productsPerPage);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int getTotalRAMProducts() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM Product WHERE component_type_id = 4"; // RAM type_id = 4
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public List<Products> getRAMProductsWithPaging(int page, int productsPerPage) {
        DBContext db = DBContext.getInstance();
        List<Products> list = new ArrayList<>();
        String sql = """
                     SELECT p.*, b.name as brand_name, ct.name as component_type_name,
                            (SELECT image_url FROM ProductImage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
                     FROM Product p
                     JOIN Brand b ON p.Brand_id = b.brand_id
                     JOIN ComponentType ct ON p.component_type_id = ct.type_id
                     WHERE p.component_type_id = 4
                     ORDER BY p.product_id
                     LIMIT ? OFFSET ?
                     """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productsPerPage);
            ptm.setInt(2, (page - 1) * productsPerPage);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Vector<Products> getProductByBrand(String brand) {
        DBContext db = DBContext.getInstance();
        Vector<Products> list = new Vector<>();
        String sql = """
                     SELECT
                         p.product_id,
                         p.name,
                         p.description,
                         p.price,
                         p.stock,
                         p.status,
                         p.import_price,
                         p.created_at,
                         p.component_type_id,
                         p.brand_id,
                         b.name as brand_name,
                         ct.name as component_type_name,
                         (SELECT image_url FROM ProductImage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
                     FROM
                         Product p
                     JOIN
                         Brand b ON p.brand_id = b.brand_id
                     JOIN
                         ComponentType ct ON p.component_type_id = ct.type_id
                     WHERE
                         b.name = ?
                     """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, brand);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Vector<Products> getProductByCategory(int categoryId) {
        DBContext db = DBContext.getInstance();
        Vector<Products> list = new Vector<>();
        String sql = "SELECT * FROM products WHERE category_id = ?";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, categoryId);
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
                        rs.getString("image_url"),
                        rs.getString("description"),
                        jsonSpec,
                        rs.getString("status")
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public static Vector<String> getAllBrands() {
        DBContext db = DBContext.getInstance();
        Vector<String> brands = new Vector<>();
        String sql = "SELECT DISTINCT brand FROM products";
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                brands.add(rs.getString("brand"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return brands;
    }

    public List<Products> getSortedProducts(String sortBy, String order) {
        DBContext db = DBContext.getInstance();
        List<Products> list = new ArrayList<>();
        
        // Basic validation to prevent SQL injection
        String sortColumn;
        switch (sortBy.toLowerCase()) {
            case "name":
                sortColumn = "p.name";
                break;
            case "price":
                sortColumn = "p.price";
                break;
            case "id":
            default:
                sortColumn = "p.product_id";
                break;
        }

        String sortOrder = "asc".equalsIgnoreCase(order) ? "ASC" : "DESC";

        String sql = String.format("""
            SELECT
                p.product_id, p.name, p.description, p.price, p.stock, p.status,
                p.import_price, p.created_at, p.component_type_id, p.brand_id,
                b.name as brand_name, ct.name as component_type_name,
                (SELECT image_url FROM productimage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
            FROM product p
            JOIN brand b ON p.brand_id = b.brand_id
            JOIN componenttype ct ON p.component_type_id = ct.type_id
            ORDER BY %s %s
            """, sortColumn, sortOrder);

        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null
                );
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Products getProductById(int productId) {
        DBContext db = DBContext.getInstance();
        Products product = null;
        String sql = """
                     SELECT
                         p.product_id, p.name, p.description, p.price, p.stock, p.status,
                         p.import_price, p.created_at, p.component_type_id, p.brand_id,
                         b.name as brand_name, ct.name as component_type_name,
                         (SELECT image_url FROM productimage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
                     FROM product p
                     JOIN brand b ON p.brand_id = b.brand_id
                     JOIN componenttype ct ON p.component_type_id = ct.type_id
                     WHERE p.product_id = ?
                     """;

        try {
            System.out.println("[DEBUG] ProductDAO - getProductById - SQL: " + sql);
            System.out.println("[DEBUG] ProductDAO - getProductById - Param productId: " + productId);
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, productId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                product = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null
                );
            }
            System.out.println("[DEBUG] ProductDAO - getProductById - Result: " + product);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return product;
    }

    public void insertProduct(Products p) {
        DBContext db = DBContext.getInstance();
        String sql = """
                     INSERT INTO product (name, component_type_id, brand_id, price, import_price, stock, description, status)
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                     """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, p.getName());
            ptm.setInt(2, p.getComponent_type_id());
            ptm.setInt(3, p.getBrand_id());
            ptm.setDouble(4, p.getPrice_double());
            ptm.setDouble(5, p.getImport_price());
            ptm.setInt(6, p.getStock());
            ptm.setString(7, p.getDescription());
            ptm.setString(8, p.getStatus());
            ptm.executeUpdate();

            // Note: Inserting into productimage would be a separate operation
            // For now, we assume image_url is handled elsewhere or not stored directly in this method

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateProduct(Products p) {
        DBContext db = DBContext.getInstance();
        String sql = """
                     UPDATE product SET
                         name = ?,
                         component_type_id = ?,
                         brand_id = ?,
                         price = ?,
                         import_price = ?,
                         stock = ?,
                         description = ?,
                         status = ?
                     WHERE product_id = ?
                     """;
        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setString(1, p.getName());
            ptm.setInt(2, p.getComponent_type_id());
            ptm.setInt(3, p.getBrand_id());
            ptm.setDouble(4, p.getPrice_double());
            ptm.setDouble(5, p.getImport_price());
            ptm.setInt(6, p.getStock());
            ptm.setString(7, p.getDescription());
            ptm.setString(8, p.getStatus());
            ptm.setInt(9, p.getProduct_id());
            ptm.executeUpdate();
            
            // Note: Updating productimage would be a separate operation

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Vector<Products> getProductsByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<Products> list = new Vector<>();
        String sql = """
                     SELECT
                         p.product_id,
                         p.name,
                         p.description,
                         p.price,
                         p.stock,
                         p.status,
                         p.import_price,
                         p.created_at,
                         p.component_type_id,
                         p.brand_id,
                         p.model_id,
                         b.name as brand_name,
                         ct.name as component_type_name,
                         s.name as series_name,
                         m.name as model_name,
                         (SELECT image_url FROM ProductImage pi WHERE pi.product_id = p.product_id LIMIT 1) as image_url
                     FROM
                         Product p
                     JOIN
                         Brand b ON p.brand_id = b.brand_id
                     JOIN
                         ComponentType ct ON p.component_type_id = ct.type_id
                     LEFT JOIN
                         Model m ON p.model_id = m.model_id
                     LEFT JOIN
                         Series s ON m.series_id = s.series_id
                     WHERE
                         p.component_type_id = ? AND p.status = 'Active'
                     ORDER BY
                         b.name, s.name, m.name, p.name
                     """;

        try {
            PreparedStatement ptm = db.getConnection().prepareStatement(sql);
            ptm.setInt(1, componentTypeId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Products p = new Products(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getInt("component_type_id"),
                        rs.getInt("brand_id"),
                        rs.getDouble("price"),
                        rs.getDouble("import_price"),
                        rs.getInt("stock"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getString("image_url"),
                        rs.getString("brand_name"),
                        rs.getString("component_type_name"),
                        null
                );
                // Set additional series and model information
                p.setSeriesName(rs.getString("series_name"));
                p.setModelName(rs.getString("model_name"));
                list.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Vector<String> getBrandsByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<String> brands = new Vector<>();
        String sql = """
                     SELECT DISTINCT b.name
                     FROM Product p
                     JOIN Brand b ON p.brand_id = b.brand_id
                     WHERE p.component_type_id = ? AND p.status = 'Active'
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

    // Lấy danh sách series (string) theo component_type_id từ bảng product thông qua brand
    public Vector<String> getSeriesByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<String> series = new Vector<>();
        String sql = """
            SELECT DISTINCT s.name
            FROM series s
            JOIN brand b ON s.brand_id = b.brand_id
            JOIN product p ON p.brand_id = b.brand_id
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

    // Lấy danh sách model (string) theo component_type_id từ bảng product
    public Vector<String> getModelStringByComponentType(int componentTypeId) {
        DBContext db = DBContext.getInstance();
        Vector<String> models = new Vector<>();
        String sql = "SELECT DISTINCT model FROM product WHERE component_type_id = ? AND status = 'Active' AND model IS NOT NULL";
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

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        Vector<Products> list = dao.getAllProduct();
        for (Products p : list) {
            System.out.println(p);
        }
    }
}
