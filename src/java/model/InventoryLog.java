/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author nghia
 */
public class InventoryLog {

    private int log_id;
    private int product_id;
    private String action;
    private int quantity;
    private String note;
    private Timestamp created_at;
    
    // Additional fields for display
    private String productName;
    private String brandName;
    private String componentTypeName;

    @Override
    public String toString() {
        return "InventoryLog{" + "log_id=" + log_id + ", product_id=" + product_id + ", action=" + action + ", quantity=" + quantity + ", note=" + note + ", created_at=" + created_at + '}';
    }

    public InventoryLog(int log_id, int product_id, String action, int quantity, String note, Timestamp created_at) {
        this.log_id = log_id;
        this.product_id = product_id;
        this.action = action;
        this.quantity = quantity;
        this.note = note;
        this.created_at = created_at;
    }

    public InventoryLog() {
    }

    public void setLog_id(int log_id) {
        this.log_id = log_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public int getLog_id() {
        return log_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public String getAction() {
        return action;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getNote() {
        return note;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }
    
    // Additional getters and setters for display fields
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getComponentTypeName() {
        return componentTypeName;
    }

    public void setComponentTypeName(String componentTypeName) {
        this.componentTypeName = componentTypeName;
    }
}
