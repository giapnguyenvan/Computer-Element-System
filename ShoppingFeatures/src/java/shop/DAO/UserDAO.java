/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package shop.DAO;

import java.sql.SQLException;
import java.util.List;
import shop.JDBC.GenericDAO;
import shop.anotation.FindBy;
import shop.entities.User;

/**
 *
 * @author admin
 */
public class UserDAO extends GenericDAO<User, Integer> {

    public UserDAO() {
        super(User.class);
    }

    @FindBy(columns = {"email"})
    public User findUserByEmail(String email) throws SQLException{
        List<User> users = findByAnd(email);
        if(users.isEmpty()) return null;
        return users.get(0);
    }
}
