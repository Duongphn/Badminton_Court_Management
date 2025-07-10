/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Branch_Service {
   private int AreaService_id;
   private int service_id;
   private int area_id;
   private Service service;

   

    public Branch_Service() {
    }

    public Branch_Service(int AreaServices_id, int service_id, int area_id) {
        this.AreaService_id = AreaService_id;
        this.service_id = service_id;
        this.area_id = area_id;
    }

    public int getAreaService_id() {
        return AreaService_id;
    }

    public void setAreaService_id(int AreaService_id) {
        this.AreaService_id = AreaService_id;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public int getArea_id() {
        return area_id;
    }

    public void setArea_id(int area_id) {
        this.area_id = area_id;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    @Override
    public String toString() {
        return "Branch_Service{" + "AreaService_id=" + AreaService_id + ", service_id=" + service_id + ", area_id=" + area_id + ", service=" + service + '}';
    }
    
}

    