/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import java.sql.SQLException;
import java.util.List;
import shop.JDBC.GenericDAO;
import shop.anotation.FindBy;
import shop.anotation.Query;
import shop.entities.CartItem;

/**
 *
 * @author admin
 */
public class CartItemDAO extends GenericDAO<CartItem, Integer>{
    
    public CartItemDAO() {
        super(CartItem.class);
    }
    @FindBy(columns = {"customer_id"})
    public List<CartItem> getAllByCustomerId(Integer customer_id) throws SQLException{
        return findByAnd(customer_id);
    }
    @FindBy(columns = {"customer_id","product_id"})
    public CartItem getByUserIdAndProductId(Integer customerId, Integer productId) throws SQLException {
        List<CartItem> obs = findByAnd(customerId, productId);
        return !obs.isEmpty() ? obs.get(0) : null;
    }
    
    @Query(sql = """
                 delete from CartItem where customer_id = ?
                 """)
    public boolean deleteByUserId(Integer customer_id) throws SQLException {
        return executeQueryUpdateOrCheck(customer_id);
    }
}
