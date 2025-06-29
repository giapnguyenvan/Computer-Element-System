package model;

public class MenuAttributeValue {
    private int valueId;
    private int attributeId;
    private String value;
    private String url;
    private String status;
    
    public MenuAttributeValue() {
    }
    
    public MenuAttributeValue(int valueId, int attributeId, String value, String url, String status) {
        this.valueId = valueId;
        this.attributeId = attributeId;
        this.value = value;
        this.url = url;
        this.status = status;
    }
    
    public MenuAttributeValue(int attributeId, String value, String url, String status) {
        this.attributeId = attributeId;
        this.value = value;
        this.url = url;
        this.status = status;
    }
    
    // Getter for JSP compatibility: ${menuAttributeValue.id}
    public int getId() {
        return valueId;
    }
    
    public int getValueId() {
        return valueId;
    }
    
    public void setValueId(int valueId) {
        this.valueId = valueId;
    }
    
    public int getAttributeId() {
        return attributeId;
    }
    
    public void setAttributeId(int attributeId) {
        this.attributeId = attributeId;
    }
    
    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "MenuAttributeValue{" + "valueId=" + valueId + ", attributeId=" + attributeId + 
               ", value=" + value + ", url=" + url + ", status=" + status + '}';
    }
} 