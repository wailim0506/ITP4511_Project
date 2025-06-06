/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.db;

import java.io.*;
import java.sql.*;
import ict.bean.*;
import jakarta.persistence.criteria.CriteriaBuilder.In;

import java.time.LocalDate;

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
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and x.Status = 'enable';";
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
    
    public ArrayList<FruitsBean> getAllFruitManager() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        ArrayList<FruitsBean> fruits = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit,x.Status FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID;";
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
                fb.setStatus(rs.getString("status"));
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

    public ArrayList<String> getAllFruitID() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> fruitIdList = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT ID FROM fruit;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                fruitIdList.add(rs.getString("ID"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fruitIdList;
    }

    public ArrayList<String> getAllFruitIDWarehouse(String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> fruitIdList = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT wfs.FruitID AS ID\n" +
                    "FROM warehouse_fruit_stock wfs\n" +
                    "JOIN warehouse w ON w.ID = wfs.WarehouseID\n" +
                    "WHERE w.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                fruitIdList.add(rs.getString("ID"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fruitIdList;
    }

    public ArrayList<FruitsBean> getFruitsByCountryRegion(String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        ArrayList<FruitsBean> fruits = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and y.ID = ? and x.Status = 'enable';";
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
    
    public FruitsBean getFruitById(String id){
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit, x.Status \n" +
                                            "FROM fruit x, country_region y, fruit_city z \n" +
                                            "WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and x.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                fb = new FruitsBean();
                fb.setId(rs.getString("ID"));
                fb.setName(rs.getString("Name"));
                fb.setCountryRegion(rs.getString("CountryRegion"));
                fb.setImgName(rs.getString("ImgName"));
                fb.setCity(rs.getString("city"));
                fb.setUnit(rs.getString("unit"));
                fb.setType(rs.getString("type"));
                fb.setStatus(rs.getString("Status"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fb;
    }

    public ArrayList<FruitsBean> getFruitsByType(String type) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitsBean fb = null;
        ArrayList<FruitsBean> fruits = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and x.type=? and x.Status = 'enable';";
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
            String preQueryStatement = "SELECT x.ID,x.Name,x.ImgName,z.city,y.Name AS CountryRegion,x.type,x.unit FROM fruit x, country_region y, fruit_city z WHERE x.FruitCityID = z.ID and z.CountryRegionID = y.ID and y.ID = ? and x.type=? and x.Status = 'enable';";
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
            String preQueryStatement = "SELECT DISTINCT cr.ID, cr.Name FROM country_region cr "
                    + "JOIN fruit_city fc ON cr.ID = fc.CountryRegionID "
                    + "JOIN fruit f ON f.FruitCityID = fc.ID "
                    + "ORDER BY cr.Name";
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

    public ArrayList<FruitCityBean> getFruitCity() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        FruitCityBean fcb = null;
        ArrayList<FruitCityBean> city = new ArrayList<FruitCityBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM fruit_city;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                fcb = new FruitCityBean();
                fcb.setId(rs.getString("ID"));
                fcb.setCity(rs.getString("City"));
                fcb.setCountryRegionID(rs.getString("CountryRegionID"));
                city.add(fcb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return city;
    }
    
    
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
                    + "    b.StaffName AS ShopStaffName,b.role,\n"
                    + "    d.Address AS ShopAddress,\n"
                    + "    sc.City AS ShopCity,\n"
                    + "    cr_shop.Name AS ShopCountry,\n"
                    + "    f.ID AS WarehouseID,\n"
                    + "    c.StaffName AS WarehouseStaffName,\n"
                    + "    cr_warehouse.Name AS WarehouseCountry, \n"
                    + "    f.Type AS WarehouseType, \n"
                    + "    f.SourceCity AS SourceCity,c.role AS warehouseRole,\n"
                    + "    fc.City AS SourceCityFullName,\n"
                    + "    f.PhoneNumber AS warehousePhone,\n"
                    + "    d.PhoneNumber AS shopPhone,r.ID AS SMID,\n" +
                    "    r.StaffName AS SMStaffName,\n" +
                    "    r.Role AS SMRole\n"
                    + "FROM user a\n"
                    + "LEFT JOIN shop_staff b ON a.UserID = b.UserID\n"
                    + "LEFT JOIN warehouse_staff c ON a.UserID = c.UserID\n"
                    + "LEFT JOIN senior_management_staff r ON a.UserID = r.UserID\n"
                    + "LEFT JOIN shop d ON b.ShopID = d.ID\n"
                    + "LEFT JOIN shop_city sc ON d.City = sc.ID\n"
                    + "LEFT JOIN country_region cr_shop ON sc.CountryRegionID = cr_shop.ID\n"
                    + "LEFT JOIN warehouse f ON c.WarehouseID = f.ID\n"
                    + "LEFT JOIN country_region cr_warehouse ON f.CountryRegionID = cr_warehouse.ID\n"
                    + "LEFT JOIN fruit_city fc ON f.SourceCity = fc.ID\n"
                    + "WHERE a.UserName = ? AND a.Status = 'enable' ORDER BY a.UserID;";
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
                    ub.setPhone(rs.getString("shopPhone"));
                    ub.setRole(rs.getString("role"));
                } // if is warehouse user
                else if (rs.getString("WarehouseID") != null) {
                    ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setUserName(rs.getString("UserName"));
                    ub.setStaffName(rs.getString("WarehouseStaffName"));
                    ub.setWareHouseId(rs.getString("WarehouseID"));
                    ub.setWarehouseCountry(rs.getString("WarehouseCountry"));
                    ub.setWarehouseType(rs.getString("WarehouseType"));
                    ub.setWarehouseSourceCity(rs.getString("SourceCity"));
                    ub.setWarehouseSourceCityFullName(rs.getString("SourceCityFullName"));
                    ub.setPhone(rs.getString("warehousePhone"));
                    ub.setRole(rs.getString("warehouseRole"));
                } else { // senior management
                    ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setUserName(rs.getString("UserName"));
                    ub.setStaffName(rs.getString("SMStaffName"));
                    ub.setRole(rs.getString("SMRole"));
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

    public UserBean getUserDetailForEdit(String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        UserBean ub = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT \n"
                    + "    a.UserID,\n"
                    + "    a.UserName,\n"
                    + "    d.ID AS ShopID,\n"
                    + "    b.StaffName AS ShopStaffName,b.role,\n"
                    + "    d.Address AS ShopAddress,\n"
                    + "    sc.City AS ShopCity,\n"
                    + "    cr_shop.Name AS ShopCountry,\n"
                    + "    f.ID AS WarehouseID,\n"
                    + "    c.StaffName AS WarehouseStaffName,\n"
                    + "    cr_warehouse.Name AS WarehouseCountry, \n"
                    + "    f.Type AS WarehouseType, \n"
                    + "    f.SourceCity AS SourceCity,c.role AS warehouseRole,\n"
                    + "    fc.City AS SourceCityFullName,\n"
                    + "    f.PhoneNumber AS warehousePhone,\n"
                    + "    d.PhoneNumber AS shopPhone,r.ID AS SMID,\n" +
                    "    r.StaffName AS SMStaffName,\n" +
                    "    r.Role AS SMRole\n"
                    + "FROM user a\n"
                    + "LEFT JOIN shop_staff b ON a.UserID = b.UserID\n"
                    + "LEFT JOIN warehouse_staff c ON a.UserID = c.UserID\n"
                    + "LEFT JOIN senior_management_staff r ON a.UserID = r.UserID\n"
                    + "LEFT JOIN shop d ON b.ShopID = d.ID\n"
                    + "LEFT JOIN shop_city sc ON d.City = sc.ID\n"
                    + "LEFT JOIN country_region cr_shop ON sc.CountryRegionID = cr_shop.ID\n"
                    + "LEFT JOIN warehouse f ON c.WarehouseID = f.ID\n"
                    + "LEFT JOIN country_region cr_warehouse ON f.CountryRegionID = cr_warehouse.ID\n"
                    + "LEFT JOIN fruit_city fc ON f.SourceCity = fc.ID\n"
                    + "WHERE a.UserID = ? AND a.Status = 'enable' ORDER BY a.UserID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                if (rs.getString("ShopID") != null) {
                    ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setStaffName(rs.getString("ShopStaffName"));
                    ub.setShopId(rs.getString("ShopID"));
                    ub.setRole(rs.getString("role"));
                } // if is warehouse user
                else if (rs.getString("WarehouseID") != null) {
                    ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setStaffName(rs.getString("WarehouseStaffName"));
                    ub.setWareHouseId(rs.getString("WarehouseID"));
                    ub.setRole(rs.getString("warehouseRole"));
                } else { // senior management
                    ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setUserName(rs.getString("UserName"));
                    ub.setStaffName(rs.getString("SMStaffName"));
                    ub.setRole(rs.getString("SMRole"));
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

    public int getUserCount() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int count = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS num FROM user";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                count = rs.getInt("num");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    public boolean addNewUser(String userId, String userName, String pw) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO user VALUES(?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, userId);
            pStmnt.setString(2, userName);
            pStmnt.setString(3, pw);
            pStmnt.setString(4, "enable");
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean disableUser(String userId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE user SET Status='disable' WHERE UserID=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, userId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    // for user table

    // for shop_staff table
    public int getLastStaffId() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String lastStaffId = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT MAX(ID) AS lastStaffId FROM shop_staff";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                lastStaffId = rs.getString("lastStaffId");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return Integer.parseInt(lastStaffId);
    }

    public boolean addNewShopStaff(String userId, String staffName, String shopId, String userID, String role) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO shop_staff VALUES(?,?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, userId);
            pStmnt.setString(2, staffName);
            pStmnt.setString(3, shopId);
            pStmnt.setString(4, userID);
            pStmnt.setString(5, role);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public String getShopStaffIdByUserId(String uId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String staffId = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT ID FROM shop_staff WHERE UserID=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, uId);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                staffId = rs.getString("ID");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return staffId;
    }

    public boolean updateShopStaff(String staffId, String staffName, String role, String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_staff SET StaffName=?, Role=?, ShopID=? WHERE ID=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, staffName);
            pStmnt.setString(2, role);
            pStmnt.setString(3, shopId);
            pStmnt.setString(4, staffId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    // for shop_staff table
    // for shop_fruit_order
    public String getNumberOfOrder() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS num FROM shop_fruit_order";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                return rs.getString("num");
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

    public boolean createOrder(String orderId, String shopId, String orderDate, String notes) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO shop_fruit_order (ID,ShopID,OrderDate,Status,Notes) VALUES(?,?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, shopId);
            pStmnt.setString(3, orderDate);
            pStmnt.setString(4, "Pending");
            pStmnt.setString(5, notes);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public OrderBean getOrderById(String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean ob = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM shop_fruit_order WHERE ID = ? ORDER BY OrderDate DESC ;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopID"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setNotes(rs.getString("Notes"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ob;
    }

    public boolean checkOrderWithinCutOff(String shopId, String startDate, String endDate) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean haveOrder = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS num FROM shop_fruit_order WHERE ShopID=? AND OrderDate BETWEEN ? AND ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.setString(2, startDate);
            pStmnt.setString(3, endDate);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                if (rs.getInt("num") > 0) {
                    haveOrder = true;
                }
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return haveOrder;
    }

    public OrderBean getOrderByDate(String shopId, String startDate, String endDate) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean ob = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM shop_fruit_order WHERE ShopID=? AND OrderDate BETWEEN ? AND ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.setString(2, startDate);
            pStmnt.setString(3, endDate);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopID"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setNotes(rs.getString("Notes"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return ob;
    }

    public ArrayList<OrderBean> getAllOrder(String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean ob = null;
        ArrayList<OrderBean> orderList = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM shop_fruit_order WHERE ShopID=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopID"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setNotes(rs.getString("Notes"));
                orderList.add(ob);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<OrderBean> getOrderByDateRange(String shopId, String range) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean ob = null;
        ArrayList<OrderBean> orderList = new ArrayList<>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM shop_fruit_order WHERE ShopID=?";
            LocalDate today = LocalDate.now();
            LocalDate startDate = null;
            LocalDate endDate = null;

            switch (range) {
                case "currentMonth":
                    startDate = today.withDayOfMonth(1);
                    endDate = today.withDayOfMonth(today.lengthOfMonth());
                    break;
                case "last90":
                    startDate = today.minusDays(90);
                    endDate = today;
                    break;
                case "ytd":
                    startDate = today.withDayOfYear(1);
                    endDate = today;
                    break;
            }

            if (startDate != null && endDate != null) {
                preQueryStatement += " AND OrderDate BETWEEN ? AND ?";
            }

            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            if (startDate != null && endDate != null) {
                pStmnt.setDate(2, java.sql.Date.valueOf(startDate));
                pStmnt.setDate(3, java.sql.Date.valueOf(endDate));
            }

            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopID"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setNotes(rs.getString("Notes"));
                orderList.add(ob);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<OrderBean> getOrderByStatus(String shopId, String status) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean ob = null;
        ArrayList<OrderBean> orderList = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM shop_fruit_order WHERE ShopID=? AND Status=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.setString(2, status);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopID"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setNotes(rs.getString("Notes"));
                orderList.add(ob);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<OrderBean> getOrderByStatusAndDateRange(String shopId, String range, String status) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean ob = null;
        ArrayList<OrderBean> orderList = new ArrayList<>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM shop_fruit_order WHERE ShopID=?";
            LocalDate today = LocalDate.now();
            LocalDate startDate = null;
            LocalDate endDate = null;

            switch (range) {
                case "currentMonth":
                    startDate = today.withDayOfMonth(1);
                    endDate = today.withDayOfMonth(today.lengthOfMonth());
                    break;
                case "last90":
                    startDate = today.minusDays(90);
                    endDate = today;
                    break;
                case "ytd":
                    startDate = today.withDayOfYear(1);
                    endDate = today;
                    break;
            }

            if (startDate != null && endDate != null) {
                preQueryStatement += " AND OrderDate BETWEEN ? AND ? AND Status=?";
            }

            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            if (startDate != null && endDate != null) {
                pStmnt.setDate(2, java.sql.Date.valueOf(startDate));
                pStmnt.setDate(3, java.sql.Date.valueOf(endDate));
            }
            pStmnt.setString(4, status);

            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopID"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setNotes(rs.getString("Notes"));
                orderList.add(ob);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public boolean changeOrderStatusToFinish(String orderId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "Update shop_fruit_order SET Status = 'Finished' WHERE ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    // for shop_fruit_order
    // for shop_fruit_order_item
    public boolean insertOrderItem(String orderId, String fruitId, int qty) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO shop_fruit_order_item (OrderID,FruitID,Qty,Status) VALUES(?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, fruitId);
            pStmnt.setInt(3, qty);
            pStmnt.setString(4, "Pending");
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public ArrayList<OrderBean> getOrderItemById(String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean ob = null;
        ArrayList<OrderBean> orderItemList = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT y.ID,y.Name,y.unit,z.City,a.Name AS CountryRegion,x.Qty FROM shop_fruit_order_item x, fruit y, fruit_city z, country_region a WHERE x.FruitID = y.ID and y.FruitCityID = z.ID and z.CountryRegionID = a.ID and x.OrderID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                ob = new OrderBean();
                ob.setFruidId(rs.getString("ID"));
                ob.setFruitName(rs.getString("Name"));
                ob.setUnit(rs.getString("unit"));
                ob.setCity(rs.getString("City"));
                ob.setCountryRegion(rs.getString("CountryRegion"));
                ob.setQty(rs.getInt("Qty"));
                orderItemList.add(ob);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return orderItemList;
    }

    public int getOrderItemQty(String orderId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int qty = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "Select Count(*) AS qty from shop_fruit_order_item where OrderID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                qty = rs.getInt("qty");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return qty;
    }

    public boolean updateOrderItemQty(String orderId, String fruitId, int qty) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "Update shop_fruit_order_item SET Qty = ? WHERE OrderID = ? AND FruitID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setInt(1, qty);
            pStmnt.setString(2, orderId);
            pStmnt.setString(3, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean deleteOrderItem(String orderId, String fruitId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "DELETE FROM shop_fruit_order_item WHERE OrderID=? AND FruitID=?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    // for shop_fruit_order_item

    // for shop
    public ArrayList<ShopBean> getShopInSameCity(String city, String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ShopBean> shopList = new ArrayList<ShopBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID, x.Address, x.PhoneNumber, y.City,y.CountryRegionID FROM SHOP x, shop_city y where x.City = y.ID and y.City = ? and x.ID != ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, city);
            pStmnt.setString(2, shopId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                ShopBean sb = new ShopBean();
                sb.setAddress(rs.getString("Address"));
                sb.setPhoneNumber(rs.getString("PhoneNumber"));
                sb.setCity(rs.getString("City"));
                sb.setID(rs.getString("ID"));
                sb.setCountryRegion(rs.getString("CountryRegionID"));
                shopList.add(sb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return shopList;
    }

    public ArrayList<ShopBean> getAllShop() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ShopBean> shopList = new ArrayList<ShopBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID, x.Address, x.PhoneNumber, y.City,z.name FROM SHOP x, shop_city y,country_region z where x.City = y.ID and y.CountryRegionID = z.ID order by z.ID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                ShopBean sb = new ShopBean();
                sb.setAddress(rs.getString("Address"));
                sb.setPhoneNumber(rs.getString("PhoneNumber"));
                sb.setCity(rs.getString("City"));
                sb.setID(rs.getString("ID"));
                sb.setCountryRegion(rs.getString("name"));
                shopList.add(sb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return shopList;
    }
    // for shop

    // for shop_city
    public ArrayList<String> getAllShopCity() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> cityList = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT City FROM shop_city";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                cityList.add(rs.getString("City"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return cityList;
    }
    // for shop_city

    // shop_fruit_stock
    public ArrayList<ShopFruitStockBean> getShopFruitStock(String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ShopFruitStockBean> shopStockList = new ArrayList<ShopFruitStockBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Name,y.type,y.unit,y.ImgName,z.City,aa.Name AS CR FROM shop_fruit_stock x, fruit y, fruit_city z, country_region aa WHERE ShopID = ? and x.FruitID = y.ID and y.FruitCityID = z.ID and z.CountryRegionID = aa.ID and y.Status = 'enable' ;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                ShopFruitStockBean sb = new ShopFruitStockBean();
                sb.setShopId(rs.getString("ShopID"));
                sb.setFruitId(rs.getString("FruitID"));
                sb.setFruitName(rs.getString("Name"));
                sb.setCity(rs.getString("City"));
                sb.setCountryRegion(rs.getString("CR"));
                sb.setImgName(rs.getString("ImgName"));
                sb.setQty(String.valueOf(rs.getInt("Qty")));
                sb.setType(rs.getString("type"));
                sb.setUnit(rs.getString("unit"));
                shopStockList.add(sb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return shopStockList;
    }

    public int getShopFruitStockQty(String shopId, String fruitId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int qty = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT Qty FROM shop_fruit_stock WHERE ShopID=? AND FruitID=?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.setString(2, fruitId);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                qty = rs.getInt("Qty");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return qty;
    }

    public boolean updateShopFruitStock(String shopId, String fruitId, int qty) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_stock SET Qty = ? WHERE ShopID = ? AND FruitID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setInt(1, qty);
            pStmnt.setString(2, shopId);
            pStmnt.setString(3, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    // for shop_fruit_stock

    // for shop_borrow_request
    public String getNumberOfBorrow() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS num FROM shop_borrow_request";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                return rs.getString("num");
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

    public boolean createBorrowRequest(String requestId, String fromShopId, String toShopId, String orderDate,
            String notes) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO shop_borrow_request (ID,RequestBy,RequestTo,RequestDate,Status,Notes) VALUES(?,?,?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, requestId);
            pStmnt.setString(2, fromShopId);
            pStmnt.setString(3, toShopId);
            pStmnt.setString(4, orderDate);
            pStmnt.setString(5, "Pending");
            pStmnt.setString(6, notes);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public ArrayList<BorrowBean> getAllBorrow(String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        BorrowBean bb = null;
        ArrayList<BorrowBean> orderList = new ArrayList<BorrowBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Address,z.City,y.PhoneNumber FROM shop_borrow_request x, shop y ,shop_city z WHERE RequestBy =? and x.RequestTo = y.ID and y.City = z.ID";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                bb = new BorrowBean();
                bb.setId(rs.getString("ID"));
                bb.setRequestByShopId(rs.getString("RequestBy"));
                bb.setRequestToShopId(rs.getString("RequestTo"));
                bb.setRequestToShopAddress(rs.getString("Address") + ", " + rs.getString("City"));
                bb.setRequestDate(rs.getString("RequestDate"));
                bb.setStatus(rs.getString("Status"));
                bb.setNotes(rs.getString("Notes"));
                bb.setRequestToShopPhone(rs.getString("PhoneNumber"));
                bb.setRejectReason(rs.getString("RejectDetail"));
                bb.setRejectReasonSelect(rs.getString("RejectReason"));
                bb.setCompleted(rs.getString("Completed"));
                orderList.add(bb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<BorrowBean> getBorrowByDateRange(String shopId, String range) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        BorrowBean bb = null;
        ArrayList<BorrowBean> orderList = new ArrayList<>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Address,z.City,y.PhoneNumber FROM shop_borrow_request x, shop y ,shop_city z WHERE RequestBy=? and x.RequestTo = y.ID and y.City = z.ID";
            LocalDate today = LocalDate.now();
            LocalDate startDate = null;
            LocalDate endDate = null;

            switch (range) {
                case "currentMonth":
                    startDate = today.withDayOfMonth(1);
                    endDate = today.withDayOfMonth(today.lengthOfMonth());
                    break;
                case "last90":
                    startDate = today.minusDays(90);
                    endDate = today;
                    break;
                case "ytd":
                    startDate = today.withDayOfYear(1);
                    endDate = today;
                    break;
            }

            if (startDate != null && endDate != null) {
                preQueryStatement += " AND RequestDate BETWEEN ? AND ?";
            }

            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            if (startDate != null && endDate != null) {
                pStmnt.setDate(2, java.sql.Date.valueOf(startDate));
                pStmnt.setDate(3, java.sql.Date.valueOf(endDate));
            }

            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                bb = new BorrowBean();
                bb.setId(rs.getString("ID"));
                bb.setRequestByShopId(rs.getString("RequestBy"));
                bb.setRequestToShopId(rs.getString("RequestTo"));
                bb.setRequestToShopAddress(rs.getString("Address") + ", " + rs.getString("City"));
                bb.setRequestDate(rs.getString("RequestDate"));
                bb.setStatus(rs.getString("Status"));
                bb.setNotes(rs.getString("Notes"));
                bb.setRequestToShopPhone(rs.getString("PhoneNumber"));
                bb.setRejectReason(rs.getString("RejectDetail"));
                bb.setRejectReasonSelect(rs.getString("RejectReason"));
                bb.setCompleted(rs.getString("Completed"));
                orderList.add(bb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<BorrowBean> getBorrowByStatus(String shopId, String status) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        BorrowBean bb = null;
        ArrayList<BorrowBean> orderList = new ArrayList<BorrowBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Address,z.City,y.PhoneNumber FROM shop_borrow_request x, shop y ,shop_city z WHERE RequestBy=? and x.RequestTo = y.ID and y.City = z.ID AND Status=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.setString(2, status);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                bb = new BorrowBean();
                bb.setId(rs.getString("ID"));
                bb.setRequestByShopId(rs.getString("RequestBy"));
                bb.setRequestToShopId(rs.getString("RequestTo"));
                bb.setRequestToShopAddress(rs.getString("Address") + ", " + rs.getString("City"));
                bb.setRequestDate(rs.getString("RequestDate"));
                bb.setStatus(rs.getString("Status"));
                bb.setRequestToShopPhone(rs.getString("PhoneNumber"));
                bb.setNotes(rs.getString("Notes"));
                bb.setRejectReason(rs.getString("RejectDetail"));
                bb.setRejectReasonSelect(rs.getString("RejectReason"));
                bb.setCompleted(rs.getString("Completed"));
                orderList.add(bb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<BorrowBean> getBorrowByStatusAndDateRange(String shopId, String range, String status) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        BorrowBean bb = null;
        ArrayList<BorrowBean> orderList = new ArrayList<>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Address,z.City,y.PhoneNumber FROM shop_borrow_request x, shop y ,shop_city z WHERE RequestBy=? and x.RequestTo = y.ID and y.City = z.ID";
            LocalDate today = LocalDate.now();
            LocalDate startDate = null;
            LocalDate endDate = null;

            switch (range) {
                case "currentMonth":
                    startDate = today.withDayOfMonth(1);
                    endDate = today.withDayOfMonth(today.lengthOfMonth());
                    break;
                case "last90":
                    startDate = today.minusDays(90);
                    endDate = today;
                    break;
                case "ytd":
                    startDate = today.withDayOfYear(1);
                    endDate = today;
                    break;
            }

            if (startDate != null && endDate != null) {
                preQueryStatement += " AND RequestDate BETWEEN ? AND ? AND Status=?";
            }

            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            if (startDate != null && endDate != null) {
                pStmnt.setDate(2, java.sql.Date.valueOf(startDate));
                pStmnt.setDate(3, java.sql.Date.valueOf(endDate));
            }
            pStmnt.setString(4, status);

            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                bb = new BorrowBean();
                bb.setId(rs.getString("ID"));
                bb.setRequestByShopId(rs.getString("RequestBy"));
                bb.setRequestToShopId(rs.getString("RequestTo"));
                bb.setRequestToShopAddress(rs.getString("Address") + ", " + rs.getString("City"));
                bb.setRequestDate(rs.getString("RequestDate"));
                bb.setStatus(rs.getString("Status"));
                bb.setNotes(rs.getString("Notes"));
                bb.setRequestToShopPhone(rs.getString("PhoneNumber"));
                bb.setRejectReason(rs.getString("RejectDetail"));
                bb.setRejectReasonSelect(rs.getString("RejectReason"));
                bb.setCompleted(rs.getString("Completed"));
                orderList.add(bb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public ArrayList<BorrowBean> getBorrowByStatusForHandleRequest(String shopId, String status) { // requestToShopId
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        BorrowBean bb = null;
        ArrayList<BorrowBean> orderList = new ArrayList<BorrowBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Address,z.City,y.PhoneNumber FROM shop_borrow_request x, shop y ,shop_city z WHERE RequestTo=? and x.RequestBy = y.ID and y.City = z.ID AND Status=?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.setString(2, status);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                bb = new BorrowBean();
                bb.setId(rs.getString("ID"));
                bb.setRequestByShopId(rs.getString("RequestBy"));
                bb.setRequestToShopId(rs.getString("RequestTo"));
                bb.setRequestByShopAddress(rs.getString("Address") + ", " + rs.getString("City"));
                bb.setRequestDate(rs.getString("RequestDate"));
                bb.setStatus(rs.getString("Status"));
                bb.setRequestByShopPhone(rs.getString("PhoneNumber"));
                bb.setNotes(rs.getString("Notes"));
                bb.setRejectReason(rs.getString("RejectDetail"));
                bb.setRejectReasonSelect(rs.getString("RejectReason"));
                bb.setCompleted(rs.getString("Completed"));
                orderList.add(bb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return orderList;
    }

    public String getPendingStatistics(String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String num = null;
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusDays(30);
        LocalDate endDate = today;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS num FROM shop_borrow_request WHERE Status = 'Pending' AND RequestDate BETWEEN ? AND ? AND RequestTo = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setDate(1, java.sql.Date.valueOf(startDate));
            pStmnt.setDate(2, java.sql.Date.valueOf(endDate));
            pStmnt.setString(3, shopId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                num = rs.getString("num");
            }
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (pStmnt != null) {
                    pStmnt.close();
                }
                if (cnnct != null) {
                    cnnct.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return num;
    }

    public String getApprovedStatistics(String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String num = null;
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusDays(30);
        LocalDate endDate = today;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS num FROM shop_borrow_request WHERE Status = 'Approved' AND RequestDate BETWEEN ? AND ? AND RequestTo = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setDate(1, java.sql.Date.valueOf(startDate));
            pStmnt.setDate(2, java.sql.Date.valueOf(endDate));
            pStmnt.setString(3, shopId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                num = rs.getString("num");
            }
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (pStmnt != null) {
                    pStmnt.close();
                }
                if (cnnct != null) {
                    cnnct.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return num;
    }

    public String getRejectedStatistics(String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String num = null;
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusDays(30);
        LocalDate endDate = today;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS num FROM shop_borrow_request WHERE Status = 'Rejected' AND RequestDate BETWEEN ? AND ? AND RequestTo = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setDate(1, java.sql.Date.valueOf(startDate));
            pStmnt.setDate(2, java.sql.Date.valueOf(endDate));
            pStmnt.setString(3, shopId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                num = rs.getString("num");
            }
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (pStmnt != null) {
                    pStmnt.close();
                }
                if (cnnct != null) {
                    cnnct.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return num;
    }

    public boolean updateBorrowRequestStatus(String requestId, String status, String rejectReason,
            String rejectDetail) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "";
            if (status.equalsIgnoreCase("Approved")) {
                preQueryStatement = "UPDATE shop_borrow_request SET Status=? , Completed=? WHERE ID=?;";
            } else if (status.equalsIgnoreCase("Rejected")) {
                if (rejectDetail == null || rejectDetail.isEmpty()) {
                    preQueryStatement = "UPDATE shop_borrow_request SET Status=?, RejectReason=?, RejectDetail=NULL WHERE ID=?;";
                } else {
                    preQueryStatement = "UPDATE shop_borrow_request SET Status=?, RejectReason=?, RejectDetail=? WHERE ID=?;";
                }
            }
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, status);

            if (status.equalsIgnoreCase("Approved")) {
                pStmnt.setString(2, "N");
                pStmnt.setString(3, requestId);
            } else if (status.equalsIgnoreCase("Rejected")) {
                pStmnt.setString(2, rejectReason);
                if (rejectDetail == null || rejectDetail.isEmpty()) {
                    pStmnt.setString(3, requestId);
                } else {
                    pStmnt.setString(3, rejectDetail);
                    pStmnt.setString(4, requestId);
                }
            }

            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean changeBorrowStatusToFinish(String orderId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "Update shop_borrow_request SET Completed = 'Y' WHERE ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    // for shop_borrow_request

    // for shop_borrow_request_item

    public boolean insertBorrowItem(String requestId, String fruitId, int qty) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO shop_borrow_request_item (BorrowRequestID,FruitID,Qty) VALUES(?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, requestId);
            pStmnt.setString(2, fruitId);
            pStmnt.setInt(3, qty);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public int getBorrowItemQty(String borrowId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int qty = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "Select Count(*) AS qty from shop_borrow_request_item where BorrowRequestID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, borrowId);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                qty = rs.getInt("qty");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return qty;
    }

    public ArrayList<BorrowBean> getBorrowItemById(String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        BorrowBean bb = null;
        ArrayList<BorrowBean> orderItemList = new ArrayList<BorrowBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT y.ID,y.Name,y.unit,z.City,a.Name AS CountryRegion,x.Qty FROM shop_borrow_request_item x, fruit y, fruit_city z, country_region a WHERE x.FruitID = y.ID and y.FruitCityID = z.ID and z.CountryRegionID = a.ID and x.BorrowRequestID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                bb = new BorrowBean();
                bb.setFruidId(rs.getString("ID"));
                bb.setFruitName(rs.getString("Name"));
                bb.setUnit(rs.getString("unit"));
                bb.setCity(rs.getString("City"));
                bb.setCountryRegion(rs.getString("CountryRegion"));
                bb.setQty(rs.getInt("Qty"));
                orderItemList.add(bb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return orderItemList;
    }
    // for shop_borrow_request_item

    // for reserveNeed.jsp
    public ArrayList<ReserveNeedBean> getResreveNeedByCountryRegion(String cn, String startDate, String endDate) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ReserveNeedBean rb = null;
        ArrayList<ReserveNeedBean> reserveNeedList = new ArrayList<ReserveNeedBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement;

            if ("all".equalsIgnoreCase(cn)) {
                // SQL without the country region filter
                preQueryStatement = "SELECT \n" +
                        "    sc.CountryRegionID AS ShopCountryID, \n" +
                        "    cr.Name AS ShopCountryName,\n" +
                        "    COUNT(DISTINCT sfo.ID) AS TotalOrders,\n" +
                        "    f.Name AS FruitItem, \n" +
                        "    f.type AS FruitType,\n" +
                        "    f.unit AS Unit,\n" +
                        "    fc.City AS FruitOriginCity,\n" +
                        "    fcr.Name AS FruitOriginCountry,\n" +
                        "    SUM(sfoi.Qty) AS TotalQuantity\n" +
                        "FROM \n" +
                        "    shop_fruit_order sfo\n" +
                        "JOIN \n" +
                        "    shop s ON sfo.ShopID = s.ID\n" +
                        "JOIN \n" +
                        "    shop_city sc ON s.City = sc.ID\n" +
                        "JOIN \n" +
                        "    country_region cr ON sc.CountryRegionID = cr.ID\n" +
                        "JOIN \n" +
                        "    shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID\n" +
                        "JOIN \n" +
                        "    fruit f ON sfoi.FruitID = f.ID\n" +
                        "JOIN\n" +
                        "    fruit_city fc ON f.FruitCityID = fc.ID\n" +
                        "JOIN\n" +
                        "    country_region fcr ON fc.CountryRegionID = fcr.ID\n" +
                        "WHERE sfo.OrderDate Between ? AND ?\n" +
                        "GROUP BY \n" +
                        "    sc.CountryRegionID, f.ID\n" +
                        "ORDER BY \n" +
                        "    cr.Name, SUM(sfoi.Qty) DESC;";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, startDate);
                pStmnt.setString(2, endDate);
            } else {
                // Original SQL with country region filter
                preQueryStatement = "SELECT \n" +
                        "    sc.CountryRegionID AS ShopCountryID, \n" +
                        "    cr.Name AS ShopCountryName,\n" +
                        "    COUNT(DISTINCT sfo.ID) AS TotalOrders,\n" +
                        "    f.Name AS FruitItem, \n" +
                        "    f.type AS FruitType,\n" +
                        "    f.unit AS Unit,\n" +
                        "    fc.City AS FruitOriginCity,\n" +
                        "    fcr.Name AS FruitOriginCountry,\n" +
                        "    SUM(sfoi.Qty) AS TotalQuantity\n" +
                        "FROM \n" +
                        "    shop_fruit_order sfo\n" +
                        "JOIN \n" +
                        "    shop s ON sfo.ShopID = s.ID\n" +
                        "JOIN \n" +
                        "    shop_city sc ON s.City = sc.ID\n" +
                        "JOIN \n" +
                        "    country_region cr ON sc.CountryRegionID = cr.ID\n" +
                        "JOIN \n" +
                        "    shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID\n" +
                        "JOIN \n" +
                        "    fruit f ON sfoi.FruitID = f.ID\n" +
                        "JOIN\n" +
                        "    fruit_city fc ON f.FruitCityID = fc.ID\n" +
                        "JOIN\n" +
                        "    country_region fcr ON fc.CountryRegionID = fcr.ID\n" +
                        "WHERE sc.CountryRegionID = ?\n" +
                        "AND sfo.OrderDate BETWEEN ? AND ?\n" +
                        "GROUP BY \n" +
                        "    sc.CountryRegionID, f.ID\n" +
                        "ORDER BY \n" +
                        "    cr.Name, SUM(sfoi.Qty) DESC;";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, cn);
                pStmnt.setString(2, startDate);
                pStmnt.setString(3, endDate);
            }

            ResultSet rs = pStmnt.executeQuery();

            while (rs.next()) {
                rb = new ReserveNeedBean();
                rb.setCountryRegionName(rs.getString("ShopCountryName"));
                rb.setTotalOrders(rs.getString("TotalOrders"));
                rb.setFruitName(rs.getString("FruitItem"));
                rb.setFruitType(rs.getString("FruitType"));
                rb.setUnit(rs.getString("Unit"));
                rb.setOriginCity(rs.getString("FruitOriginCity"));
                rb.setOriginCountry(rs.getString("FruitOriginCountry"));
                rb.setTotalQty(rs.getString("TotalQuantity"));
                reserveNeedList.add(rb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reserveNeedList;
    }

    public ArrayList<ReserveNeedBean> getResreveNeedByCity(String city, String startDate, String endDate) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ReserveNeedBean rb = null;
        ArrayList<ReserveNeedBean> reserveNeedList = new ArrayList<ReserveNeedBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement;

            if ("all".equalsIgnoreCase(city)) {
                preQueryStatement = "SELECT \n" +
                        "    sc.ID AS CityID, \n" +
                        "    sc.City AS CityName, \n" +
                        "    cr.ID AS CountryID, \n" +
                        "    cr.Name AS CountryName, \n" +
                        "    COUNT(DISTINCT sfo.ID) AS TotalOrders, \n" +
                        "    f.ID AS FruitID, \n" +
                        "    f.Name AS FruitItem, \n" +
                        "    f.type AS FruitType, \n" +
                        "    f.unit AS Unit, \n" +
                        "    SUM(sfoi.Qty) AS TotalQuantity \n" +
                        "FROM \n" +
                        "    shop_fruit_order sfo \n" +
                        "    JOIN shop s ON sfo.ShopID = s.ID \n" +
                        "    JOIN shop_city sc ON s.City = sc.ID \n" +
                        "    JOIN country_region cr ON sc.CountryRegionID = cr.ID \n" +
                        "    JOIN shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID \n" +
                        "    JOIN fruit f ON sfoi.FruitID = f.ID \n WHERE sfo.OrderDate BETWEEN ? AND ?" +
                        "GROUP BY \n" +
                        "    sc.ID, \n" +
                        "    f.ID \n" +
                        "ORDER BY \n" +
                        "    cr.Name, \n" +
                        "    sc.City, \n" +
                        "    SUM(sfoi.Qty) DESC;\n";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, startDate);
                pStmnt.setString(2, endDate);
            } else {
                preQueryStatement = "SELECT \n" +
                        "    sc.ID AS CityID, \n" +
                        "    sc.City AS CityName, \n" +
                        "    cr.ID AS CountryID, \n" +
                        "    cr.Name AS CountryName, \n" +
                        "    COUNT(DISTINCT sfo.ID) AS TotalOrders, \n" +
                        "    f.ID AS FruitID, \n" +
                        "    f.Name AS FruitItem, \n" +
                        "    f.type AS FruitType, \n" +
                        "    f.unit AS Unit, \n" +
                        "    SUM(sfoi.Qty) AS TotalQuantity \n" +
                        "FROM \n" +
                        "    shop_fruit_order sfo \n" +
                        "    JOIN shop s ON sfo.ShopID = s.ID \n" +
                        "    JOIN shop_city sc ON s.City = sc.ID \n" +
                        "    JOIN country_region cr ON sc.CountryRegionID = cr.ID \n" +
                        "    JOIN shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID \n" +
                        "    JOIN fruit f ON sfoi.FruitID = f.ID \n WHERE sc.City = ? AND sfo.OrderDate BETWEEN ? AND ?"
                        +
                        "GROUP BY \n" +
                        "    sc.ID, \n" +
                        "    f.ID \n" +
                        "ORDER BY \n" +
                        "    cr.Name, \n" +
                        "    sc.City, \n" +
                        "    SUM(sfoi.Qty) DESC;\n";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, city);
                pStmnt.setString(2, startDate);
                pStmnt.setString(3, endDate);
            }
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                rb = new ReserveNeedBean();
                rb.setCityName(rs.getString("CityName"));
                rb.setCountryRegionName(rs.getString("CountryName"));
                rb.setTotalOrders(rs.getString("TotalOrders"));
                rb.setFruitName(rs.getString("FruitItem"));
                rb.setFruitType(rs.getString("FruitType"));
                rb.setUnit(rs.getString("Unit"));
                rb.setTotalQty(rs.getString("TotalQuantity"));
                reserveNeedList.add(rb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reserveNeedList;
    }

    public ArrayList<ReserveNeedBean> getResreveNeedByShop(String shop, String startDate, String endDate) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ReserveNeedBean rb = null;
        ArrayList<ReserveNeedBean> reserveNeedList = new ArrayList<ReserveNeedBean>();

        try {
            cnnct = getConnection();
            String preQueryStatement;

            if ("all".equalsIgnoreCase(shop)) {
                preQueryStatement = "SELECT \n" +
                        "    s.ID AS ShopID, \n" +
                        "    s.Address AS ShopAddress, \n" +
                        "    sc.ID AS CityID, \n" +
                        "    sc.City AS CityName, \n" +
                        "    cr.ID AS CountryID, \n" +
                        "    cr.Name AS CountryName, \n" +
                        "    COUNT(DISTINCT sfo.ID) AS TotalOrders, \n" +
                        "    f.ID AS FruitID, \n" +
                        "    f.Name AS FruitItem, \n" +
                        "    f.type AS FruitType, \n" +
                        "    f.unit AS Unit, \n" +
                        "    SUM(sfoi.Qty) AS TotalQuantity \n" +
                        "FROM \n" +
                        "    shop_fruit_order sfo \n" +
                        "    JOIN shop s ON sfo.ShopID = s.ID \n" +
                        "    JOIN shop_city sc ON s.City = sc.ID \n" +
                        "    JOIN country_region cr ON sc.CountryRegionID = cr.ID \n" +
                        "    JOIN shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID \n" +
                        "    JOIN fruit f ON sfoi.FruitID = f.ID WHERE sfo.OrderDate BETWEEN ? AND ? \n" +
                        "GROUP BY \n" +
                        "    s.ID, \n" +
                        "    f.ID \n" +
                        "ORDER BY \n" +
                        "    cr.Name, \n" +
                        "    sc.City, \n" +
                        "    s.ID, \n" +
                        "    SUM(sfoi.Qty) DESC;\n";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, startDate);
                pStmnt.setString(2, endDate);
            } else {
                preQueryStatement = "SELECT \n" +
                        "    s.ID AS ShopID, \n" +
                        "    s.Address AS ShopAddress, \n" +
                        "    sc.ID AS CityID, \n" +
                        "    sc.City AS CityName, \n" +
                        "    cr.ID AS CountryID, \n" +
                        "    cr.Name AS CountryName, \n" +
                        "    COUNT(DISTINCT sfo.ID) AS TotalOrders, \n" +
                        "    f.ID AS FruitID, \n" +
                        "    f.Name AS FruitItem, \n" +
                        "    f.type AS FruitType, \n" +
                        "    f.unit AS Unit, \n" +
                        "    SUM(sfoi.Qty) AS TotalQuantity \n" +
                        "FROM \n" +
                        "    shop_fruit_order sfo \n" +
                        "    JOIN shop s ON sfo.ShopID = s.ID \n" +
                        "    JOIN shop_city sc ON s.City = sc.ID \n" +
                        "    JOIN country_region cr ON sc.CountryRegionID = cr.ID \n" +
                        "    JOIN shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID \n" +
                        "    JOIN fruit f ON sfoi.FruitID = f.ID \n" +
                        "WHERE \n" +
                        "    s.Address = ? \n" +
                        "    AND sfo.OrderDate BETWEEN ? AND ?  \n" +
                        "GROUP BY \n" +
                        "    s.ID, \n" +
                        "    f.ID \n" +
                        "ORDER BY \n" +
                        "    ShopAddress ASC;\n";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, shop);
                pStmnt.setString(2, startDate);
                pStmnt.setString(3, endDate);
            }
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                rb = new ReserveNeedBean();
                rb.setShopAddress(rs.getString("ShopAddress"));
                rb.setCityName(rs.getString("CityName"));
                rb.setCountryRegionName(rs.getString("CountryName"));
                rb.setTotalOrders(rs.getString("TotalOrders"));
                rb.setFruitName(rs.getString("FruitItem"));
                rb.setFruitType(rs.getString("FruitType"));
                rb.setUnit(rs.getString("Unit"));
                rb.setTotalQty(rs.getString("TotalQuantity"));
                reserveNeedList.add(rb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reserveNeedList;
    }

    public ArrayList<String> getAllShopAddress() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> shopAddressList = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT Address FROM shop;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                shopAddressList.add(rs.getString("Address"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return shopAddressList;
    }

    public int getTotalReserveNumber() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int totalReserveNumber = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS t FROM shop_fruit_order;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                totalReserveNumber = rs.getInt("t");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return totalReserveNumber;
    }

    public int getTotalFruitOrdered() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int totalReserveNumber = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT SUM(Qty) AS t FROM shop_fruit_order_item;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                totalReserveNumber = rs.getInt("t");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return totalReserveNumber;
    }

    public HashMap<String, Integer> getTopFive() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        HashMap<String, Integer> topFive = new HashMap<>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT \n" +
                    "    f.ID AS FruitID,\n" +
                    "    f.Name AS FruitName,\n" +
                    "    f.type AS FruitType, \n" +
                    "    f.unit AS Unit,\n" +
                    "    SUM(sfoi.Qty) AS TotalQuantity\n" +
                    "FROM \n" +
                    "    shop_fruit_order_item sfoi\n" +
                    "JOIN \n" +
                    "    shop_fruit_order sfo ON sfoi.OrderID = sfo.ID\n" +
                    "JOIN \n" +
                    "    fruit f ON sfoi.FruitID = f.ID\n" +
                    "WHERE f.unit = 'piece'\n" +
                    "GROUP BY \n" +
                    "    f.ID, f.Name, f.type, f.unit\n" +
                    "ORDER BY \n" +
                    "    TotalQuantity DESC\n" +
                    "LIMIT 5;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                topFive.put(rs.getString("FruitName"), rs.getInt("TotalQuantity"));
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return topFive;
    }

    // for reserveNeed.jsp

    // ------- UserList ------- UserList ------- UserList ------- UserList
    // Get user list by type
    public ArrayList<UserBean> getAllUser(String type) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<UserBean> userList = new ArrayList<UserBean>();
        try {
            cnnct = getConnection();
            if (type.equals("warehouse")) {
                String preQueryStatement = "SELECT ws.UserID, ws.StaffName, ws.Role, ws.WarehouseID \n" +
                        "FROM warehouse_staff ws\n" +
                        "JOIN user u ON ws.UserID = u.UserID \n" +
                        "WHERE u.Status = 'enable';";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = pStmnt.executeQuery();
                while (rs.next()) {
                    UserBean ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setStaffName(rs.getString("StaffName"));
                    ub.setRole(rs.getString("Role"));
                    ub.setPlaceId(rs.getString("WarehouseID"));
                    userList.add(ub);
                }
            } else if (type.equals("shop")) {
                String preQueryStatement = "SELECT ss.UserID, ss.StaffName, ss.Role, ss.ShopID \n" +
                        "FROM shop_staff ss\n" +
                        "JOIN user u ON ss.UserID = u.UserID \n" +
                        "WHERE u.Status = 'enable';";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = pStmnt.executeQuery();
                while (rs.next()) {
                    UserBean ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setStaffName(rs.getString("StaffName"));
                    ub.setRole(rs.getString("Role"));
                    ub.setPlaceId(rs.getString("ShopID"));
                    userList.add(ub);
                }
            } else if (type.equals("seniorManagement")) {
                String preQueryStatement = "SELECT ws.UserID, ws.StaffName, ws.Role, ws.WarehouseID AS PlaceID\n" +
                        "FROM warehouse_staff ws\n" +
                        "JOIN user u ON ws.UserID = u.UserID \n" +
                        "WHERE u.Status = 'enable'\n" +
                        "UNION ALL\n" +
                        "SELECT ss.UserID, ss.StaffName, ss.Role, ss.ShopID AS PlaceID\n" +
                        "FROM shop_staff ss\n" +
                        "JOIN user u ON ss.UserID = u.UserID \n" +
                        "WHERE u.Status = 'enable';";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                ResultSet rs = pStmnt.executeQuery();
                while (rs.next()) {
                    UserBean ub = new UserBean();
                    ub.setUserId(rs.getString("UserID"));
                    ub.setStaffName(rs.getString("StaffName"));
                    ub.setRole(rs.getString("Role"));
                    ub.setPlaceId(rs.getString("PlaceID"));
                    userList.add(ub);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return userList;
    }

    // ------- Profile ------- Profile ------- Profile ------- Profile
    // For update password
    public boolean updatePassword(String UserID, String encrypedPass) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;

        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE user SET Password = ? WHERE UserID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, encrypedPass);
            pStmnt.setString(2, UserID);

            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    // For update staff name
    public boolean updateStaffName(String staffName, String UserID, String type) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;

        try {
            cnnct = getConnection();
            if (type.equals("warehouse")) {
                String preQueryStatement = "UPDATE warehouse_staff SET staffname = ? WHERE UserID = ?";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, staffName);
                pStmnt.setString(2, UserID);
            } else if (type.equals("shop")) {
                String preQueryStatement = "UPDATE shop_staff SET staffname = ? WHERE UserID = ?";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, staffName);
                pStmnt.setString(2, UserID);
            } else if (type.equals("senior")) {
                String preQueryStatement = "UPDATE senior_management_staff SET staffname = ? WHERE UserID = ?";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, staffName);
                pStmnt.setString(2, UserID);
            }
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    // ------- Warehouse ------- Warehouse ------- Warehouse ------- Warehouse
    public List<OrderBean> getStatistics(String v1, int warehouseType) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        List<OrderBean> orderList = new ArrayList<>();
        try {
            cnnct = getConnection();
            if (warehouseType == 0) {
                String preQueryStatement = "SELECT DATE(sfo.OrderDate) AS OrderDate, COUNT(*) AS total\n" +
                        "FROM shop_fruit_order sfo\n" +
                        "JOIN shop s ON sfo.ShopID = s.ID\n" +
                        "JOIN shop_city sc ON s.City = sc.ID\n" +
                        "JOIN country_region crid ON crid.ID = sc.CountryRegionID\n" +
                        "WHERE sfo.OrderDate >= NOW() - INTERVAL 7 DAY\n" +
                        "AND crid.name = ?\n" +
                        "GROUP BY DATE(sfo.OrderDate)\n" +
                        "ORDER BY DATE(sfo.OrderDate);";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, v1);
            } else {
                String preQueryStatement = "SELECT DATE(sfo.OrderDate) AS OrderDate, COUNT(*) AS total\n" +
                        "FROM shop_fruit_order sfo\n" +
                        "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.ID\n" +
                        "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                        "WHERE sfo.OrderDate >= NOW() - INTERVAL 7 DAY\n" +
                        "AND f.FruitCityID = ?\n" +
                        "GROUP BY DATE(sfo.OrderDate)\n" +
                        "ORDER BY DATE(sfo.OrderDate);";
                pStmnt = cnnct.prepareStatement(preQueryStatement);
                pStmnt.setString(1, v1);
            }
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                OrderBean ob = new OrderBean();
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setQty(rs.getInt("total"));
                orderList.add(ob);
            }
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (pStmnt != null) {
                    pStmnt.close();
                }
                if (cnnct != null) {
                    cnnct.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return orderList;
    }

    public ArrayList<OrderBean> getWarehouseOrderCentral(String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<OrderBean> order = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, sfo.ShopId, sfo.OrderDate, sfo.Status, COUNT(sfoi.FruitID) AS ItemCount\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop s ON s.ID = sfo.ShopId\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN shop_city sc ON s.City = sc.ID\n" +
                    "JOIN warehouse w ON sc.CountryRegionID = w.CountryRegionID\n" +
                    "WHERE w.ID = ? AND sfo.Status != 'delivered'\n" +
                    "GROUP BY sfo.ID, sfo.ShopID, sfo.OrderDate, sfo.Status ORDER BY sfo.ID DESC;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                OrderBean ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopId"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setUnit(rs.getString("ItemCount"));
                order.add(ob);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public int checkStockCentral(String warehouseId, String orderId) {
        int itemCount = 0;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT wfs.FruitID, SUM(wfs.Qty) AS total_stock, sfoi.Qty AS order_quantity\n" +
                    "FROM warehouse_fruit_stock wfs\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfoi.FruitID = wfs.FruitID\n" +
                    "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID \n" +
                    "WHERE sfoi.OrderID = ? AND wfs.WarehouseID = ?\n" +
                    "GROUP BY wfs.FruitID, sfoi.Qty\n" +
                    "HAVING total_stock > sfoi.Qty;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                itemCount++;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return itemCount;
    }

    public ArrayList<OrderBean> getWarehouseOrderSource(String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<OrderBean> order = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, sfo.ShopID, sfo.OrderDate, sfoi.Status, COUNT(sfoi.FruitID) AS ItemCount\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.ID\n" +
                    "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                    "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                    "JOIN warehouse w ON w.SourceCity = fc.ID\n" +
                    "WHERE w.ID = ?\n" +
                    "GROUP BY sfo.ID, sfo.ShopID, sfo.OrderDate, sfoi.Status ORDER BY sfo.ID DESC;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                OrderBean ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopId"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setUnit(rs.getString("ItemCount"));
                order.add(ob);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public boolean processOrderCentral(String orderId) {
        boolean isSuccess = false;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order SET Status = 'Processing' WHERE ID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean processOrderSource(String orderId, String warehouseId) {
        boolean isSuccess = false;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order_item sfoi\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON f.FruitCityID = w.SourceCity\n" +
                    "SET sfoi.Status = 'Processing' WHERE sfoi.OrderID = ? AND w.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, warehouseId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean deliveredOrderCentral(String orderId) {
        boolean isSuccess = false;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order SET Status = 'Delivered', DeliveryDate = CURRENT_DATE WHERE ID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean deliveredOrderSource(String orderId, String warehouseId) {
        boolean isSuccess = false;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order_item sfoi\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON f.FruitCityID = w.SourceCity\n" +
                    "SET sfoi.Status = 'Delivered'\n" +
                    "WHERE sfoi.OrderID = ? AND w.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, warehouseId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean deliveredAllOrder(String warehouseId, String country) {
        boolean isSuccess = false;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order_item sfoi\n" +
                    "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON s.City = sc.ID\n" +
                    "SET sfoi.Status = 'Delivered'\n" +
                    "WHERE w.ID = ? AND sc.CountryRegionID = ? AND sfoi.Status = 'Processing';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, country);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean updateWarehouseStock(String orderId, String warehouseId) {
        boolean isSuccess = false;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE warehouse_fruit_stock AS w\n" +
                    "JOIN shop_fruit_order_item AS oi ON w.FruitID = oi.FruitID\n" +
                    "JOIN shop_fruit_order AS o ON oi.OrderID = o.ID\n" +
                    "SET w.Qty = w.Qty - oi.Qty\n" +
                    "WHERE o.ID = ? AND w.WarehouseID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, warehouseId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public ArrayList<OrderBean> getWarehouseDeliverCentral(String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<OrderBean> order = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, sfo.ShopId, sfo.OrderDate, sfo.Status, COUNT(sfoi.FruitID) AS ItemCount\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop s ON s.ID = sfo.ShopId\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN shop_city sc ON s.City = sc.ID\n" +
                    "JOIN warehouse w ON sc.CountryRegionID = w.CountryRegionID\n" +
                    "WHERE w.ID = ? AND sfo.Status != 'Pending'\n" +
                    "GROUP BY sfo.ID, sfo.ShopID, sfo.OrderDate, sfo.Status ORDER BY sfo.ID DESC;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                OrderBean ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopId"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setUnit(rs.getString("ItemCount"));
                order.add(ob);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public ArrayList<OrderBean> getWarehouseDeliverSource(String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<OrderBean> order = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, sfo.ShopID, sfo.OrderDate, sfoi.Status, COUNT(sfoi.FruitID) AS ItemCount\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.ID\n" +
                    "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                    "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                    "JOIN warehouse w ON w.SourceCity = fc.ID\n" +
                    "WHERE w.ID = ? AND sfoi.Status != 'Pending'\n" +
                    "GROUP BY sfo.ID, sfo.ShopID, sfo.OrderDate, sfoi.Status;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                OrderBean ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("ShopId"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setUnit(rs.getString("ItemCount"));
                order.add(ob);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public OrderBean getOrderByIdCental(String orderID) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean order = new OrderBean();
        ArrayList<FruitsBean> fb = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, sfo.ShopID, sc.City, sfo.OrderDate, sfo.Status, f.Name, fc.City AS FCity, sfoi.Qty, f.unit, sfo.Notes\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                    "JOIN fruit_city fc ON f.FruitCityID = fc.ID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON s.City = sc.ID\n" +
                    "WHERE sfo.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderID);
            ResultSet rs = pStmnt.executeQuery();

            if (rs.next()) {
                order.setId(rs.getString("ID"));
                order.setShopId(rs.getString("ShopID"));
                order.setCity(rs.getString("City"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setStatus(rs.getString("Status"));
                order.setNotes(rs.getString("Notes"));

                do {
                    FruitsBean fruitBean = new FruitsBean();
                    fruitBean.setName(rs.getString("Name"));
                    fruitBean.setCity(rs.getString("FCity"));
                    fruitBean.setQty(rs.getString("Qty"));
                    fruitBean.setUnit(rs.getString("unit"));

                    fb.add(fruitBean);
                } while (rs.next());
            }

            order.setFruitsBean(fb);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public OrderBean getOrderByIdSource(String warehouseId, String orderID) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean order = new OrderBean();
        ArrayList<FruitsBean> fb = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, sfo.ShopID, sc.City, sfo.OrderDate, sfoi.Qty, sfoi.Status, f.Name, fc.City AS FCity, f.unit, sfo.Notes\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.ID\n" +
                    "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                    "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                    "JOIN warehouse w ON w.SourceCity = fc.ID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON sc.ID = s.City\n" +
                    "WHERE w.ID = ? AND sfo.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, orderID);
            ResultSet rs = pStmnt.executeQuery();

            if (rs.next()) {
                order.setId(rs.getString("ID"));
                order.setShopId(rs.getString("ShopID"));
                order.setCity(rs.getString("City"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setStatus(rs.getString("Status"));
                order.setNotes(rs.getString("Notes"));

                do {
                    FruitsBean fruitBean = new FruitsBean();
                    fruitBean.setName(rs.getString("Name"));
                    fruitBean.setCity(rs.getString("FCity"));
                    fruitBean.setQty(rs.getString("Qty"));
                    fruitBean.setUnit(rs.getString("unit"));

                    fb.add(fruitBean);
                } while (rs.next());
            }

            order.setFruitsBean(fb);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public OrderBean getOrderByIdRestock(String warehouseId, String orderID, String centralLocation) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        OrderBean order = new OrderBean();
        ArrayList<FruitsBean> fb = new ArrayList<FruitsBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, sfo.ShopID, sc.City, sfo.OrderDate, sfoi.Qty, sfoi.Status, f.Name, fc.City AS FCity, f.unit, sfo.Notes, w.ID AS warehouseId\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.ID\n" +
                    "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                    "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                    "JOIN warehouse w ON w.SourceCity = fc.ID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON sc.ID = s.City\n" +
                    "JOIN country_region cr ON sc.CountryRegionID = cr.ID\n" +
                    "WHERE w.ID = ? AND sfo.ID = ? AND cr.Name= ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, orderID);
            pStmnt.setString(3, centralLocation);
            ResultSet rs = pStmnt.executeQuery();

            if (rs.next()) {
                order.setId(rs.getString("ID"));
                order.setShopId(rs.getString("ShopID"));
                order.setCity(rs.getString("City"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setStatus(rs.getString("Status"));
                order.setNotes(rs.getString("Notes"));
                order.setWarehouseId(rs.getString("warehouseId"));
                do {
                    FruitsBean fruitBean = new FruitsBean();
                    fruitBean.setName(rs.getString("Name"));
                    fruitBean.setCity(rs.getString("FCity"));
                    fruitBean.setQty(rs.getString("Qty"));
                    fruitBean.setUnit(rs.getString("unit"));

                    fb.add(fruitBean);
                } while (rs.next());
            }

            order.setFruitsBean(fb);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public int getNoOfItemInOrder(String orderId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int total = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS count FROM `shop_fruit_order_item` WHERE OrderID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                total = Integer.valueOf(rs.getString("count"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }

    public int getNoOfItemInOrderSource(String orderId, String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        int total = 0;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(DISTINCT f.ID) AS count\n" +
                    "FROM shop_fruit_order_item sfo\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.OrderID\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "WHERE sfo.OrderID = ? AND w.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                total = Integer.valueOf(rs.getString("count"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }

    // For static bar
    public ArrayList<WarehouseFruitStockBean> getWarehouseFruitStock(String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<WarehouseFruitStockBean> warehouseStockList = new ArrayList<WarehouseFruitStockBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Name,y.type,y.unit,y.ImgName,z.City,aa.Name AS CR FROM warehouse_fruit_stock x, fruit y, fruit_city z, country_region aa WHERE WarehouseID = ? and x.FruitID = y.ID and y.FruitCityID = z.ID and z.CountryRegionID = aa.ID AND y.Status = 'enable';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                WarehouseFruitStockBean wb = new WarehouseFruitStockBean();
                wb.setWareHouseId(rs.getString("WarehouseID"));
                wb.setFruitId(rs.getString("FruitID"));
                wb.setFruitName(rs.getString("Name"));
                wb.setCity(rs.getString("City"));
                wb.setCountryRegion(rs.getString("CR"));
                wb.setImgName(rs.getString("ImgName"));
                wb.setQty(String.valueOf(rs.getInt("Qty")));
                wb.setType(rs.getString("type"));
                wb.setUnit(rs.getString("unit"));
                warehouseStockList.add(wb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return warehouseStockList;
    }

    // For the stock list
    public ArrayList<ShopFruitStockBean> getWarehouseStock(String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ShopFruitStockBean> shopStockList = new ArrayList<ShopFruitStockBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.*,y.Name,y.type,y.unit,y.ImgName,z.City,aa.Name AS CR FROM warehouse_fruit_stock x, fruit y, fruit_city z, country_region aa WHERE WarehouseID = ? and x.FruitID = y.ID and y.FruitCityID = z.ID and z.CountryRegionID = aa.ID and y.Status = 'enable';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                ShopFruitStockBean sb = new ShopFruitStockBean();
                sb.setShopId(rs.getString("WarehouseID"));
                sb.setFruitId(rs.getString("FruitID"));
                sb.setFruitName(rs.getString("Name"));
                sb.setCity(rs.getString("City"));
                sb.setCountryRegion(rs.getString("CR"));
                sb.setImgName(rs.getString("ImgName"));
                sb.setQty(String.valueOf(rs.getInt("Qty")));
                sb.setType(rs.getString("type"));
                sb.setUnit(rs.getString("unit"));
                shopStockList.add(sb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return shopStockList;
    }
    
    public boolean updateWarehouseFruitStock(String warehouseId, String fruitId, int qty) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE warehouse_fruit_stock SET Qty = ? WHERE WarehouseID = ? AND FruitID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setInt(1, qty);
            pStmnt.setString(2, warehouseId);
            pStmnt.setString(3, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public ArrayList<WarehouseBean> getAllWarehouse() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<WarehouseBean> warehouseList = new ArrayList<WarehouseBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT x.ID, x.PhoneNumber, z.name AS CountryRegionName, x.Type, fc.City\n" +
                    "FROM warehouse x\n" +
                    "LEFT JOIN country_region z ON x.CountryRegionID = z.ID\n" +
                    "LEFT JOIN fruit_city fc ON fc.ID = x.SourceCity\n" +
                    "ORDER BY x.ID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                WarehouseBean wb = new WarehouseBean();
                wb.setId(rs.getString("ID"));
                wb.setPhoneNumber(rs.getString("PhoneNumber"));
                wb.setType(rs.getString("Type"));
                wb.setCity(rs.getString("City"));
                wb.setCountryRegion(rs.getString("CountryRegionName"));
                warehouseList.add(wb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return warehouseList;
    }

    public ArrayList<String> getAllWarehouseCity() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> cityList = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT DISTINCT fc.City FROM warehouse x, fruit_city fc WHERE x.SourceCity = fc.ID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                cityList.add(rs.getString("City"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return cityList;
    }

    public ArrayList<String> getAllWarehouseCountry() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> countryList = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT DISTINCT cr.name AS Country FROM warehouse w, country_region cr WHERE w.CountryRegionID = cr.ID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                countryList.add(rs.getString("Country"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return countryList;
    }

    public ArrayList<OrderBean> getOrderFromSource(String centralLocation) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<OrderBean> order = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, w.ID AS warehouseID, sfo.OrderDate, sfoi.Status, COUNT(DISTINCT f.ID) AS ItemCount \n" +
                                            "FROM shop_fruit_order sfo \n" +
                                            "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.ID \n" +
                                            "JOIN fruit f ON sfoi.FruitID = f.ID \n" +
                                            "JOIN fruit_city fc ON fc.ID = f.FruitCityID \n" +
                                            "JOIN warehouse w ON w.SourceCity = fc.ID \n" +
                                            "JOIN shop s ON s.ID = sfo.ShopID \n" +
                                            "JOIN shop_city sc ON s.City = sc.ID \n" +
                                            "JOIN country_region cr ON cr.ID = sc.CountryRegionID \n" +
                                            "WHERE  cr.Name = ? AND sfoi.Status != 'Pending' \n" +
                                            "GROUP BY sfo.ID, w.ID, sfo.OrderDate, sfoi.Status, f.ID \n" +
                                            "ORDER BY sfo.ID DESC;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, centralLocation);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                OrderBean ob = new OrderBean();
                ob.setId(rs.getString("ID"));
                ob.setShopId(rs.getString("warehouseID"));
                ob.setOrderDate(rs.getString("OrderDate"));
                ob.setStatus(rs.getString("Status"));
                ob.setUnit(rs.getString("ItemCount"));
                order.add(ob);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public boolean upadateOrderFromSource(String warehouseId, String orderId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order_item sfoi\n" +
                    "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "SET sfoi.Status = 'Finished'\n" +
                    "WHERE w.ID = ? AND sfoi.OrderID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, orderId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean upadateAllOrderFromSource(String country) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order_item sfoi\n" +
                    "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN shop s ON sfo.ShopID = s.ID\n" +
                    "JOIN shop_city sc ON s.City = sc.ID\n" +
                    "JOIN country_region cr ON sc.CountryRegionID = cr.ID\n" +
                    "SET sfoi.Status = 'Finished'\n" +
                    "WHERE cr.Name = ? AND sfoi.Status = 'Delivered';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, country);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean processOrderAcceptAll(String warehouseId, String country) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order_item sfoi\n" +
                    "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON s.City = sc.ID\n" +
                    "SET sfoi.Status = 'Processing'\n" +
                    "WHERE w.ID = ? AND sc.CountryRegionID = ? AND sfoi.Status = 'Pending';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, country);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean upadateOrderAcceptAll(String warehouseId, String country) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE warehouse_fruit_stock wfs\n" +
                    "INNER JOIN (\n" +
                    "    SELECT f.ID AS fruitID, SUM(sfoi.Qty) AS Total, f.unit\n" +
                    "    FROM shop_fruit_order_item sfoi\n" +
                    "    JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "    JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "    JOIN shop_city sc ON sc.ID = s.City\n" +
                    "    JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "    JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "    WHERE w.ID = ? AND sc.CountryRegionID = ? AND sfoi.Status = 'Pending'\n" +
                    "    GROUP BY f.ID, f.unit\n" +
                    ") AS s ON s.fruitID = wfs.FruitID\n" +
                    "SET wfs.Qty = wfs.Qty - s.Total\n" +
                    "WHERE wfs.WarehouseID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, country);
            pStmnt.setString(3, warehouseId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean upadateStockFromSource(String centralId, String orderId, String sourceId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE warehouse_fruit_stock AS wfs\n" +
                    "JOIN shop_fruit_order_item AS oi ON wfs.FruitID = oi.FruitID\n" +
                    "JOIN shop_fruit_order AS o ON oi.OrderID = o.ID\n" +
                    "JOIN fruit f ON f.ID = oi.FruitID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "SET wfs.Qty = wfs.Qty + oi.Qty\n" +
                    "WHERE o.ID = ? AND wfs.WarehouseID = ? AND w.ID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
            pStmnt.setString(2, centralId);
            pStmnt.setString(3, sourceId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public boolean upadateAllStockFromSource(String country, String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE warehouse_fruit_stock wfs\n" +
                    "INNER JOIN (\n" +
                    "    SELECT f.ID AS fruitID, SUM(sfoi.Qty) AS Total, f.unit\n" +
                    "    FROM shop_fruit_order_item sfoi\n" +
                    "    JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "    JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "    JOIN shop_city sc ON sc.ID = s.City\n" +
                    "    JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "    JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "    JOIN country_region cr ON sc.CountryRegionID = cr.ID\n" +
                    "    WHERE cr.Name = ? AND sfoi.Status = 'Delivered'\n" +
                    "    GROUP BY f.ID, f.unit\n" +
                    ") AS s ON s.fruitID = wfs.FruitID\n" +
                    "SET wfs.Qty = wfs.Qty + s.Total\n" +
                    "WHERE wfs.WarehouseID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, country);
            pStmnt.setString(2, warehouseId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public ArrayList<TotalQtyBean> getTotalQtyByCountry(String warehouseId, String country, String status) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<TotalQtyBean> tqbList = new ArrayList<TotalQtyBean>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT f.Name, SUM(sfoi.Qty) AS Total, f.unit\n" +
                    "FROM shop_fruit_order_item sfoi\n" +
                    "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON sc.ID = s.City\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "WHERE w.ID = ? AND sc.CountryRegionID = ? AND sfoi.Status = ? \n" +
                    "GROUP BY f.ID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, country);
            pStmnt.setString(3, status);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                TotalQtyBean tqb = new TotalQtyBean();
                tqb.setFruit(rs.getString("Name"));
                tqb.setTotal(rs.getString("Total"));
                tqb.setUnit(rs.getString("unit"));
                tqbList.add(tqb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return tqbList;
    }

    public int checkStockAcceptAll(String warehouseId, String country) {
        int itemCount = 0;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT f.Name, SUM(sfoi.Qty) AS Total, wfs.Qty\n" +
                    "FROM shop_fruit_order_item sfoi\n" +
                    "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON sc.ID = s.City\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "JOIN warehouse_fruit_stock wfs ON wfs.WarehouseID = w.ID\n" +
                    "WHERE w.ID = ? AND sc.CountryRegionID = ? AND sfoi.Status = 'Pending'\n" +
                    "GROUP BY f.ID\n" +
                    "HAVING wfs.Qty > Total;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, country);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                itemCount++;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return itemCount;
    }

    public int checkStockAcceptAllGetTotalItem(String warehouseId, String country, String status) {
        int itemCount = 0;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT f.Name, SUM(sfoi.Qty) AS Total, f.unit\n" +
                    "FROM shop_fruit_order_item sfoi\n" +
                    "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON sc.ID = s.City\n" +
                    "JOIN fruit f ON f.ID = sfoi.FruitID\n" +
                    "JOIN warehouse w ON w.SourceCity = f.FruitCityID\n" +
                    "WHERE w.ID = ? AND sc.CountryRegionID = ? AND sfoi.Status = ? \n" +
                    "GROUP BY f.ID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, warehouseId);
            pStmnt.setString(2, country);
            pStmnt.setString(3, status);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                itemCount++;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return itemCount;
    }

    public int getQtyOfDeliveredOrder(String country) {
        int itemCount = 0;
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT sfo.ID, w.ID AS warehouseID, sfo.OrderDate, sfoi.Status, COUNT(sfoi.FruitID) AS ItemCount\n"
                    +
                    "FROM shop_fruit_order sfo\n" +
                    "JOIN shop_fruit_order_item sfoi ON sfoi.OrderID = sfo.ID\n" +
                    "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                    "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                    "JOIN warehouse w ON w.SourceCity = fc.ID\n" +
                    "JOIN shop s ON s.ID = sfo.ShopID\n" +
                    "JOIN shop_city sc ON s.City = sc.ID\n" +
                    "JOIN country_region cr ON cr.ID = sc.CountryRegionID\n" +
                    "WHERE cr.Name = ? AND sfoi.status = 'Delivered' \n" +
                    "GROUP BY sfo.ID, sfo.ShopID, sfo.OrderDate, sfoi.Status;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, country);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                itemCount++;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return itemCount;
    }

    public ArrayList<String> getAllWarehouseId() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<String> warehosueIDList = new ArrayList<String>();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT ID from warehouse ORDER by id;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                warehosueIDList.add(rs.getString("ID"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return warehosueIDList;
    }

    public int getLastWarehouseStaffId() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String lastStaffId = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT MAX(ID) AS lastStaffId FROM warehouse_staff";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            if (rs.next()) {
                lastStaffId = rs.getString("lastStaffId");
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return Integer.parseInt(lastStaffId);
    }

    public boolean addNewWarehouseStaff(String userId, String staffName, String warehouseId, String userID,
            String role) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO warehouse_staff VALUES(?,?,?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, userId);
            pStmnt.setString(2, staffName);
            pStmnt.setString(3, warehouseId);
            pStmnt.setString(4, userID);
            pStmnt.setString(5, role);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }

    public String getWarehouseStaffIdByUserId(String userId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String staffId = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT ID FROM warehouse_staff WHERE UserID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, userId);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                staffId = rs.getString("ID");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return staffId;
    }

    public boolean updateWarehouseStaff(String staffId, String staffName, String role, String warehouseId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE warehouse_staff SET StaffName = ?, Role = ?, WarehouseID = ? WHERE ID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, staffName);
            pStmnt.setString(2, role);
            pStmnt.setString(3, warehouseId);
            pStmnt.setString(4, staffId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public String getAllFruitCount() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String total = "0";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS total FROM fruit;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                total = rs.getString("total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }
    
    public String getAllFruitCountEnable() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String total = "0";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS total FROM fruit WHERE Status = 'enable';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                total = rs.getString("total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }
    
    public String getAllFruitCountDisable() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String total = "0";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) AS total FROM fruit WHERE Status = 'disable';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                total = rs.getString("total");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }
    
    public boolean updateFruitById(String fruitId, String name, String type, String unit, String imgName) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE fruit SET Name = ?, type = ?, unit = ?, ImgName = ? WHERE ID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, name);
            pStmnt.setString(2, type);
            pStmnt.setString(3, unit);
            pStmnt.setString(4, imgName);
            pStmnt.setString(5, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean updateFruitStatusById(String fruitId, String status) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE fruit SET Status = ? WHERE ID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, status);
            pStmnt.setString(2, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean updateFruitDisableShopStock(String fruitId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_stock SET Qty = 0 WHERE FruitID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean updateFruitDisableWarehouseStock(String fruitId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE warehouse_fruit_stock SET Qty = 0 WHERE FruitID = ?;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean updateFruitDisableOrder(String fruitId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_fruit_order_item sfoi, shop_fruit_order sfo\n" +
                                        "SET sfoi.Status = 'Finished', sfo.Notes = CONCAT(COALESCE(sfo.Notes, ''), ' " + fruitId + " has removed from the shelves')\n" +
                                        "WHERE sfoi.OrderID = sfo.ID AND sfoi.FruitID = ? AND sfoi.status != 'Finished';";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean updateFruitDisableBorrow(String fruitId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "UPDATE shop_borrow_request sbr\n" +
                                        "JOIN shop_borrow_request_item sbri ON sbri.BorrowRequestID = sbr.ID\n" +
                                        "SET \n" +
                                        "    sbr.Status = CASE \n" +
                                        "        WHEN sbr.Status = 'Pending' THEN 'Rejected'\n" +
                                        "        ELSE sbr.Status \n" +
                                        "    END,\n" +
                                        "    sbr.RejectReason = CASE \n" +
                                        "        WHEN sbr.Status = 'Pending' THEN CONCAT(COALESCE(sbr.RejectReason, ''), '" + fruitId + ", has removed from the shelves')\n" +
                                        "        ELSE sbr.RejectReason \n" +
                                        "    END,\n" +
                                        "    sbr.Notes = CASE \n" +
                                        "        WHEN sbr.Status = 'Approved' THEN CONCAT(COALESCE(sbr.Notes, ''), '" + fruitId + " has removed from the shelves')\n" +
                                        "        ELSE sbr.Notes \n" +
                                        "    END\n" +
                                        "WHERE sbri.FruitID = ? \n" +
                                        "AND sbr.Status IN ('Pending', 'Approved');";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, fruitId);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public String getNewFruitID() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String total = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) + 1 AS newID FROM fruit;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                total = rs.getString("newID");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }
    
    public String getNewWarehouseID() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String total = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) + 1 AS newID FROM warehouse;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                total = rs.getString("newID");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }
    
    public String getFruitCityIdByCRId(String countryRegionID) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String fruitCityID = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT ID FROM fruit_city WHERE City = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, countryRegionID);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                fruitCityID = rs.getString("ID");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return fruitCityID;
    }
    
    public boolean insertNewFruit(FruitsBean fb) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO fruit VALUES(?, ?, ?, ?, ?, ?, 'enable');";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, fb.getId());
            pStmnt.setString(2, fb.getName());
            pStmnt.setString(3, fb.getType());
            pStmnt.setString(4, fb.getUnit());
            pStmnt.setString(5, fb.getImgName());
            pStmnt.setString(6, fb.getCountryRegion());
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean checkFruitCity(String city, String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ResultSet rs = null;
        boolean isSuccess = false;

        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) FROM fruit_city WHERE City = ? AND CountryRegionID = ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, city);
            pStmnt.setString(2, id);
            rs = pStmnt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                isSuccess = count >= 1;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        } 
        return isSuccess;
    }
    
    public String getNewFruitCityID() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        String total = "";
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) + 1 AS newID FROM fruit_city;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            if (rs.next()) {
                total = rs.getString("newID");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return total;
    }
    
    public boolean insertNewCity(String cityId, String city, String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO fruit_city VALUES(?, ?, ?);";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, cityId);
            pStmnt.setString(2, city);
            pStmnt.setString(3, id);
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean insertNewSource(WarehouseBean wb) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO warehouse VALUES(?, ?, ?, ?, ?);";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, wb.getId());
            pStmnt.setString(2, wb.getCountryRegion());
            pStmnt.setString(3, wb.getType());
            pStmnt.setString(4, wb.getCity());
            pStmnt.setString(5, wb.getPhoneNumber());
            int rowCount = pStmnt.executeUpdate();
            if (rowCount >= 1) {
                isSuccess = true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public ArrayList<ConsumptionBean> getTotalConsumption() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ConsumptionBean> cbList = new ArrayList<ConsumptionBean>();
        ConsumptionBean cb = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT f.ID, f.Name, f.ImgName, fc.City, cr.Name AS country, SUM(sfoi.Qty) AS total, f.unit\n" +
                                            "FROM shop_fruit_order_item sfoi\n" +
                                            "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID \n" +
                                            "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                                            "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                                            "JOIN country_region cr ON cr.ID = fc.CountryRegionID\n" +
                                            "WHERE f.Status = 'enable' AND sfo.Status != 'Pending'\n" +
                                            "GROUP BY sfoi.FruitID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = pStmnt.executeQuery();
            while (rs.next()) {
                cb = new ConsumptionBean();
                cb.setFruitId(rs.getString("ID"));
                cb.setFruitName(rs.getString("Name"));
                cb.setFruitImg(rs.getString("ImgName"));
                cb.setFruitCity(rs.getString("City"));
                cb.setFruitCountry(rs.getString("country"));
                cb.setTotal(rs.getString("total"));
                cb.setFruitUnit(rs.getString("unit"));
                cbList.add(cb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return cbList;
    }
    
    public ArrayList<ConsumptionBean> getTotalConsumptionByRegion(String region, String rangeFrom, String rangeTo) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ConsumptionBean> cbList = new ArrayList<ConsumptionBean>();
        ConsumptionBean cb = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT f.ID, f.Name, f.ImgName, fc.City, cr.Name AS country, SUM(sfoi.Qty) AS total, f.unit\n" +
                                            "FROM shop_fruit_order_item sfoi\n" +
                                            "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                                            "JOIN shop s ON sfo.ShopID = s.ID\n" +
                                            "JOIN shop_city sc ON s.City = sc.ID \n" +
                                            "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                                            "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                                            "JOIN country_region cr ON cr.ID = fc.CountryRegionID\n" +
                                            "WHERE f.Status = 'enable' AND sfo.Status != 'Pending' AND sc.CountryRegionID = ? AND sfo.OrderDate BETWEEN  ? AND  ? \n" +
                                            "GROUP BY sfoi.FruitID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, region);
            pStmnt.setString(2, rangeFrom);
            pStmnt.setString(3, rangeTo);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                cb = new ConsumptionBean();
                cb.setFruitId(rs.getString("ID"));
                cb.setFruitName(rs.getString("Name"));
                cb.setFruitImg(rs.getString("ImgName"));
                cb.setFruitCity(rs.getString("City"));
                cb.setFruitCountry(rs.getString("country"));
                cb.setTotal(rs.getString("total"));
                cb.setFruitUnit(rs.getString("unit"));
                cbList.add(cb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return cbList;
    }
    
    public ArrayList<ConsumptionBean> getTotalConsumptionByCity(String city, String rangeFrom, String rangeTo) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ConsumptionBean> cbList = new ArrayList<ConsumptionBean>();
        ConsumptionBean cb = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT f.ID, f.Name, f.ImgName, fc.City, cr.Name AS country, SUM(sfoi.Qty) AS total, f.unit\n" +
                                            "FROM shop_fruit_order_item sfoi\n" +
                                            "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                                            "JOIN shop s ON sfo.ShopID = s.ID\n" +
                                            "JOIN shop_city sc ON s.City = sc.ID \n" +
                                            "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                                            "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                                            "JOIN country_region cr ON cr.ID = fc.CountryRegionID\n" +
                                            "WHERE f.Status = 'enable' AND sfo.Status != 'Pending' AND sc.City = ? AND sfo.OrderDate BETWEEN  ? AND  ? \n" +
                                            "GROUP BY sfoi.FruitID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, city);
            pStmnt.setString(2, rangeFrom);
            pStmnt.setString(3, rangeTo);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                cb = new ConsumptionBean();
                cb.setFruitId(rs.getString("ID"));
                cb.setFruitName(rs.getString("Name"));
                cb.setFruitImg(rs.getString("ImgName"));
                cb.setFruitCity(rs.getString("City"));
                cb.setFruitCountry(rs.getString("country"));
                cb.setTotal(rs.getString("total"));
                cb.setFruitUnit(rs.getString("unit"));
                cbList.add(cb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return cbList;
    }
    
    public ArrayList<ConsumptionBean> getTotalConsumptionByShop(String shopId, String rangeFrom, String rangeTo) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ArrayList<ConsumptionBean> cbList = new ArrayList<ConsumptionBean>();
        ConsumptionBean cb = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT f.ID, f.Name, f.ImgName, fc.City, cr.Name AS country, SUM(sfoi.Qty) AS total, f.unit\n" +
                                            "FROM shop_fruit_order_item sfoi\n" +
                                            "JOIN shop_fruit_order sfo ON sfo.ID = sfoi.OrderID\n" +
                                            "JOIN shop s ON sfo.ShopID = s.ID\n" +
                                            "JOIN shop_city sc ON s.City = sc.ID \n" +
                                            "JOIN fruit f ON sfoi.FruitID = f.ID\n" +
                                            "JOIN fruit_city fc ON fc.ID = f.FruitCityID\n" +
                                            "JOIN country_region cr ON cr.ID = fc.CountryRegionID\n" +
                                            "WHERE f.Status = 'enable' AND sfo.Status != 'Pending' AND s.ID = ? AND sfo.OrderDate BETWEEN  ? AND  ?\n" +
                                            "GROUP BY sfoi.FruitID;";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            pStmnt.setString(2, rangeFrom);
            pStmnt.setString(3, rangeTo);
            pStmnt.executeQuery();
            ResultSet rs = pStmnt.getResultSet();
            while (rs.next()) {
                cb = new ConsumptionBean();
                cb.setFruitId(rs.getString("ID"));
                cb.setFruitName(rs.getString("Name"));
                cb.setFruitImg(rs.getString("ImgName"));
                cb.setFruitCity(rs.getString("City"));
                cb.setFruitCountry(rs.getString("country"));
                cb.setTotal(rs.getString("total"));
                cb.setFruitUnit(rs.getString("unit"));
                cbList.add(cb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return cbList;
    }
    
    public boolean checkShop(String shopId) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ResultSet rs = null;
        boolean isSuccess = false;

        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT COUNT(*) FROM shop WHERE ID =?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, shopId);
            rs = pStmnt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                isSuccess = count >= 1;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        } 
        return isSuccess;
    }
}
