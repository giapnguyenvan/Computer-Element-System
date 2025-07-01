package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Blog {
    private int blog_id;
    private String title;
    private String content;
    private int user_id;
    private Timestamp created_at;
    private List<BlogImage> images;

    public Blog(int blog_id, String title, String content, int user_id, Timestamp created_at) {
        this.blog_id = blog_id;
        this.title = title;
        this.content = content;
        this.user_id = user_id;
        this.created_at = created_at;
        this.images = new ArrayList<>();
    }

    // Getters
    public int getBlog_id() {
        return blog_id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public int getUser_id() {
        return user_id;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public List<BlogImage> getImages() {
        return images;
    }

    // Setters
    public void setBlog_id(int blog_id) {
        this.blog_id = blog_id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public void setImages(List<BlogImage> images) {
        this.images = images;
    }

    // Helper methods for images
    public void addImage(BlogImage image) {
        if (this.images == null) {
            this.images = new ArrayList<>();
        }
        this.images.add(image);
    }

    public void removeImage(int imageId) {
        if (this.images != null) {
            this.images.removeIf(img -> img.getImage_id() == imageId);
        }
    }

    public BlogImage getMainImage() {
        if (this.images != null && !this.images.isEmpty()) {
            // Return the first image (lowest display_order)
            return this.images.stream()
                    .sorted((img1, img2) -> Integer.compare(img1.getDisplay_order(), img2.getDisplay_order()))
                    .findFirst()
                    .orElse(null);
        }
        return null;
    }

    public List<BlogImage> getSortedImages() {
        if (this.images != null) {
            List<BlogImage> sortedImages = new ArrayList<>(this.images);
            sortedImages.sort((img1, img2) -> Integer.compare(img1.getDisplay_order(), img2.getDisplay_order()));
            return sortedImages;
        }
        return new ArrayList<>();
    }

    @Override
    public String toString() {
        return "Blog{" + "blog_id=" + blog_id + ", title=" + title + ", content=" + content + 
               ", user_id=" + user_id + ", created_at=" + created_at + 
               ", images_count=" + (images != null ? images.size() : 0) + '}';
    }
} 