/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import java.math.BigDecimal;
import lombok.*;
import lombok.experimental.FieldDefaults;
import shop.DAO.ProductDAO;
import shop.anotation.*;

/**
 *
 * @author admin
 */
@Table(name = "orderdetail")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class OrderDetail {

    @Id
    @Column(name = "order_detail_id")
    Integer orderDetailId;

    @Column(name = "order_id")
    Integer orderId;

    @Column(name = "product_id")
    Integer productId;

    @Column(name = "quantity")
    Integer quantity;

    @Column(name = "price")
    BigDecimal price;

    Product product;

    public void setProductFunc() {
        try {
            product = new ProductDAO().getById(productId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
