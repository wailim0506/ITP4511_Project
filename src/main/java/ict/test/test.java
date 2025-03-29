/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.test;

import ict.db.ProjectDB;

/**
 *
 * @author Wai Lim Fung
 */
public class test {
    public static void main(String[] arg) {
        String url = "jdbc:mysql://localhost:3306/ITP4511_Project_DB";
        String username = "root";
        String password = "";
        ProjectDB custDb = new ProjectDB(url, username, password);        
    }
}
