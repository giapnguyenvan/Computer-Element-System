/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import shop.JDBC.GenericDAO;
import shop.entities.Transaction;

/**
 *
 * @author admin
 */
public class TransactionDAO extends GenericDAO<Transaction, Integer>{
    
    public TransactionDAO() {
        super(Transaction.class);
    }
    
}
