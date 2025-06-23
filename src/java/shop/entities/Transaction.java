/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import java.math.BigDecimal;
import java.util.Date;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import shop.anotation.Column;
import shop.anotation.Id;
import shop.anotation.Table;

/**
 *
 * @author admin
 */
@Table(name = "Transactions")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class Transaction {
    
    @Id
    @Column(name = "transaction_id")
    Integer id;
    
    @Column(name = "transaction_code")
    String transactionCode;
    
    @Column(name = "order_id")
    Integer orderId;
    
    @Column(name = "payment_method_id")
    Integer paymentMethodId;
    
    @Column(name = "total_amount")
    BigDecimal totalAmount;
    
    @Column(name = "created_at")
    Date createdAt;
    
    @Column(name = "paid")
    boolean paid;
}

