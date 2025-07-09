package model;

import java.util.List;

public class MenuAttribute {
    private int attributeId;
    private int menuItemId;
    private String name;
    private String url;
    private String status;
    private List<MenuAttributeValue> menuAttributeValues;
    
    public MenuAttribute() {
    }
    
    public MenuAttribute(int attributeId, int menuItemId, String name, String url, String status) {
        this.attributeId = attributeId;
        this.menuItemId = menuItemId;
        this.name = name;
        this.url = url;
        this.status = status;
    }
    
    public MenuAttribute(int menuItemId, String name, String url, String status) {
        this.menuItemId = menuItemId;
        this.name = name;
        this.url = url;
        this.status = status;
    }
    
    // Getter for JSP compatibility: ${menuAttribute.id}
    public int getId() {
        return attributeId;
    }
    
    public int getAttributeId() {
        return attributeId;
    }
    
    public void setAttributeId(int attributeId) {
        this.attributeId = attributeId;
    }
    
    public int getMenuItemId() {
        return menuItemId;
    }
    
    public void setMenuItemId(int menuItemId) {
        this.menuItemId = menuItemId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
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

    public List<MenuAttributeValue> getMenuAttributeValues() {
        return menuAttributeValues;
    }

    public void setMenuAttributeValues(List<MenuAttributeValue> menuAttributeValues) {
        this.menuAttributeValues = menuAttributeValues;
    }

    @Override
    public String toString() {
        return "MenuAttribute{" + "attributeId=" + attributeId + ", menuItemId=" + menuItemId + 
               ", name=" + name + ", url=" + url + ", status=" + status + ", menuAttributeValues=" + menuAttributeValues + '}';
    }
} 