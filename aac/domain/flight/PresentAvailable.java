/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain.flight;

import aac.domain.Flight;
import aac.domain.dataCategory.Aircraft;

/**
 *
 * @author Walker
 */
public class PresentAvailable {

    private int totalAmount;
    private int gloryClassAmount;
    private int fancyClassAmount;
    private int happyClassAmount;
    
    public PresentAvailable(){
        
    }

    public PresentAvailable(Aircraft aircraft,PresentSold presentSold) {
        if (aircraft == null) {
            System.out.println("PresentEmpty建立失敗..");
        } else {
            this.totalAmount = aircraft.getCarryCapacity() - presentSold.getTotalAmount();
            this.gloryClassAmount = aircraft.getGloryCapacity() - presentSold.getGloryClassAmount();
            this.fancyClassAmount = aircraft.getFancyCapacity() - presentSold.getFancyClassAmount();
            this.happyClassAmount = aircraft.getHappyCapacity() - presentSold.getHappyClassAmount();
        }
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Flight fs) {
        if (fs != null) {
            this.totalAmount = fs.getType().getCarryCapacity() - fs.getPresentSold().getTotalAmount();
        } else {
            System.out.println("TotalAmount輸入失敗");
        }
    }

    public int getGloryClassAmount() {
        return gloryClassAmount;
    }

    public void setGloryClassAmount(Flight fs) {
        if (fs != null) {
            this.gloryClassAmount = fs.getType().getGloryCapacity() - fs.getPresentSold().getGloryClassAmount();
        } else {
            System.out.println("GloryClassAmount輸入失敗");
        }
    }

    public int getFancyClassAmount() {
        return fancyClassAmount;
    }

    public void setFancyClassAmount(Flight fs) {
        if (fs != null) {
            this.fancyClassAmount = fs.getType().getFancyCapacity() - fs.getPresentSold().getFancyClassAmount();
        } else {
            System.out.println("FancyClassAmount輸入失敗");
        }
    }

    public int getHappyClassAmount() {
        return happyClassAmount;
    }

    public void setHappyClassAmount(Flight fs) {
        if (fs != null) {
            this.happyClassAmount = fs.getType().getHappyCapacity() - fs.getPresentSold().getHappyClassAmount();
        } else {
            System.out.println("HappyClassAmount輸入失敗");
        }
    }

    @Override
    public String toString() {
        return "PresentSold{" + "total=" + totalAmount + ", gloryClass=" + gloryClassAmount + ", fancyClass=" + fancyClassAmount + ", happyClass=" + happyClassAmount + '}';
    }

}
