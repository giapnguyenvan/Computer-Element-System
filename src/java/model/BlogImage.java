package model;

import java.sql.Timestamp;

public class BlogImage {
    private int image_id;
    private int blog_id;
    private String image_url;
    private String image_alt;
    private int display_order;
    private Timestamp created_at;

    public BlogImage(int image_id, int blog_id, String image_url, String image_alt, int display_order, Timestamp created_at) {
        this.image_id = image_id;
        this.blog_id = blog_id;
        this.image_url = image_url;
        this.image_alt = image_alt;
        this.display_order = display_order;
        this.created_at = created_at;
    }

    // Getters
    public int getImage_id() {
        return image_id;
    }

    public int getBlog_id() {
        return blog_id;
    }

    public String getImage_url() {
        return image_url;
    }

    public String getImage_alt() {
        return image_alt;
    }

    public int getDisplay_order() {
        return display_order;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    // Setters
    public void setImage_id(int image_id) {
        this.image_id = image_id;
    }

    public void setBlog_id(int blog_id) {
        this.blog_id = blog_id;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public void setImage_alt(String image_alt) {
        this.image_alt = image_alt;
    }

    public void setDisplay_order(int display_order) {
        this.display_order = display_order;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "BlogImage{" + "image_id=" + image_id + ", blog_id=" + blog_id + 
               ", image_url=" + image_url + ", image_alt=" + image_alt + 
               ", display_order=" + display_order + ", created_at=" + created_at + '}';
    }
} 