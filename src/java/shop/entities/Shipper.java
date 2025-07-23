/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import shop.anotation.Column;
import shop.anotation.Table;

/**
 *
 * @author -PC-
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "shipper")
public class Shipper {
    @Column(name = "shipper_id")
    Integer shipperId;
    
    @Column(name = "name")
    String name;
    
    @Column(name = "phone")
    String phone;
    
    @Column(name = "email")
    String email;
    
    @Column(name = "status")
    String status;
}
