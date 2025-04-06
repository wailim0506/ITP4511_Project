/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.test;

import ict.db.ProjectDB;
import java.util.*;
import ict.bean.*;
import ict.util.*;

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
                // for (int i = 0; i < list.size(); i++) {
                // FruitsBean fb = list.get(i);
                // System.out.print(fb.getId() + " ");
                // System.out.print(fb.getName() + " ");
                // System.out.print(fb.getCountryRegion() + " ");
                // System.out.println(fb.getImgName());
                // System.out.println(fb.getType());
                // }
                // test getAllCountryRegion()
                // ArrayList<CountryRegionBean> list = db.getAllCountryRegion();
                // for (int i = 0; i < list.size(); i++) {
                // CountryRegionBean crb = list.get(i);
                // System.out.print(crb.getId() + " ");
                // System.out.println(crb.getName());
                // }
                // test getFruitByCountry()
                // ArrayList<FruitsBean> list = db.getFruitsByCountryRegion("GB");
                // for (int i = 0; i < list.size(); i++) {
                // FruitsBean fb = list.get(i);
                // System.out.print(fb.getId() + " ");
                // System.out.print(fb.getName() + " ");
                // System.out.print(fb.getCountryRegion() + " ");
                // System.out.println(fb.getImgName());
                // }
                // test passwordCrypto.java
                // Example usage
                // try {
                // // Encrypt with different IV lengths
                // PasswordCrypto.CryptoResult result1 = PasswordCrypto.encrypt("123456",
                // "U003");
                // System.out.println("Encrypted Text 1: " + result1.encryptedText);
                // System.out.println("IV 1: " + result1.iv);
                //
                // // Decrypt
                // String decrypted1 = PasswordCrypto.decrypt(result1.encryptedText,
                // result1.iv);
                // System.out.println("Decrypted Text 1: " + decrypted1);
                //
                // } catch (Exception e) {
                // e.printStackTrace();
                // }
                // test getPassword()
                // System.out.println(db.getUserID("Shop 1"));
                // test getUserDetail()
                // UserBean uBean = db.getUserDetail("User 2");
                // System.out.println("User ID: " + uBean.getUserId());
                // System.out.println("User Name: " + uBean.getUserName());
                // System.out.println("Staff Name: " + uBean.getStaffName());
                // System.out.println("Shop ID: " + uBean.getShopId());
                // String passwordFromDB = db.getPassword("User 1");
                // String UserIDFromDB = db.getUserID("User 1");
                //
                // System.out.println("Password from DB: " + passwordFromDB);
                // System.out.println("UserID from DB: " + UserIDFromDB);
                // try {
                // boolean f = password.equals(PasswordCrypto.decrypt(passwordFromDB,
                // UserIDFromDB));
                // if (f) {
                // System.out.println("Password is correct!");
                // } else {
                // System.out.println("Password is incorrect!");
                // }
                // } catch (Exception e) {
                // }
                // try {
                // //Encrypt with different IV lengths
                // PasswordCrypto.CryptoResult result1 = PasswordCrypto.encrypt("123456",
                // "U002");
                // System.out.println("Encrypted Text 1: " + result1.encryptedText);
                // System.out.println("IV 1: " + result1.iv);
                //
                // // Decrypt
                // String decrypted1 = PasswordCrypto.decrypt("CpWhvOs//62LN7EVZk60ew==",
                // "VTAwMwAAAAAAAAAAAAAAAA==");
                // System.out.println("Decrypted Text 1: " + decrypted1);
                //
                // } catch (Exception e) {
                // e.printStackTrace();
                // }
                // ArrayList<CountryRegionBean> list = db.getFruitCountryRegion();
                // for (int i = 0; i < list.size(); i++) {
                // CountryRegionBean crb = list.get(i);
                // System.out.print(crb.getId() + " ");
                // System.out.println(crb.getName());
                // }
                // test getFruitType()
                // ArrayList<String> type = db.getFruitType();
                // for (int i = 0; i < type.size();i++){
                // System.out.println(type.get(i));
                // }
                // }
                // test getFruitByCountry()
                HashMap<String, String> fruitUnitMap = new HashMap<>();
                fruitUnitMap.put("piece", "Piece (pcs)");
                fruitUnitMap.put("gram", "Gram (g)");
                fruitUnitMap.put("bunch", "Kilogram (kg)");
                ArrayList<FruitsBean> list = db.getFruitsByCountryAndType("CA", "Single Fruit");
                for (int i = 0; i < list.size(); i++) {
                        FruitsBean fb = list.get(i);
                        System.out.print(fb.getId() + " ");
                        System.out.print(fb.getName() + " ");
                        System.out.print(fb.getCountryRegion() + " ");
                        System.out.println(fb.getImgName());
                        System.out.println(fruitUnitMap.get(fb.getUnit()));
                }
        }
}
