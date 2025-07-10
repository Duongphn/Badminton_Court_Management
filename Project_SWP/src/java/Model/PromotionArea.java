/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author admin
 */
public class PromotionArea {
      private int id;
      private int araeId;
      private Promotion promotion;

    public PromotionArea() {
    }

    public PromotionArea(int id, int araeId, Promotion promotion) {
        this.id = id;
        this.araeId = araeId;
        this.promotion = promotion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAraeId() {
        return araeId;
    }

    public void setAraeId(int araeId) {
        this.araeId = araeId;
    }

    public Promotion getPromotion() {
        return promotion;
    }

    public void setPromotion(Promotion promotion) {
        this.promotion = promotion;
    }
      
      
}
