package model;

public class Series {
    private int seriesId;
    private int brandId;
    private String name;
    private int componentTypeId;
    private String description;
    
    public Series() {}
    
    public Series(int seriesId, int brandId, String name, int componentTypeId, String description) {
        this.seriesId = seriesId;
        this.brandId = brandId;
        this.name = name;
        this.componentTypeId = componentTypeId;
        this.description = description;
    }
    
    // Getters and setters
    public int getSeriesId() {
        return seriesId;
    }
    
    public void setSeriesId(int seriesId) {
        this.seriesId = seriesId;
    }
    
    public int getBrandId() {
        return brandId;
    }
    
    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getComponentTypeId() {
        return componentTypeId;
    }
    
    public void setComponentTypeId(int componentTypeId) {
        this.componentTypeId = componentTypeId;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    @Override
    public String toString() {
        return "Series{" + "seriesId=" + seriesId + ", brandId=" + brandId + ", name=" + name + ", componentTypeId=" + componentTypeId + ", description=" + description + '}';
    }
} 