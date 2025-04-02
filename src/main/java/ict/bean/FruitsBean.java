/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ict.bean;

import java.io.Serializable;

/**
 *
 * @author HwH
 */
public class FruitsBean implements Serializable {
    private String name, countryRegion, imgName, id;

    public FruitsBean() {
    }
    
    public void setId(String id){
        this.id = id;
    }
    
    public String getId(){
        return this.id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setCountryRegion(String countryRegion) {
        this.countryRegion = countryRegion;
    }

    public String getCountryRegion() {
        return countryRegion;
    }

    public void setImgName(String ImgName) {
        this.imgName = ImgName;
    }

    public String getImgName() {
        return imgName;
    }
}
