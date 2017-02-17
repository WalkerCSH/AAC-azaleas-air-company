/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain;

/**
 *
 * @author Administrator
 */
public class SeatsSelectedSet {

    private int id; // 訂單成立時 從資料庫帶回自動給號的id資料
    private String departSeatR;
    private String departSeat1;
    private String departSeat2;
    private String departSeat3;
    private String returnSeatR;
    private String returnSeat1;
    private String returnSeat2;
    private String returnSeat3;

    public SeatsSelectedSet() {
    }

    public SeatsSelectedSet(String departSeatR, String departSeat1, String departSeat2, String departSeat3, String returnSeatR, String returnSeat1, String returnSeat2, String returnSeat3) {
        this.departSeatR = departSeatR;
        this.departSeat1 = departSeat1;
        this.departSeat2 = departSeat2;
        this.departSeat3 = departSeat3;
        this.returnSeatR = returnSeatR;
        this.returnSeat1 = returnSeat1;
        this.returnSeat2 = returnSeat2;
        this.returnSeat3 = returnSeat3;
    }
    // "NSI" : No Seat Info

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDepartSeatR() {
        return departSeatR == null ? "NSI" : departSeatR;
    }

    public void setDepartSeatR(String departSeatR) {
        this.departSeatR = departSeatR;
    }

    public String getDepartSeat1() {
        return departSeat1 == null ? "NSI" : departSeat1;
    }

    public void setDepartSeat1(String departSeat1) {
        this.departSeat1 = departSeat1;
    }

    public String getDepartSeat2() {
        return departSeat2 == null ? "NSI" : departSeat2;
    }

    public void setDepartSeat2(String departSeat2) {
        this.departSeat2 = departSeat2;
    }

    public String getDepartSeat3() {
        return departSeat3 == null ? "NSI" : departSeat3;
    }

    public void setDepartSeat3(String departSeat3) {
        this.departSeat3 = departSeat3;
    }

    public String getReturnSeatR() {
        return returnSeatR == null ? "NSI" : returnSeatR;
    }

    public void setReturnSeatR(String returnSeatR) {
        this.returnSeatR = returnSeatR;
    }

    public String getReturnSeat1() {
        return returnSeat1 == null ? "NSI" : returnSeat1;
    }

    public void setReturnSeat1(String returnSeat1) {
        this.returnSeat1 = returnSeat1;
    }

    public String getReturnSeat2() {
        return returnSeat2 == null ? "NSI" : returnSeat2;
    }

    public void setReturnSeat2(String returnSeat2) {
        this.returnSeat2 = returnSeat2;
    }

    public String getReturnSeat3() {
        return returnSeat3 == null ? "NSI" : returnSeat3;
    }

    public void setReturnSeat3(String returnSeat3) {
        this.returnSeat3 = returnSeat3;
    }

}
