/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.test;

import ict.db.ProjectDB;
import java.util.*;
import ict.bean.*;
import ict.util.*;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;

/**
 *
 * @author Wai Lim Fung
 */
public class test {

        public static void main(String[] arg) throws UnsupportedEncodingException, Exception {
                String url = "jdbc:mysql://localhost:3306/ITP4511_Project_DB";
                String username = "root";
                String password = "";
                ProjectDB db = new ProjectDB(url, username, password);

                // test getResreveNeedByShop()

        }
}