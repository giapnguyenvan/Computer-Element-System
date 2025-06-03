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
@Table(name = "payment_methods")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class PaymentMethod {
    @Id
    @Column(name = "id")
    Integer id;
    
    @Column(name = "name")
    String name;
    
    @Column(name = "description")
    String description;
}
