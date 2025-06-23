package model;

import java.sql.Timestamp;

public class Blog {
    private int blog_id;
    private String title;
    private String content;
    private int customer_id;
    private Timestamp created_at;

    public Blog(int blog_id, String title, String content, int customer_id, Timestamp created_at) {
        this.blog_id = blog_id;
        this.title = title;
        this.content = content;
        this.customer_id = customer_id;
        this.created_at = created_at;
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

    public int getCustomer_id() {
        return customer_id;
    }

    public Timestamp getCreated_at() {
        return created_at;
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

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "Blog{" + "blog_id=" + blog_id + ", title=" + title + ", content=" + content + 
               ", customer_id=" + customer_id + ", created_at=" + created_at + '}';
    }
} 