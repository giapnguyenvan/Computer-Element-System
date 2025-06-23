/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.entities;

import lombok.*;
import lombok.experimental.FieldDefaults;
import shop.DAO.ProductDAO;
import shop.anotation.*;

/**
 *
 * @author admin
 */
@Table(name = "CartItem")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@Getter
@Setter
public class CartItem {

    @Id
    @Column(name = "cart_item_id")
    Integer id;

    @Column(name = "customer_id")
    Integer customerId;

    @Column(name = "product_id")
    Integer productId;

    @Column(name = "quantity")
    Integer quantity;

    Product product;

    public void setProductFunc() {
        try {
            this.product = new ProductDAO().getById(this.productId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
