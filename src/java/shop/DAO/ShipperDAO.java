/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import java.sql.SQLException;
import java.util.List;

import shop.JDBC.GenericDAO;
import shop.anotation.FindBy;
import shop.entities.Shipper;

/**
 *
 * @author -PC-
 */
public class ShipperDAO extends GenericDAO<Shipper, Integer> {

    public ShipperDAO() {
        super(Shipper.class);
    }
    @FindBy(columns = {"email","status"})
    public Shipper getByEmail(String email, String status) throws SQLException{
        List<Shipper> list = findByAnd(email,status);
        if(list.isEmpty()) return null;
        return list.get(0);
    }
}
