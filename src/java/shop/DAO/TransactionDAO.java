/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import java.sql.SQLException;
import java.util.List;
import shop.JDBC.GenericDAO;
import shop.anotation.FindBy;
import shop.entities.Transaction;

/**
 *
 * @author admin
 */
public class TransactionDAO extends GenericDAO<Transaction, Integer>{
    
    public TransactionDAO() {
        super(Transaction.class);
    }
    
    @FindBy(columns = "transaction_code")
    public Transaction getByCode(String transaction_code) throws SQLException{
        List<Transaction> trans = findByAnd(transaction_code);
        if(trans.isEmpty()) return null;
        return trans.get(0);
    }
    
    @FindBy(columns = "order_id")
    public Transaction getByOrderId(Integer order_id) throws SQLException{
        List<Transaction> trans = findByAnd(order_id);
        if(trans.isEmpty()) return null;
        return trans.get(0);
    }
}
