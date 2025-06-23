/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import shop.JDBC.GenericDAO;
import shop.entities.Customer;

/**
 *
 * @author admin
 */
public class CustomerDAO extends GenericDAO<Customer, Integer>{
    
    public CustomerDAO() {
        super(Customer.class);
    }
    
}
