package model;

public class Products {
    private int productId;
    private String name;
    private int componentTypeId;
    private int brandId;
    private Integer seriesId; // Nullable
    private String model;
    private Double price;
    private Double importPrice;
    private int stock;
    private String sku;
    private String description;
    private String status;
    private java.sql.Timestamp createdAt;

    // Joined fields for display
    private String brandName;
    private String componentTypeName;
    private String seriesName;
    private String imageUrl;

    public Products() {}

    // Main constructor (without joined fields)
    public Products(int productId, String name, int componentTypeId, int brandId, Integer seriesId, String model,
                    Double price, Double importPrice, int stock, String sku, String description, String status, java.sql.Timestamp createdAt) {
        this.productId = productId;
        this.name = name;
        this.componentTypeId = componentTypeId;
        this.brandId = brandId;
        this.seriesId = seriesId;
        this.model = model;
        this.price = price;
        this.importPrice = importPrice;
        this.stock = stock;
        this.sku = sku;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getters and setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getComponentTypeId() { return componentTypeId; }
    public void setComponentTypeId(int componentTypeId) { this.componentTypeId = componentTypeId; }

    public int getBrandId() { return brandId; }
    public void setBrandId(int brandId) { this.brandId = brandId; }

    public Integer getSeriesId() { return seriesId; }
    public void setSeriesId(Integer seriesId) { this.seriesId = seriesId; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public Double getImportPrice() { return importPrice; }
    public void setImportPrice(Double importPrice) { this.importPrice = importPrice; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public java.sql.Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.sql.Timestamp createdAt) { this.createdAt = createdAt; }

    // Joined fields
    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }

    public String getComponentTypeName() { return componentTypeName; }
    public void setComponentTypeName(String componentTypeName) { this.componentTypeName = componentTypeName; }

    public String getSeriesName() { return seriesName; }
    public void setSeriesName(String seriesName) { this.seriesName = seriesName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}