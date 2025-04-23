/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.bean;

/**
 *
 * @author HwH
 */
public class StatusBean {
    String totalFruits, lowStock, outOfStock;
    
    public void setTotalFruits(String totalFruits) {
        this.totalFruits = totalFruits;
    }
    
    public void setLowStock(String lowStock) {
        this.lowStock = lowStock;
    }
    
    public void setOutOfStock(String outOfStock) {
        this.outOfStock = outOfStock;
    }
    
    public String getTotalFruits() { return this.totalFruits; }
    public String getLowStock() { return this.lowStock; }
    public String getOutOfStock() { return this.outOfStock; }
}
