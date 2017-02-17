/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain.flight;

/**
 *
 * @author Walker
 */
public class PresentSold {

    private int totalAmount;
    private int gloryClassAmount;
    private int fancyClassAmount;
    private int happyClassAmount;

    public PresentSold() {

    }

    public PresentSold(int gloryClassAmount, int fancyClassAmount, int happyClassAmount) {
        this.gloryClassAmount = gloryClassAmount;
        this.fancyClassAmount = fancyClassAmount;
        this.happyClassAmount = happyClassAmount;
        this.totalAmount = this.gloryClassAmount + this.fancyClassAmount + this.happyClassAmount;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = this.gloryClassAmount + this.fancyClassAmount + this.happyClassAmount;
    }

    public int getGloryClassAmount() {
        return gloryClassAmount;
    }

    public void setGloryClassAmount(int gloryClassAmount) {
        this.gloryClassAmount = gloryClassAmount;
    }

    public int getFancyClassAmount() {
        return fancyClassAmount;
    }

    public void setFancyClassAmount(int fancyClassAmount) {
        this.fancyClassAmount = fancyClassAmount;
    }

    public int getHappyClassAmount() {
        return happyClassAmount;
    }

    public void setHappyClassAmount(int happyClassAmount) {
        this.happyClassAmount = happyClassAmount;
    }

    @Override
    public String toString() {
        return "PresentSold{" + "total=" + totalAmount + ", gloryClass=" + gloryClassAmount + ", fancyClass=" + fancyClassAmount + ", happyClass=" + happyClassAmount + '}';
    }

}
