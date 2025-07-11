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
import shop.anotation.Id;
import shop.anotation.Table;
import java.util.Date;

/**
 *
 * @author admin
 */

@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
@Table(name = "Customer")
public class Customer {

    @Id
    @Column(name = "customer_id")
    Integer id;

    @Column(name = "name")
    String name;

    @Column(name = "email")
    String email;

    @Column(name = "password")
    String password;

    @Column(name = "phone")
    String phone;

    @Column(name = "shipping_address")
    String shippingAddress;

    @Column(name = "gender")
    String gender;

    @Column(name = "date_of_birth")
    Date dateOfBirth;
}
