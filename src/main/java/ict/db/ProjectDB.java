/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.db;

import java.io.*;
import java.sql.*;
import ict.bean.*;
import java.util.*;

/**
 *
 * @author Wai Lim Fung
 */
public class ProjectDB {

    private String url = "";
    private String username = "";
    private String password = "";

    public ProjectDB(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public Connection getConnection() throws SQLException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(url, username, password);
    }

    // for fruit table
    public ArrayList<FruitsBean> getAllFruit() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        ArrayList<FruitsBean> fruits = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                fb = new FruitsBean();
                fb.setId(rs.getString("ID"));
                fb.setName(rs.getString("Name"));
                fb.setCountryRegion(rs.getString("CountryRegion"));
                fb.setImgName(rs.getString("ImgName"));
                fb.setCity(rs.getString("city"));
                fruits.add(fb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fruits;
    }

    public ArrayList<FruitsBean> getFruitsByCountryRegion(String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        ArrayList<FruitsBean> fruits = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and y.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                fb = new FruitsBean();
                fb.setId(rs.getString("ID"));
                fb.setName(rs.getString("Name"));
                fb.setCountryRegion(rs.getString("CountryRegion"));
                fb.setImgName(rs.getString("ImgName"));
                fb.setCity(rs.getString("city"));
                fruits.add(fb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fruits;
    }
    // for fruit table

    // for country_region table
    public ArrayList<CountryRegionBean> getAllCountryRegion() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        CountryRegionBean crb = null;
        ArrayList<CountryRegionBean> countryRegion = new ArrayList<CountryRegionBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM country_region ORDER BY Name;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                crb = new CountryRegionBean();
                crb.setId(rs.getString("ID"));
                crb.setName(rs.getString("Name"));
                countryRegion.add(crb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return countryRegion;
    }
    // for country_region table
    
    //for user table
    public String getPassword(String user){
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try{
            cnnct = getConnection();
            String preQueryStatement = "SELECT Password FROM USER WHERE UserName=? ";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, user);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                return rs.getString("Password");
            }
            pStmnt.close();
            cnnct.close();
        }catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public String getUserID(String user){
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try{
            cnnct = getConnection();
            String preQueryStatement = "SELECT UserID FROM USER WHERE UserName=? ";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, user);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                return rs.getString("UserID");
            }
            pStmnt.close();
            cnnct.close();
        }catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    public UserBean getUserDetail(String username){
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        UserBean ub = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.UserID, x.StaffName, x.UserName, y.Type AS AccountType, z.ID AS ShopID, zz.ID AS WarehouseID FROM user x LEFT JOIN account_type y ON x.AccountType = y.ID LEFT JOIN shop z ON x.ShopID = z.ID LEFT JOIN warehouse zz ON x.WarehouseID = zz.ID ORDER BY x.UserID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                crb = new CountryRegionBean();
                crb.setId(rs.getString("ID"));
                crb.setName(rs.getString("Name"));
                countryRegion.add(crb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return countryRegion;
    }
    //for user table
}
