/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author sang
 */
public class AreaCoach {
    private int areaId;
    private String name;
    private String location;

    public AreaCoach() {
    }

    public AreaCoach(int areaId, String name, String location) {
        this.areaId = areaId;
        this.name = name;
        this.location = location;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Override
    public String toString() {
        return "AreaCoach{" + "areaId=" + areaId + ", name=" + name + ", location=" + location + '}';
    }

    
    
}
