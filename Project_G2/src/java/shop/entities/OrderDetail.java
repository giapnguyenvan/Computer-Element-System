/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import java.math.BigDecimal;
import lombok.*;
import lombok.experimental.FieldDefaults;
import shop.anotation.*;

/**
 *
 * @author admin
 */
@Table(name = "order_details")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class OrderDetail {
    @Id
    @Column(name = "id")
    Integer id;
    
    @Column(name = "order_id")
    Integer orderId;
    
    @Column(name = "product_id")
    Integer productId;
    
    @Column(name = "quantity")
    Integer quantity;
    
    @Column(name = "item_price")
    BigDecimal itemPrice;
    
    @Column(name = "total_price")
    BigDecimal totalPrice;
}