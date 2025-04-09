/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.test;

import ict.db.ProjectDB;
import java.util.*;
import ict.bean.*;
import ict.util.*;
import java.time.LocalDate;

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
                // HashMap<String, String> fruitUnitMap = new HashMap<>();
                // fruitUnitMap.put("piece", "Piece (pcs)");
                // fruitUnitMap.put("gram", "Gram (g)");
                // fruitUnitMap.put("bunch", "Kilogram (kg)");
                // ArrayList<FruitsBean> list = db.getFruitsByCountryAndType("CA", "Single
                // Fruit");
                // for (int i = 0; i < list.size(); i++) {
                // FruitsBean fb = list.get(i);
                // System.out.print(fb.getId() + " ");
                // System.out.print(fb.getName() + " ");
                // System.out.print(fb.getCountryRegion() + " ");
                // System.out.println(fb.getImgName());
                // System.out.println(fruitUnitMap.get(fb.getUnit()));
                // }
                // test getAllFruitID()
                // ArrayList<String> list = db.getAllFruitID();
                // for (int i = 0; i < list.size(); i++) {
                // System.out.println(list.get(i));
                // }
                // test getNumberOfOrder()
                // System.out.println(db.getNumberOfOrder());
                // int currentNumberOfOrder = Integer.parseInt(db.getNumberOfOrder());
                // String newOrderId = "O";
                // if (currentNumberOfOrder == 0){
                // newOrderId += "0001";
                // } else {
                // currentNumberOfOrder++;
                // String orderId = String.valueOf(currentNumberOfOrder);
                // int length = orderId.length();
                // for (int i = 0; i < 4 - length; i++) {
                // newOrderId += "0";
                // }
                // newOrderId += orderId;
                // }
                // System.out.println(newOrderId);
                // test createOrder()
                // boolean f = db.createOrder("O0001","S001" , "2025-04-07", "D");
                // System.out.println("Today's date is: " + String.valueOf(LocalDate.now()));

                // //test insertOrderItem()
                // db.insertOrderItem("O0001", "F001", 5);
                // }
                // test getOrderById()
                // OrderBean ob = (OrderBean) db.getOrderById("O0001");
                // System.out.println("Order ID: " + ob.getId());
                // System.out.println("Shop ID: " + ob.getShopId());
                // System.out.println("Order Date: " + ob.getOrderDate());
                // if (ob.getNotes() == null || ob.getNotes().isEmpty()) {
                // System.out.println("Notes: No notes provided.");
                // } else {
                // System.out.println("Notes: " + ob.getNotes());
                // }
                // // System.out.println("Notes: " + ob.getNotes());
                // System.out.println("Status: " + ob.getStatus());

                // test getOrderItemById()
                // ArrayList<OrderBean> orderItems = db.getOrderItemById("O0001");
                // System.out.println("Order Items for Order ID: O0001");
                // System.out.println("Total items found: " + orderItems.size());

                // for (OrderBean item : orderItems) {
                // System.out.println("Fruit ID: " + item.getFruidId());
                // System.out.println("Fruit Name: " + item.getFruitName());
                // System.out.println("Unit: " + item.getUnit());
                // System.out.println("City: " + item.getCity());
                // System.out.println("Country Region: " + item.getCountryRegion());
                // System.out.println("Quantity: " + item.getQty());
                // System.out.println("---------------------");
                // }

                // LocalDate today = LocalDate.now();
                // String todayMonth = String.valueOf(today.getMonthValue());
                // // get today date
                // String todayDate = String.valueOf(today.getDayOfMonth());

                // System.out.println("Today's date is: " + today);
                // System.out.println("Today's month is: " + todayMonth);
                // System.out.println("Today's date is: " + todayDate);
                // test checkOrderWithinCutOff()
                // boolean f = db.checkOrderWithinCutOff("S001", "2025-04-01", "2025-04-14");
                // if (f) {
                // System.out.println("Order is within cut-off date.");
                // } else {
                // System.out.println("Order is not within cut-off date.");
                // }
                // test getOrderByDate
                // OrderBean ob = (OrderBean) db.getOrderByDate("S001", "2025-04-01",
                // "2025-04-14");
                // System.out.println("Order ID: " + ob.getId());
                // System.out.println("Shop ID: " + ob.getShopId());
                // System.out.println("Order Date: " + ob.getOrderDate());
                // if (ob.getNotes() == null || ob.getNotes().isEmpty()) {
                // System.out.println("Notes: No notes provided.");
                // } else {
                // System.out.println("Notes: " + ob.getNotes());
                // }
                // System.out.println("Status: " + ob.getStatus());
                // test getAllOrder()
                // ArrayList<OrderBean> orderList = db.getAllOrder("S001");
                // System.out.println("Order List for Shop ID: S001");
                // System.out.println("Total orders found: " + orderList.size());
                // for (OrderBean order : orderList) {
                // System.out.println("Order ID: " + order.getId());
                // System.out.println("Shop ID: " + order.getShopId());
                // System.out.println("Order Date: " + order.getOrderDate());
                // if (order.getNotes() == null || order.getNotes().isEmpty()) {
                // System.out.println("Notes: No notes provided.");
                // } else {
                // System.out.println("Notes: " + order.getNotes());
                // }
                // System.out.println("Status: " + order.getStatus());
                // System.out.println("---------------------");
                // }

                // test getOrderItemQty()
                System.out.println(db.getOrderItemQty("O0001"));
        }
}