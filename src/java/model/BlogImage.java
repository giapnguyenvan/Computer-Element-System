package model;

import java.sql.Timestamp;
import java.util.Objects;

public class BlogImage {
    private int image_id;
    private int blog_id;
    private String image_url;
    private String image_alt;
    private int display_order;
    private Timestamp created_at;

    // Utility to normalize image_url to always start with IMG/blog/
    public static String normalizeImageUrl(String url) {
        if (url == null || url.isEmpty()) return "IMG/blog/";
        String trimmed = url.trim();
        if (trimmed.startsWith("IMG/blog/")) return trimmed;
        // Remove any leading slashes
        while (trimmed.startsWith("/")) trimmed = trimmed.substring(1);
        if (trimmed.startsWith("IMG/blog/")) return "/" + trimmed;
        return "IMG/blog/" + trimmed;
    }

    // Default constructor
    public BlogImage() {
        this.image_id = 0;
        this.blog_id = 0;
        this.image_url = "IMG/blog/";
        this.image_alt = "";
        this.display_order = 0;
        this.created_at = null;
    }

    // Constructor without image_id (for new images)
    public BlogImage(int blog_id, String image_url, String image_alt, int display_order) {
        this.image_id = 0;
        this.blog_id = blog_id;
        this.image_url = normalizeImageUrl(image_url);
        this.image_alt = image_alt;
        this.display_order = display_order;
        this.created_at = null;
    }

    // Full constructor
    public BlogImage(int image_id, int blog_id, String image_url, String image_alt, int display_order, Timestamp created_at) {
        this.image_id = image_id;
        this.blog_id = blog_id;
        this.image_url = normalizeImageUrl(image_url);
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
        this.image_url = normalizeImageUrl(image_url);
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

    // Validation methods
    public boolean isValid() {
        return blog_id > 0 && 
               image_url != null && !image_url.trim().isEmpty() &&
               display_order >= 0;
    }

    public boolean isNew() {
        return image_id == 0;
    }

    // Utility methods
    public String getFileName() {
        if (image_url == null || image_url.isEmpty()) {
            return "";
        }
        int lastSlash = image_url.lastIndexOf('/');
        int lastDot = image_url.lastIndexOf('.');
        if (lastSlash >= 0 && lastDot > lastSlash) {
            return image_url.substring(lastSlash + 1);
        }
        return image_url;
    }

    public String getFileExtension() {
        if (image_url == null || image_url.isEmpty()) {
            return "";
        }
        int lastDot = image_url.lastIndexOf('.');
        if (lastDot >= 0) {
            return image_url.substring(lastDot + 1).toLowerCase();
        }
        return "";
    }

    public boolean isImageFile() {
        String extension = getFileExtension().toLowerCase();
        return extension.equals("jpg") || extension.equals("jpeg") || 
               extension.equals("png") || extension.equals("gif") || 
               extension.equals("webp") || extension.equals("bmp");
    }

    public String getThumbnailUrl() {
        if (image_url == null || image_url.isEmpty()) {
            return "";
        }
        // Create thumbnail URL by adding _thumb suffix
        int lastDot = image_url.lastIndexOf('.');
        if (lastDot >= 0) {
            return image_url.substring(0, lastDot) + "_thumb" + image_url.substring(lastDot);
        }
        return image_url + "_thumb";
    }

    // Copy method
    public BlogImage copy() {
        return new BlogImage(
            this.image_id,
            this.blog_id,
            this.image_url,
            this.image_alt,
            this.display_order,
            this.created_at
        );
    }

    @Override
    public String toString() {
        return "BlogImage{" + "image_id=" + image_id + ", blog_id=" + blog_id + 
               ", image_url=" + image_url + ", image_alt=" + image_alt + 
               ", display_order=" + display_order + ", created_at=" + created_at + '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        BlogImage blogImage = (BlogImage) obj;
        return image_id == blogImage.image_id &&
               blog_id == blogImage.blog_id &&
               display_order == blogImage.display_order &&
               Objects.equals(image_url, blogImage.image_url) &&
               Objects.equals(image_alt, blogImage.image_alt) &&
               Objects.equals(created_at, blogImage.created_at);
    }

    @Override
    public int hashCode() {
        return Objects.hash(image_id, blog_id, image_url, image_alt, display_order, created_at);
    }
} 