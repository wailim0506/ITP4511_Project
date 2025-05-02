/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.tag;

import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.JspFragment;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.*;
import ict.bean.*;

/**
 *
 * @author HwH
 */
public class order extends SimpleTagSupport{
    private OrderBean orderBean;
    private UserBean userBean;
    private String page;
    private JspWriter out;
    
    public void setOrderBean(OrderBean orderBean) {
        this.orderBean = orderBean;
    }
    
    public OrderBean getOrderBean() { return this.orderBean; }
    
    public void setUserBean(UserBean userBean) {
        this.userBean = userBean;
    }

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }
    
    public UserBean getUserBean() { return this.userBean; }
    
    @Override
    public void doTag() throws JspException {
        out = getJspContext().getOut();

        try {
            out.print(printOrder());
        } catch (java.io.IOException ex) {
            throw new JspException("Error in primeTag tag", ex);
        }
    }
    
    private String printOrder() {
        StringBuilder html = new StringBuilder();
        html.append("<h4 class=\"orderInfo-fruit-title titleTop\">")
            .append("<i class=\"material-icons card-icon\">receipt_long</i>")
            .append("Order Info</h4>")
            .append("<div class=\"orderInfo-orderDetail\">")
            .append("<div class=\"orderInfo-orderDetail-row\">")
            .append("<p><b>Order ID: </b>").append(orderBean.getId()).append("</p>")
            .append("<p><b>Status: </b>").append(orderBean.getStatus()).append("</p>")
            .append("</div>")
            .append("<div class=\"orderInfo-orderDetail-row\">")
            .append("<p><b>Shop ID: </b>").append(orderBean.getShopId()).append("</p>")
            .append("<p><b>City: </b>").append(orderBean.getCity()).append("</p>")
            .append("</div>")
            .append("<p><b>Order Date: </b>").append(orderBean.getOrderDate()).append("</p>")
            .append("<p class=\"order-note\"><b>Notes: </b>").append(orderBean.getNotes()).append("</p>")
            .append("</div><hr>")
            .append("<h4 class=\"orderInfo-fruit-title\">Fruits in this Order:</h4>")
            .append("<table class=\"orderInfo-table\"><thead><tr>")
            .append("<th>Name</th><th>Origin</th><th>Quantity</th><th>Unit</th>")
            .append("</tr></thead><tbody>");

        List<FruitsBean> fruitsList = orderBean.getFruitsBean();
        for (FruitsBean fruit : fruitsList) {
            html.append("<tr>")
                .append("<td>").append(fruit.getName()).append("</td>")
                .append("<td>").append(fruit.getCity()).append("</td>")
                .append("<td>").append(fruit.getQty()).append("</td>")
                .append("<td>").append(fruit.getUnit()).append("</td>")
                .append("</tr>");
        }

        html.append("</tbody></table>");
        
        if ("Pending".equals(orderBean.getStatus()) && page.equals("order")) {
            html.append("<div class=\"orderInfo-btn \"><button class=\"btn btn-warning\" onclick=\"window.location.href='/ITP4511_Project/Order?action=process&orderID=" + orderBean.getId() + "'\">Accept Order</button></div>");
        }else if ("Processing".equals(orderBean.getStatus()) && page.equals("delivery")) {
            html.append("<div class=\"orderInfo-btn \"><button class=\"btn btn-warning\" onclick=\"window.location.href='/ITP4511_Project/Delivery?action=delivered&orderID=" + orderBean.getId() + "'\">Delivered</button></div>");
        }else if ("Delivered".equals(orderBean.getStatus()) && page.equals("restock")) {
            html.append("<div class=\"orderInfo-btn \"><button class=\"btn btn-warning\" onclick=\"window.location.href='/ITP4511_Project/Restock?action=finished&orderID=" + orderBean.getId() + "&wID=" + orderBean.getWarehouseId() + "'\">Finish and Restock</button></div>");
        }
        
        return html.toString();
    }
}
