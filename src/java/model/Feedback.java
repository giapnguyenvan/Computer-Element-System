package model;

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

    public Feedback(int feedback_id, int customer_id, int product_id, int rating, String content, String created_at) {
        this.feedback_id = feedback_id;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.rating = rating;
        this.content = content;
        this.created_at = created_at;
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

    @Override
    public String toString() {
        return "Feedback{" + "feedback_id=" + feedback_id + ", customer_id=" + customer_id + 
               ", product_id=" + product_id + ", rating=" + rating + ", content=" + content + 
               ", created_at=" + created_at + '}';
    }
} 