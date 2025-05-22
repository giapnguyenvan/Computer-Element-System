/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import shop.JDBC.GenericDAO;
import shop.entities.Order;

/**
 *
 * @author admin
 */
public class OrderDAO extends GenericDAO<Order, Integer>{
    
    public OrderDAO() {
        super(Order.class);
    }
    
}
