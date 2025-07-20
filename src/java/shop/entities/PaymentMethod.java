/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import lombok.*;
import lombok.experimental.FieldDefaults;
import shop.anotation.*;


/**
 *
 * @author admin
 */
@Table(name = "paymentmethod")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class PaymentMethod {
    @Id
    @Column(name = "payment_method_id")
    Integer id;
    
    @Column(name = "method_name")
    String name;
    
    @Column(name = "description")
    String description;
    
    @Column(name = "status")
    String status;
}
