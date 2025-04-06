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
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID;";
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
                fb.setType(rs.getString("type"));
                fb.setUnit(rs.getString("unit"));
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
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and y.ID = ?;";
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
                fb.setUnit(rs.getString("unit"));
                fb.setType(rs.getString("type"));
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

    public ArrayList<FruitsBean> getFruitsByType(String type) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        ArrayList<FruitsBean> fruits = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and x.type=?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, type);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                fb = new FruitsBean();
                fb.setId(rs.getString("ID"));
                fb.setName(rs.getString("Name"));
                fb.setCountryRegion(rs.getString("CountryRegion"));
                fb.setImgName(rs.getString("ImgName"));
                fb.setCity(rs.getString("city"));
                fb.setUnit(rs.getString("unit"));
                fb.setType(rs.getString("type"));
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

    public ArrayList<FruitsBean> getFruitsByCountryAndType(String id, String type) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        ArrayList<FruitsBean> fruits = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and y.ID = ? and x.type=?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            pStmnt.setString(2, type);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                fb = new FruitsBean();
                fb.setId(rs.getString("ID"));
                fb.setName(rs.getString("Name"));
                fb.setCountryRegion(rs.getString("CountryRegion"));
                fb.setImgName(rs.getString("ImgName"));
                fb.setCity(rs.getString("city"));
                fb.setUnit(rs.getString("unit"));
                fb.setType(rs.getString("type"));

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

    public ArrayList<String> getFruitType() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> type = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT DISTINCT type FROM fruit;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                type.add(rs.getString("type"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return type;
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

    public ArrayList<CountryRegionBean> getFruitCountryRegion() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        CountryRegionBean crb = null;
        ArrayList<CountryRegionBean> countryRegion = new ArrayList<CountryRegionBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT DISTINCT cr.ID, cr.Name FROM country_region cr " +
                    "JOIN fruit_city fc ON cr.ID = fc.CountryRegionID " +
                    "JOIN fruit f ON f.FruitCityID = fc.ID " +
                    "ORDER BY cr.Name";
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

    // for user table
    public String getPassword(String user) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
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
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public String getUserID(String user) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
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
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public UserBean getUserDetail(String username) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        UserBean ub = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT \n"
                    + "    a.UserID,\n"
                    + "    a.UserName,\n"
                    + "    d.ID AS ShopID,\n"
                    + "    b.StaffName AS ShopStaffName,\n"
                    + "    d.Address AS ShopAddress,\n"
                    + "    sc.City AS ShopCity,\n"
                    + "    cr_shop.Name AS ShopCountry,\n"
                    + "    f.ID AS WarehouseID,\n"
                    + "    c.StaffName AS WarehouseStaffName,\n"
                    + "    cr_warehouse.Name AS WarehouseCountry\n"
                    + "FROM user a\n"
                    + "LEFT JOIN shop_staff b ON a.UserID = b.UserID\n"
                    + "LEFT JOIN warehouse_staff c ON a.UserID = c.UserID\n"
                    + "LEFT JOIN shop d ON b.ShopID = d.ID\n"
                    + "LEFT JOIN shop_city sc ON d.City = sc.ID\n"
                    + "LEFT JOIN country_region cr_shop ON sc.CountryRegionID = cr_shop.ID\n"
                    + "LEFT JOIN warehouse f ON c.WarehouseID = f.ID\n"
                    + "LEFT JOIN country_region cr_warehouse ON f.CountryRegionID = cr_warehouse.ID\n"
                    + "WHERE a.UserName = ? ORDER BY a.UserID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, username);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                // if is shop user
                if (rs.getString("ShopID") != null) {
                    ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setUserName(rs.getString("UserName"));
                    ub.setStaffName(rs.getString("ShopStaffName"));
                    ub.setShopId(rs.getString("ShopID"));
                    ub.setShopAddress(rs.getString("ShopAddress"));
                    ub.setShopCity(rs.getString("ShopCity"));
                    ub.setShopCountry(rs.getString("ShopCountry"));
                } // if is warehouse user
                else if (rs.getString("WarehouseID") != null) {
                    ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setUserName(rs.getString("UserName"));
                    ub.setStaffName(rs.getString("WarehouseStaffName"));
                    ub.setWareHouseId(rs.getString("WarehouseID"));
                    ub.setWarehouseCountry(rs.getString("WarehouseCountry"));
                }
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ub;
    }
    // for user table
}
