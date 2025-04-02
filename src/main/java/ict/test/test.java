/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.test;

import ict.db.ProjectDB;
import java.util.*;
import ict.bean.*;

/**
 *
 * @author Wai Lim Fung
 */
public class test {
    public static void main(String[] arg) {
        String url = "jdbc:mysql://localhost:3306/ITP4511_Project_DB";
        String username = "root";
        String password = "";
        ProjectDB db = new ProjectDB(url, username, password);

        // test getAllFruit()
        // ArrayList<FruitsBean> list = db.getAllFruit();
        // for (int i = 0; i < list.size();i++){
        // FruitsBean fb = list.get(i);
        // System.out.print(fb.getId() + " ");
        // System.out.print(fb.getName() + " ");
        // System.out.print(fb.getCountryRegion() + " ");
        // System.out.println(fb.getImgName());
        // }

        // test getAllCountryRegion()
        ArrayList<CountryRegionBean> list = db.getAllCountryRegion();
        for (int i = 0; i < list.size(); i++) {
            CountryRegionBean crb = list.get(i);
            System.out.print(crb.getId() + " ");
            System.out.println(crb.getName());
        }
    }
}
