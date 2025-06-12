/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class Branch_Equipments {
   private int areaEquipment_id;
   private int equipment_id;
   private int area_id;
   private Equipments equipment;

   

    public Branch_Equipments() {
    }

    public Branch_Equipments(int areaEquipment_id, int equipment_id, int area_id) {
        this.areaEquipment_id = areaEquipment_id;
        this.equipment_id = equipment_id;
        this.area_id = area_id;
    }

    public int getAreaEquipment_id() {
        return areaEquipment_id;
    }

    public void setAreaEquipment_id(int areaEquipment_id) {
        this.areaEquipment_id = areaEquipment_id;
    }

    public int getEquipment_id() {
        return equipment_id;
    }

    public void setEquipment_id(int equipment_id) {
        this.equipment_id = equipment_id;
    }

    public int getArea_id() {
        return area_id;
    }

    public void setArea_id(int area_id) {
        this.area_id = area_id;
    }

    public Equipments getEquipment() {
        return equipment;
    }

    public void setEquipment(Equipments equipment) {
        this.equipment = equipment;
    }
   
}
