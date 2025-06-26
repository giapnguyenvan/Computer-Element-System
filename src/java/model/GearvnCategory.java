package model;
import java.util.List;
public class GearvnCategory {
    private String name;
    private List<SubCategory> subCategories;
    public GearvnCategory(String name, List<SubCategory> subCategories) {
        this.name = name;
        this.subCategories = subCategories;
    }
    public String getName() { return name; }
    public List<SubCategory> getSubCategories() { return subCategories; }
} 