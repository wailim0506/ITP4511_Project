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
    String pending, processing, delivered, finished, total;
    
    public void setTotalFruits(String totalFruits) {
        this.totalFruits = totalFruits;
    }
    
    public void setLowStock(String lowStock) {
        this.lowStock = lowStock;
    }
    
    public void setOutOfStock(String outOfStock) {
        this.outOfStock = outOfStock;
    }
    
    public void setPending(String pending) {
        this.pending = pending;
    }
    
    public void setProcessing(String processing) {
        this.processing = processing;
    }
    
    public void setDelivered(String delivered) {
        this.delivered = delivered;
    }
    
    public void setFinished(String finished) {
        this.finished = finished;
    }
    
    public void setTotal(String total) {
        this.total = total;
    }
    
    public String getTotalFruits() { return this.totalFruits; }
    public String getLowStock() { return this.lowStock; }
    public String getOutOfStock() { return this.outOfStock; }
    public String getPending() { return this.pending; }
    public String getProcessing() { return this.processing; }
    public String getDelivered() { return this.delivered; }
    public String getFinished() { return this.finished; }
    public String getTotal() { return this.total; }
}
