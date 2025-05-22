/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import java.math.BigDecimal;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import shop.anotation.*;

/**
 *
 * @author admin
 */
@Table(name = "products")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class Product {
    @Id
    @Column(name = "id")
    Integer id;
    
    @Column(name = "name")
    String name;
    
    @Column(name = "category_id")
    Integer categoryId;
    
    @Column(name = "price")
    BigDecimal price;
    
    @Column(name = "stock")
    Integer stock;
    
    @Column(name = "status")
    @Enumerated
    String status; // 'active', 'inactive'
    
    @Column(name = "image_url")
    String imageUrl;
    
    @Column(name = "description")
    String description;
    
    @Column(name = "spec_description")
    String specDescription; // JSON containing technical specifications
}
