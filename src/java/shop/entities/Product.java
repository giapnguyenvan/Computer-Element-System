/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import shop.DAO.ProductImageDAO;
import shop.anotation.*;

/**
 *
 * @author admin
 */
@Table(name = "Product")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class Product {

    @Id
    @Column(name = "product_id")
    Integer id;

    @Column(name = "name")
    String name;

    @Column(name = "component_type_id")
    Integer componentTypeId;

    @Column(name = "brand_id")
    Integer brandId;

    @Column(name = "price")
    BigDecimal price;

    @Column(name = "import_price")
    BigDecimal importPrice;

    @Column(name = "stock")
    Integer stock;

    @Column(name = "description")
    String description;

    @Column(name = "status")
    @Enumerated
    String status; // 'active', 'inactive'

    @Column(name = "created_at")
    Date createdAt;

    List<ProductImage> productImages;

    public void setProductImagesFunc() {
        try {
            this.productImages = new ProductImageDAO().getByProductId(this.id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
