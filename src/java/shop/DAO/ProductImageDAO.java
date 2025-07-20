/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import java.sql.SQLException;
import java.util.List;
import shop.JDBC.GenericDAO;
import shop.anotation.FindBy;
import shop.entities.ProductImage;

/**
 *
 * @author -PC-
 */
public class ProductImageDAO extends GenericDAO<ProductImage, Integer> {

    public ProductImageDAO() {
        super(ProductImage.class);
    }

    @FindBy(columns = {"product_id"})
    public List<ProductImage> getByProductId(Integer product_id) throws SQLException {
        return findByAnd(product_id);
    }
}
