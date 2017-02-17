package aac.domain;

import aac.domain.dataCategory.TripType;
import aac.domain.dataCategory.CabinClass;
//import aac.domain.dataCategory.CreditCard;
import aac.domain.dataCategory.FlightRoute;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class TicketOrder {

    private int id; // 訂單確立存入資料庫時 由資料庫自動給號 內部編號查詢使用
    private String orderNumber; // 訂單確立時 亂數產生再存進資料庫 六碼英數字 給客人查詢訂單使用

    private TripType tripType;
    private FlightRoute departFlightRoute;
    private Date departDate;
    private FlightRoute returnFlightRoute;
    private Date returnDate;

    private CabinClass[] cabinClass; // [depart,return]

    private int passengerListId; // 由PassengerList.id進行對應 抓出passengers.id以及passengerTypes // 由資料庫自動給號後再輾轉存入
    private int seatsSelectedSetId; // SeatsSelectedSet.id進行對應 抓出選位資訊 // 由資料庫自動給號後再輾轉存入

    private int customerId;  // 由Customer.id 進行對應
//    private CreditCard creditCard;
//    private int creditCardNumber;
//    private Date cardExpiryDate;
//    private int ccvNumber;

    private String coupon;
    private int grossPrice;
    private int netPrice;

    private Status status;
    private Date orderTime;

    public enum Status {
        ACCEPTED("已成立"), CANCELED("已取消");

        private final String description;

        private Status(String desc) {
            this.description = desc;
        }
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime() {
        this.orderTime = new Date();
    }

    public void setOrderTime(Date time) {
        this.orderTime = time;
    }

//    public Date getCardExpiryDate() {
//        return cardExpiryDate;
//    }
//    public void setCardExpiryDate(Date cardExpiryDate) {
//        this.cardExpiryDate = cardExpiryDate;
//    }
    public int getSeatsSelectedSetId() {
        return seatsSelectedSetId;
    }

    public void setSeatsSelectedSetId(int seatsSelectedSetId) {
        this.seatsSelectedSetId = seatsSelectedSetId;
    }

    public int getPassengerListId() {
        return passengerListId;
    }

    public void setPassengerListId(int passengerListId) {
        this.passengerListId = passengerListId;
    }

    public TripType getTripType() {
        return tripType;
    }

    public void setTripType(TripType tripType) {
        this.tripType = tripType;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public static boolean checkOrderNumber(String orderNumber) {
        if (orderNumber.matches("[0-9A-Za-z]{6}")) {
            return true;
        } else {
            return false;
        }
    }

    public static String generateOrderNumber() {
        StringBuilder orderNumber = new StringBuilder();
        String rand = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        for (int i = 0; i < 6; i++) {
            char chars = rand.charAt((int) (Math.random() * 62));
            System.out.println("chars = " + chars);
            orderNumber.append(chars);
        }
        return orderNumber.toString();
    }

    public TripType getFlightType() {
        return tripType;
    }

    public void setFlightType(TripType tripType) {
        this.tripType = tripType;
    }

    public FlightRoute getDepartFlightRoute() {
        return departFlightRoute;
    }

    public void setDepartFlightRoute(FlightRoute departFlightRoute) {
        this.departFlightRoute = departFlightRoute;
    }

    public FlightRoute getReturnFlightRoute() {
        return returnFlightRoute;
    }

    public void setReturnFlightRoute(FlightRoute returnFlightRoute) {
        this.returnFlightRoute = returnFlightRoute;
    }

    public Date getDepartDate() {
        return departDate;
    }

    public void setDepartDate(Date departDate) {
        this.departDate = departDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public CabinClass[] getCabinClass() {
        return cabinClass;
    }

    public void setCabinClass(CabinClass[] cabinClass) {
        this.cabinClass = cabinClass;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

//    public CreditCard getCreditCard() {
//        return creditCard;
//    }
//    public void setCreditCard(CreditCard creditCard) {
//        this.creditCard = creditCard;
//    }
//    public int getCreditCardNumber() {
//        return creditCardNumber;
//    }
//    public void setCreditCardNumber(int creditCardNumber) {
//        this.creditCardNumber = creditCardNumber;
//    }
//    public int getCcvNumber() {
//        return ccvNumber;
//    }
//    public void setCcvNumber(int ccvNumber) {
//        this.ccvNumber = ccvNumber;
//    }
    public String getCoupon() {
        return coupon;
    }

    public void setCoupon(String coupon) {
        this.coupon = coupon;
    }

    public int getGrossPrice() {
        return grossPrice;
    }

    public void setGrossPrice(int grossPrice) {
        this.grossPrice = grossPrice;
    }

    public int getNetPrice() {
        return netPrice;
    }

    public void setNetPrice() {
        if (coupon == null) {
            this.netPrice = this.grossPrice;
        } else if (!coupon.isEmpty()) {
            this.netPrice = this.grossPrice * 5 / 10;
        }
    }

    @Override
    public String toString() {
        return "TicketOrder{" + "id=" + id + ", orderNumber=" + orderNumber + ", tripType=" + tripType + ", departFlightRoute=" + departFlightRoute + ", departDate=" + departDate + ", returnFlightRoute=" + returnFlightRoute + ", returnDate=" + returnDate + ", cabinClass=" + cabinClass + ", passengerListId=" + passengerListId + ", seatsSelectedSetId=" + seatsSelectedSetId + ", customerId=" + customerId + ", coupon=" + coupon + ", grossPrice=" + grossPrice + ", netPrice=" + netPrice + ", status=" + status + ", orderTime=" + orderTime + '}';
    }

}
