package model;

import java.math.BigDecimal;
import java.util.Date;

public class Shipper {
    private int shipper_id;
    private String name;
    private String phone;
    private String email;
    private String vehicle_number;
    private String vehicle_type;
    private String status;
    private String current_location;
    private Date join_date;
    private BigDecimal rating;
    private int total_deliveries;

    public Shipper() {
    }

    public Shipper(int shipper_id, String name, String phone, String email, String vehicle_number, 
                   String vehicle_type, String status, String current_location, Date join_date, 
                   BigDecimal rating, int total_deliveries) {
        this.shipper_id = shipper_id;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.vehicle_number = vehicle_number;
        this.vehicle_type = vehicle_type;
        this.status = status;
        this.current_location = current_location;
        this.join_date = join_date;
        this.rating = rating;
        this.total_deliveries = total_deliveries;
    }

    // Constructor for adding a new shipper (shipper_id is auto-generated)
    public Shipper(String name, String phone, String email, String vehicle_number, 
                   String vehicle_type, String status, String current_location) {
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.vehicle_number = vehicle_number;
        this.vehicle_type = vehicle_type;
        this.status = status;
        this.current_location = current_location;
        this.join_date = new Date();
        this.rating = new BigDecimal("0.00");
        this.total_deliveries = 0;
    }

    // Getters and Setters
    public int getShipper_id() {
        return shipper_id;
    }

    public void setShipper_id(int shipper_id) {
        this.shipper_id = shipper_id;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getVehicle_number() {
        return vehicle_number;
    }

    public void setVehicle_number(String vehicle_number) {
        this.vehicle_number = vehicle_number;
    }

    public String getVehicle_type() {
        return vehicle_type;
    }

    public void setVehicle_type(String vehicle_type) {
        this.vehicle_type = vehicle_type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCurrent_location() {
        return current_location;
    }

    public void setCurrent_location(String current_location) {
        this.current_location = current_location;
    }

    public Date getJoin_date() {
        return join_date;
    }

    public void setJoin_date(Date join_date) {
        this.join_date = join_date;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public int getTotal_deliveries() {
        return total_deliveries;
    }

    public void setTotal_deliveries(int total_deliveries) {
        this.total_deliveries = total_deliveries;
    }

    @Override
    public String toString() {
        return "Shipper{" +
                "shipper_id=" + shipper_id +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", vehicle_number='" + vehicle_number + '\'' +
                ", vehicle_type='" + vehicle_type + '\'' +
                ", status='" + status + '\'' +
                ", current_location='" + current_location + '\'' +
                ", join_date=" + join_date +
                ", rating=" + rating +
                ", total_deliveries=" + total_deliveries +
                '}';
    }
} 