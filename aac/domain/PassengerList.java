/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain;

/**
 *
 * @author Walker
 */
public class PassengerList {

    private int id;
    private int[] passengers; // [adultNumber,childNumber,infantNumber]      
    private Passenger[] passengerInfo; // 傳送passenger相關資料使用

    public PassengerList() {
    }

    public PassengerList(int[] passengers) {
        if ((passengers[0] + passengers[1]) > 4) {
            System.out.println("人數超過訂位上限");
        } else if (passengers[0] < passengers[2]) {
            System.out.println("幼兒需要12歲以上的乘客陪同");
        } else {
            this.passengers = passengers;
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAdultNumber() {
        return passengers[0];
    }

    public void setAdultNumber(int adultNumber) {
        this.passengers[0] = adultNumber;
    }

    public int getChildNumber() {
        return passengers[1];
    }

    public void setChildNumber(int childNumber) {
        this.passengers[1] = childNumber;
    }

    public int getInfantNumber() {
        return passengers[2];
    }

    public void setInfantNumber(int infant) {
        this.passengers[2] = infant;
    }

    public int getPassengerIdR() {
        return passengerInfo[0] != null ? passengerInfo[0].getId() : 0;
    }

    public void setPassengerIdR(int passengerIdR) {
        this.passengerInfo[0].setId(passengerIdR);
    }

    public int getPassengerId1() {
        return passengerInfo[1] != null ? passengerInfo[1].getId() : 0;
    }

    public void setPassengerId1(int passengerId1) {
        this.passengerInfo[1].setId(passengerId1);
    }

    public int getPassengerId2() {
        return passengerInfo[2] != null ? passengerInfo[2].getId() : 0;
    }

    public void setPassengerId2(int passengerId2) {
        this.passengerInfo[2].setId(passengerId2);
    }

    public int getPassengerId3() {
        return passengerInfo[3] != null ? passengerInfo[3].getId() : 0;
    }

    public void setPassengerId3(int passengerId3) {
        this.passengerInfo[3].setId(passengerId3);
    }

    public int[] getPassengers() {
        return passengers;
    }

    public void setPassengers(int[] passengers) {
        this.passengers = passengers;
    }

    public Passenger[] getPassengerInfo() {
        return passengerInfo;
    }

    public void setPassengerInfo(Passenger[] passengerInfo) {
        this.passengerInfo = passengerInfo;
    }

}
