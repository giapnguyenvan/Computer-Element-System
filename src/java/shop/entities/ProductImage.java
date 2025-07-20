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

/**
 *
 * @author -PC-
 */
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "productimage")
public class ProductImage {

    @Id
    @Column(name = "image_id")
    Integer imageId;
    @Column(name = "product_id")
    Integer productId;
    @Column(name = "image_url")
    String imageUrl;
    @Column(name = "alt_text")
    String altText;
    @Column(name = "is_primary")
    boolean isPrimary;
}
