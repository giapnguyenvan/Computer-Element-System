/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import shop.JDBC.GenericDAO;
import shop.entities.User;

/**
 *
 * @author admin
 */
public class UserDAO extends GenericDAO<User, Integer> {

    public UserDAO() {
        super(User.class);
    }

}
