/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.bean;

/**
 *
 * @author HwH
 */
public class UserBean {
    private String userID, staffName, userName, password, accountType, shopId, warehouseId;

    public UserBean() {
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String StaffName) {
        this.staffName = StaffName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String UserName) {
        this.userName = UserName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String Password) {
        this.password = Password;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String AccountType) {
        this.accountType = AccountType;
    }

    public String getShopId() {
        return shopId;
    }

    public void setShopId(String shop) {
        this.shopId = shop;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getWarehouseId() {
        return this.warehouseId;
    }
}
