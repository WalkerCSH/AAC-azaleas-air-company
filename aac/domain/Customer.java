package aac.domain;

import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.CreditCard;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Customer extends Passenger {

    private int id;
    private int passengerId;
    private String email;
    private String mobile;
    private String cardNumber;
    private Date cardExpiryDate;
    private String cardCCV;
//    private CreditCard creditCard;

    public Customer() {
    }

    public Customer(Passenger p) {
        try {
            System.out.println("Passenger included...");
            this.setPassengerId(p.getId());
            this.setPassengerType(p.getPassengerType());
            this.setFirstName(p.getFirstName());
            this.setLastName(p.getLastName());
            this.setGender(p.getGender());
            this.setBirthday(p.getBirthday());
            this.setResidence(p.getResidence());
            this.setNation(p.getNation());
            this.setPassportNumber(p.getPassportNumber());
            this.setPassportIssuePlace(p.getPassportIssuePlace());
            this.setPassportExpiryDate(p.getPassportExpiryDate());
            System.out.println("Customer created...");
        } catch (AACException ex) {
            Logger.getLogger(Customer.class.getName()).log(Level.SEVERE, "顧客資料帶入時出現錯誤", ex);
        }

    }

    public int getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(int passengerId) {
        this.passengerId = passengerId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) { // 由db自動給號
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) throws AACException {
        if (email == null) {
            System.out.println("電子郵件為必要欄位!");
            throw new AACException("電子郵件為必要欄位!");
        } else if (!(email.matches("^(.+)@(.+)$"))) {
            System.out.println("電子郵件格式不正確!");
            throw new AACException("電子郵件格式不正確!");
        } else {
            this.email = email;
        }
    }

    public static boolean checkEmail(String email) {
        if (email.matches("^(.+)@(.+)$")) {
            return true;
        } else {
            return false;
        }
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) throws AACException {
        if (mobile.isEmpty()) {
            System.out.println("行動電話為必要欄位!");
            throw new AACException("行動電話為必要欄位!");
        } else if (!mobile.matches("[0-9]{8,}")) {
            System.out.println("行動電話格式不正確!");
            throw new AACException("行動電話格式不正確!");
        } else {
            this.mobile = mobile;
        }
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) throws AACException {
        if (cardNumber == null) {
            System.out.println("信用卡號為必要欄位!");
            throw new AACException("信用卡號為必要欄位!");
        } else if (!cardNumber.matches("[0-9]{16}")) {
            System.out.println("信用卡號格式不正確!");
            throw new AACException("信用卡號格式不正確!");
        } else {
            this.cardNumber = cardNumber;
        }
    }

    public Date getCardExpiryDate() {
        return cardExpiryDate;
    }

    public void setCardExpiryDate(Date cardExpiryDate) throws AACException {
        if (cardExpiryDate == null) {
            System.out.println("信用卡到期日為必要欄位!");
            throw new AACException("信用卡到期日為必要欄位!");
        } else if (cardExpiryDate.before(new Date())) { // 需要改成效期相較今日大於180日
            System.out.println("信用卡到期日必須大於今日!");
            throw new AACException("信用卡到期日必須大於今日!");
        } else {
            this.cardExpiryDate = cardExpiryDate;
        }
    }

    public String getCardCCV() {
        return cardCCV;
    }

    public void setCardCCV(String cardCCV) throws AACException {
        if (cardCCV == null || !(cardCCV.matches("[0-9]{3}"))) {
            System.out.println("信用卡檢察碼為必要欄位!");
            throw new AACException("信用卡檢查碼為必要欄位!");
        } else {
            this.cardCCV = cardCCV;
        }
    }

//    public CreditCard getCreditCard() {
//        return creditCard;
//    }
//    public void setCreditCard(CreditCard creditCard) throws AACException {
//        if (creditCard == null) {
//            System.out.println("信用卡別為必要欄位!");
//            throw new AACException("信用卡別為必要欄位!");
//        } else {
//            this.creditCard = creditCard;
//        }
//    }
}
