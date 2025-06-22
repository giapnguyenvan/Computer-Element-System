package model;

public class Category {
    private int type_id; // Corresponds to type_id in componenttype table
    private String name;
    private String description; // Kept for form compatibility, but not in DB table
    
    public Category() {
    }
    
    public Category(int type_id, String name, String description) {
        this.type_id = type_id;
        this.name = name;
        this.description = description;
    }
    
    // Getter for JSP compatibility: ${category.id}
    public int getId() {
        return type_id;
    }
    
    public int getType_id() {
        return type_id;
    }
    
    public void setType_id(int type_id) {
        this.type_id = type_id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    @Override
    public String toString() {
        return "Category{" + "type_id=" + type_id + ", name=" + name + ", description=" + description + '}';
    }
} 