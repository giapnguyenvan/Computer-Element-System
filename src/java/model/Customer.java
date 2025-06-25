package model;

public class Customer {
    private int customer_id;
    private int user_id;
    private String name;
    private String phone;
    private String shipping_address;
    private String email;
    private String password;
    private boolean isVerified;

    public Customer() {
    }

    public Customer(int customer_id, int user_id, String name, String phone, String shipping_address) {
        this.customer_id = customer_id;
        this.user_id = user_id;
        this.name = name;
        this.phone = phone;
        this.shipping_address = shipping_address;
    }

    // Constructor for adding a new customer (customer_id is auto-generated)
    public Customer(int user_id, String name, String phone, String shipping_address) {
        this.user_id = user_id;
        this.name = name;
        this.phone = phone;
        this.shipping_address = shipping_address;
    }

    public Customer(int customer_id, int user_id, String name, String phone, String shipping_address, boolean isVerified) {
        this.customer_id = customer_id;
        this.user_id = user_id;
        this.name = name;
        this.phone = phone;
        this.shipping_address = shipping_address;
        this.isVerified = isVerified;
    }

    // Getters and Setters
    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getShipping_address() {
        return shipping_address;
    }

    public void setShipping_address(String shipping_address) {
        this.shipping_address = shipping_address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean isVerified) {
        this.isVerified = isVerified;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "customer_id=" + customer_id +
                ", user_id=" + user_id +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", shipping_address='" + shipping_address + '\'' +
                '}';
    }
} 