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
import shop.entities.Order;

/**
 *
 * @author admin
 */
public class OrderDAO extends GenericDAO<Order, Integer>{
    
    public OrderDAO() {
        super(Order.class);
    }
    
    @FindBy(columns = "customer_id")
    public List<Order> getByCustomerId(Integer customerId) throws SQLException {
        return findByAnd(customerId);
    }
    
    @Query(sql = "UPDATE orders SET status = ? WHERE order_id = ?")
    public boolean updateOrderStatus(String status, Integer orderId) throws SQLException {
        return executeQueryUpdateOrCheck(status, orderId);
    }
}
