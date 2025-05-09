/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.tag;

import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.JspFragment;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import ict.bean.*;
import java.io.IOException;

/**
 *
 * @author HwH
 */
public class profile extends SimpleTagSupport {
    private UserBean userBean;
    private JspWriter out;
    private String type, loc;

    public void setUserBean(UserBean userBean) {
        this.userBean = userBean;
    }

    public UserBean getUserBean() {
        return this.userBean;
    }

    @Override
    public void doTag() throws JspException {
        out = getJspContext().getOut();

        try {
            if (userBean.getShopId() != null) { // Shop
                shop();
            } else if (userBean.getWareHouseId() != null) { // Warehouse
                type = userBean.getWarehouseType();
                loc = (userBean.getWarehouseType().equals("Central")
                        ? "Country:</b> " + userBean.getWarehouseCountry()
                        : "City:</b> " + userBean.getWarehouseSourceCityFullName() + ", "
                                + userBean.getWarehouseCountry());
                warehouse();
            } else { // senior manager
                seniorManagement();

            }

            JspFragment f = getJspBody();
            if (f != null) {
                f.invoke(out);
            }
        } catch (java.io.IOException ex) {
            throw new JspException("Error in primeTag tag", ex);
        }
    }

    private void warehouse() throws IOException {
        out.println("<p><b>Account Type:</b> Warehouse (" + type + ")</p>\n" +
                "                        <p><b>Warehouse ID:</b> " + userBean.getWareHouseId() + "</p>\n" +
                "                        <p><b>Staff Name (Type):</b> " + userBean.getUserName() + " (" + userBean.getRole() + ")" + "</p>\n" +
                "                        <p><b>Warehouse Phone:</b> " + userBean.getPhone() + "</p>\n" +
                "                        <p><b>" + loc + "</p>");
    }

    private void shop() throws IOException {
        out.println("<p><b>Account Type:</b> Shop</p>\n" +
                "                        <p><b>Shop ID:</b> " + userBean.getShopId() + "</p>\n" +
                "                        <p><b>Staff Name:</b> " + userBean.getUserName() + "</p>\n" +
                "                        <p><b>Shop Phone:</b> " + userBean.getPhone() + "</p>\n" +
                "                        <p><b>Address:</b> " + userBean.getShopAddress() + "</p>\n" +
                "                        <p><b>City:</b> " + userBean.getShopCity() + ", " + userBean.getShopCountry()
                + "</p>");
    }

    private void seniorManagement() throws IOException {
        out.println("<p><b>Account Type:</b> Senior Management</p>\n" +
                "                        <p><b>Staff Name:</b> " + userBean.getStaffName() + "</p>\n" +
                "                        <p><b>Role:</b> Senior Management</p>");
    }
}
