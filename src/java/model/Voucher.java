package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Voucher {
    private int voucher_id;
    private String code;
    private String description;
    private String discount_type; // 'percent' or 'fixed'
    private BigDecimal discount_value;
    private BigDecimal min_order_amount;
    private Integer max_uses;
    private Integer max_uses_per_user;
    private Timestamp start_date;
    private Timestamp end_date;
    private String status; // 'Active', 'Inactive', 'Expired'

    public Voucher() {}

    public Voucher(int voucher_id, String code, String description, String discount_type, BigDecimal discount_value, BigDecimal min_order_amount, Integer max_uses, Integer max_uses_per_user, Timestamp start_date, Timestamp end_date, String status) {
        this.voucher_id = voucher_id;
        this.code = code;
        this.description = description;
        this.discount_type = discount_type;
        this.discount_value = discount_value;
        this.min_order_amount = min_order_amount;
        this.max_uses = max_uses;
        this.max_uses_per_user = max_uses_per_user;
        this.start_date = start_date;
        this.end_date = end_date;
        this.status = status;
    }

    // Getters and setters
    public int getVoucher_id() { return voucher_id; }
    public void setVoucher_id(int voucher_id) { this.voucher_id = voucher_id; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getDiscount_type() { return discount_type; }
    public void setDiscount_type(String discount_type) { this.discount_type = discount_type; }
    public BigDecimal getDiscount_value() { return discount_value; }
    public void setDiscount_value(BigDecimal discount_value) { this.discount_value = discount_value; }
    public BigDecimal getMin_order_amount() { return min_order_amount; }
    public void setMin_order_amount(BigDecimal min_order_amount) { this.min_order_amount = min_order_amount; }
    public Integer getMax_uses() { return max_uses; }
    public void setMax_uses(Integer max_uses) { this.max_uses = max_uses; }
    public Integer getMax_uses_per_user() { return max_uses_per_user; }
    public void setMax_uses_per_user(Integer max_uses_per_user) { this.max_uses_per_user = max_uses_per_user; }
    public Timestamp getStart_date() { return start_date; }
    public void setStart_date(Timestamp start_date) { this.start_date = start_date; }
    public Timestamp getEnd_date() { return end_date; }
    public void setEnd_date(Timestamp end_date) { this.end_date = end_date; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
} 