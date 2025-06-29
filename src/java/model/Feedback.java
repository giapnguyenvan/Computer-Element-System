package model;

import java.util.ArrayList;
import java.util.List;

public class Feedback {
    private int feedback_id;
    private int customer_id;
    private int product_id;
    private int rating;
    private String content;
    private String created_at;
    private String customerName;
    private String customerEmail;
    private String productName;
    private List<FeedbackImage> images;

    public Feedback(int feedback_id, int customer_id, int product_id, int rating, String content, String created_at) {
        this.feedback_id = feedback_id;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.rating = rating;
        this.content = content;
        this.created_at = created_at;
        this.images = new ArrayList<>();
    }

    // Getters
    public int getFeedback_id() {
        return feedback_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public int getRating() {
        return rating;
    }

    public String getContent() {
        return content;
    }

    public String getCreated_at() {
        return created_at;
    }

    public String getCustomerName() {
        return customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public String getProductName() {
        return productName;
    }

    public List<FeedbackImage> getImages() {
        return images;
    }

    // Setters
    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setImages(List<FeedbackImage> images) {
        this.images = images;
    }

    // Helper methods for images
    public void addImage(FeedbackImage image) {
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

    public FeedbackImage getMainImage() {
        if (this.images != null && !this.images.isEmpty()) {
            // Return the first image (lowest display_order)
            return this.images.stream()
                    .sorted((img1, img2) -> Integer.compare(img1.getDisplay_order(), img2.getDisplay_order()))
                    .findFirst()
                    .orElse(null);
        }
        return null;
    }

    public List<FeedbackImage> getSortedImages() {
        if (this.images != null) {
            List<FeedbackImage> sortedImages = new ArrayList<>(this.images);
            sortedImages.sort((img1, img2) -> Integer.compare(img1.getDisplay_order(), img2.getDisplay_order()));
            return sortedImages;
        }
        return new ArrayList<>();
    }

    @Override
    public String toString() {
        return "Feedback{" + "feedback_id=" + feedback_id + ", customer_id=" + customer_id + 
               ", product_id=" + product_id + ", rating=" + rating + ", content=" + content + 
               ", created_at=" + created_at + ", images_count=" + (images != null ? images.size() : 0) + '}';
    }
} 