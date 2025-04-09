/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.db;

import java.io.*;
import java.sql.*;
import ict.bean.*;
import jakarta.persistence.criteria.Order;

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

    // for shop_fruit_order

    // for shop_fruit_order_item
    public boolean insertOrderItem(String orderId, String fruitId, int qty) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO shop_fruit_order_item (OrderID,FruitID,Qty) VALUES(?,?,?)";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, orderId);
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
    // for shop_fruit_order_item
}
