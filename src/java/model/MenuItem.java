package model;

public class MenuItem {
    private int menuItemId;
    private String name;
    private String icon;
    private String url;
    private Integer parentId;
    private String status;
    
    public MenuItem() {
    }
    
    public MenuItem(int menuItemId, String name, String icon, String url, Integer parentId, String status) {
        this.menuItemId = menuItemId;
        this.name = name;
        this.icon = icon;
        this.url = url;
        this.parentId = parentId;
        this.status = status;
    }
    
    public MenuItem(String name, String icon, String url, Integer parentId, String status) {
        this.name = name;
        this.icon = icon;
        this.url = url;
        this.parentId = parentId;
        this.status = status;
    }
    
    // Getter for JSP compatibility: ${menuItem.id}
    public int getId() {
        return menuItemId;
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
    
    public String getIcon() {
        return icon;
    }
    
    public void setIcon(String icon) {
        this.icon = icon;
    }
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    public Integer getParentId() {
        return parentId;
    }
    
    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "MenuItem{" + "menuItemId=" + menuItemId + ", name=" + name + ", icon=" + icon + 
               ", url=" + url + ", parentId=" + parentId + ", status=" + status + '}';
    }
} 