/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import shop.JDBC.GenericDAO;
import shop.entities.PaymentMethod;

/**
 *
 * @author -PC-
 */
public class PaymentMethodDAO extends GenericDAO<PaymentMethod, Integer> {

    public PaymentMethodDAO() {
        super(PaymentMethod.class);
    }

}
