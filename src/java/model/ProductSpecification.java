package model;

public class ProductSpecification {
    private int specId;
    private int productId;
    private String specKey;
    private String specValue;
    
    public ProductSpecification() {}
    
    public ProductSpecification(int specId, int productId, String specKey, String specValue) {
        this.specId = specId;
        this.productId = productId;
        this.specKey = specKey;
        this.specValue = specValue;
    }
    
    // Getters and setters
    public int getSpecId() {
        return specId;
    }
    
    public void setSpecId(int specId) {
        this.specId = specId;
    }
    
    public int getProductId() {
        return productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    public String getSpecKey() {
        return specKey;
    }
    
    public void setSpecKey(String specKey) {
        this.specKey = specKey;
    }
    
    public String getSpecValue() {
        return specValue;
    }
    
    public void setSpecValue(String specValue) {
        this.specValue = specValue;
    }
    
    @Override
    public String toString() {
        return "ProductSpecification{" + "specId=" + specId + ", productId=" + productId + ", specKey=" + specKey + ", specValue=" + specValue + '}';
    }
} 