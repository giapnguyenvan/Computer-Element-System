package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Products {

    private int product_id;
    private String name;
    private int component_type_id;
    private int brand_id;
    private BigDecimal price;
    private BigDecimal import_price;
    private int stock;
    private String description;
    private String status;
    private Timestamp created_at;
    private String image_url; // From productimage table
    private String brandName; // From brand table
    private String componentTypeName; // from componenttype table
    private String categoryName; // To be compatible with old code


    public Products() {
    }

    // A constructor that matches the new database schema
    public Products(int product_id, String name, int component_type_id, int brand_id, BigDecimal price, BigDecimal import_price, int stock, String description, String status, Timestamp created_at, String image_url, String brandName, String componentTypeName) {
        this.product_id = product_id;
        this.name = name;
        this.component_type_id = component_type_id;
        this.brand_id = brand_id;
        this.price = price;
        this.import_price = import_price;
        this.stock = stock;
        this.description = description;
        this.status = status;
        this.created_at = created_at;
        this.image_url = image_url;
        this.brandName = brandName;
        this.componentTypeName = componentTypeName;
    }

    // Keep old constructor signatures for compatibility if needed, but adapt them.
    // This old constructor is likely used in many places.
     public Products(int id, String name, String brand, int category_id, double price,
                int stock, String image_url,
                String description, String spec_description, String status) {
        this.product_id = id;
        this.name = name;
        this.brandName = brand;
        this.component_type_id = category_id;
        this.price = new BigDecimal(price);
        this.stock = stock;
        this.image_url = image_url;
        this.description = description;
        this.status = status;
    }

    public Products(int id, String name, String brand, int category_id, double price, int stock, String image_url, String description, String spec_description, String status, String categoryName) {
        this(id, name, brand, category_id, price, stock, image_url, description, spec_description, status);
        this.categoryName = categoryName;
    }


    // Getters and Setters

    // Getter for id to maintain compatibility with JSP files (e.g., ${product.id})
    public int getId() {
        return product_id;
    }

    public void setId(int id) {
        this.product_id = id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Getter for brand to maintain compatibility
    public String getBrand() {
        return brandName;
    }

    // Setter for brand
    public void setBrand(String brand) {
        this.brandName = brand;
    }
    
    public int getComponent_type_id() {
        return component_type_id;
    }

    public void setComponent_type_id(int component_type_id) {
        this.component_type_id = component_type_id;
    }

    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
    }

    public double getPrice() {
        return price.doubleValue();
    }

    public void setPrice(double price) {
        this.price = new BigDecimal(price);
    }
    
    public BigDecimal getPrice_BigDecimal() {
        return price;
    }

    public void setPrice_BigDecimal(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getImport_price() {
        return import_price;
    }

    public void setImport_price(BigDecimal import_price) {
        this.import_price = import_price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getComponentTypeName() {
        return componentTypeName;
    }

    public void setComponentTypeName(String componentTypeName) {
        this.componentTypeName = componentTypeName;
    }
    
    // Kept for backward compatibility
    public String getSpec_description() {
        return "";
    }
    
    public int getCategory_id() {
        return component_type_id;
    }
    
    public String getCategoryName() {
        return componentTypeName;
    }

    public void setCategoryName(String categoryName) {
        this.componentTypeName = categoryName;
    }
}