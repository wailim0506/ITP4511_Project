/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.bean;

/**
 *
 * @author Wai Lim Fung
 */
public class BorrowBean {
    private String id, requestByShopId, requestByShopAddress, requestByShopPhone, requestToShopId, requestToShopAddress,
            requestToShopPhone, requestDate,
            deliveryDate, status, notes, completed;
    private String fruidId, fruitName, city, countryRegion, imgName, type, unit;
    private String rejectReasonSelect, rejectReason;
    private int qty;

    public BorrowBean() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequestByShopId() {
        return requestByShopId;
    }

    public void setRequestByShopId(String requestByShopId) {
        this.requestByShopId = requestByShopId;
    }

    public String getRequestByShopAddress() {
        return requestByShopAddress;
    }

    public void setRequestByShopAddress(String requestByShopAddress) {
        this.requestByShopAddress = requestByShopAddress;
    }

    public String getRequestByShopPhone() {
        return requestByShopPhone;
    }

    public void setRequestByShopPhone(String requestByShopPhone) {
        this.requestByShopPhone = requestByShopPhone;
    }

    public String getRequestToShopId() {
        return requestToShopId;
    }

    public void setRequestToShopId(String requestToShopId) {
        this.requestToShopId = requestToShopId;
    }

    public String getRequestToShopAddress() {
        return requestToShopAddress;
    }

    public void setRequestToShopAddress(String requestToShopAddress) {
        this.requestToShopAddress = requestToShopAddress;
    }

    public String getRequestToShopPhone() {
        return requestToShopPhone;
    }

    public void setRequestToShopPhone(String requestToShopPhone) {
        this.requestToShopPhone = requestToShopPhone;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getCompleted() {
        return completed;
    }

    public void setCompleted(String completed) {
        this.completed = completed;
    }

    public String getFruidId() {
        return fruidId;
    }

    public void setFruidId(String fruidId) {
        this.fruidId = fruidId;
    }

    public String getFruitName() {
        return fruitName;
    }

    public void setFruitName(String fruitName) {
        this.fruitName = fruitName;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountryRegion() {
        return countryRegion;
    }

    public void setCountryRegion(String countryRegion) {
        this.countryRegion = countryRegion;
    }

    public String getImgName() {
        return imgName;
    }

    public void setImgName(String imgName) {
        this.imgName = imgName;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getRejectReasonSelect() {
        return rejectReasonSelect;
    }

    public void setRejectReasonSelect(String rejectReasonSelect) {
        this.rejectReasonSelect = rejectReasonSelect;
    }

    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }
}
