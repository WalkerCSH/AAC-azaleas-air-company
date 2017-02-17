/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain;

import aac.domain.dataCategory.Aircraft;
import aac.domain.dataCategory.FlightRoute;
import aac.domain.flight.PresentAvailable;
import aac.domain.flight.PresentSold;
import aac.domain.flight.SeatDistribute;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Walker
 */
public final class Flight {

    private String id;
    private Status status;

    private Date takeOffDate;
    private FlightRoute flightRoute;
    private Aircraft type;
    private PresentSold presentSold; // Total,gloryCapacity,fancyCapacity,happyCapacity
    private PresentAvailable presentAvailable; // Total,gloryCapacity,fancyCapacity,happyCapacity    
    private SeatDistribute seatDistribute; // columnA~K  total: 10column    

    public Flight() {

    }

    public Flight(Date takeOffDate, FlightRoute flightRoute) {
        this.setTakeOffDate(takeOffDate);
        this.setFlightRoute(flightRoute);
        this.setId();
    }

    public Flight(Date takeOffDate, FlightRoute flightRoute, Aircraft type) {
        this.setTakeOffDate(takeOffDate);
        this.setFlightRoute(flightRoute);
        this.setId();
        this.setType(type);
        this.setPresentSold(new PresentSold(0, 0, 0));
        this.setPresentAvailable(new PresentAvailable(type, this.presentSold));
        this.setSeatDistribute(new SeatDistribute(type));
        this.setStatus(Status.values()[0]);
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public enum Status {
        ARRANGED("已派遣"), CANCELED("已取消"), ONTIME("準時起飛"), DELAY("延遲起飛"), COMPLETED("任務完成");

        private final String description;

        private Status(String desc) {
            this.description = desc;
        }
    }

    public String getId() {
        return id;
    }

    public final void setId() {
        // 由航班日期和航班編號組成
        SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy/MM/dd");
        String takeOffDateStr = sdfDateOnly.format(takeOffDate).replace("/", "");
        if (this.takeOffDate != null && this.flightRoute != null) {
            this.id = takeOffDateStr + this.flightRoute.name();
        } else {
            System.out.println("Id輸入失敗.");
        }
    }

    public FlightRoute getFlightRoute() {
        return flightRoute;
    }

    public void setFlightRoute(FlightRoute flightRoute) {
        if (flightRoute != null) {
            this.flightRoute = flightRoute;
        } else {
            System.out.println("FlightNumber輸入失敗");
        }
    }

    public Date getTakeOffDate() {
        return takeOffDate;
    }

    public void setTakeOffDate(Date takeOffDate) {
        if (takeOffDate != null) {
            this.takeOffDate = takeOffDate;
        } else {
            System.out.println("TakeOffDate輸入失敗");
        }
    }

    public Aircraft getType() {
        return type;
    }

    public void setType(Aircraft type) {
        if (type != null) {
            this.type = type;
        } else {
            System.out.println("Type輸入失敗");
        }
    }

    public PresentSold getPresentSold() {
        return presentSold;
    }

    public void setPresentSold(PresentSold presentSold) {
        if (presentSold != null) {
            this.presentSold = presentSold;
        } else {
            System.out.println("PresentSold輸入失敗");
        }
    }

    public PresentAvailable getPresentAvailable() {
        return presentAvailable;
    }

    public void setPresentAvailable(PresentAvailable presentAvailable) {
        if (presentAvailable != null) {
            this.presentAvailable = presentAvailable;
        } else {
            System.out.println("PresentEmpty輸入失敗");
        }
    }

    // columnA~K  total: 10column
    public SeatDistribute getSeatDistribute() {
        return seatDistribute;
    }

    public void setSeatDistribute(SeatDistribute seatDistribute) {
        if (seatDistribute != null) {
            this.seatDistribute = seatDistribute;
        } else {
            System.out.println("SeatDistribute輸入失敗");
        }
    }

    @Override
    public String toString() {
        return "Flight{" + "id=" + id + ", status=" + status + ", takeOffDate=" + takeOffDate + ", flightRoute=" + flightRoute + ", type=" + type + ", presentSold=" + presentSold + ", presentAvailable=" + presentAvailable + ", seatDistribute=" + seatDistribute + '}';
    }

}
