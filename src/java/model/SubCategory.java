package model;
import java.util.List;
public class SubCategory {
    private String title;
    private List<String> items;
    public SubCategory(String title, List<String> items) {
        this.title = title;
        this.items = items;
    }
    public String getTitle() { return title; }
    public List<String> getItems() { return items; }
} 