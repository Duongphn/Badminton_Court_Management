/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class Service_Branch {
    private int serviceID;
    private int serviceBranchID;
    private int area_id;

    public Service_Branch() {
    }

    public Service_Branch(int serviceID, int serviceBranchID, int area_id) {
        this.serviceID = serviceID;
        this.serviceBranchID = serviceBranchID;
        this.area_id = area_id;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public int getServiceBranchID() {
        return serviceBranchID;
    }

    public void setServiceBranchID(int serviceBranchID) {
        this.serviceBranchID = serviceBranchID;
    }

    public int getArea_id() {
        return area_id;
    }

    public void setArea_id(int area_id) {
        this.area_id = area_id;
    }
 
    
}
