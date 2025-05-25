/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Users {
    private String username;
    private String password;
    private String role;

    @Override
    public String toString() {
        return "Users{" + "username=" + username + ", password=" + password + ", role=" + role + '}';
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
    }

    public Users(String username, String password, String role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }
}
