package aac.domain;

import aac.domain.dataCategory.AACException;
import aac.domain.dataCategory.Country;
import aac.domain.dataCategory.PassengerType;
import aac.domain.dataCategory.Gender;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Passenger {

    private int id;
    private PassengerType passengerType;
    private String firstName;
    private String lastName;
    private Gender gender;
    private Date birthday;
    private Country residence;
    private Country nation;
    private String passportNumber;
    private Country passportIssuePlace;
    private Date passportExpiryDate;
    private String birthdayStr;

    //private String orderNumber;
    //private String seat;
    //另外建立訂單類別 由將同訂單編號下的乘客.id帶入
    public Passenger() {
        System.out.println("Passenger created...");
    }    

    public Passenger(PassengerType passengerSet, String firstName, String lastName,
            Gender gender, Date birthday, Country residence, Country nation, String passportNumber,
            Country passportIssuePlace, Date passportExpiryDate) {
        try {
            this.setPassengerType(passengerSet);
            this.setFirstName(firstName.toUpperCase());
            this.setLastName(lastName.toUpperCase());
            this.setGender(gender);
            this.setBirthday(birthday);
            this.setResidence(residence);
            this.setNation(nation);
            this.setPassportNumber(passportNumber);
            this.setPassportIssuePlace(passportIssuePlace);
            this.setPassportExpiryDate(passportExpiryDate);
            System.out.println("Passenger created...");
        } catch (AACException ex) {
            Logger.getLogger(Passenger.class.getName()).log(Level.SEVERE, "乘客資料輸入有誤", ex);
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) { // 由db自動給號
        this.id = id;
    }

    public PassengerType getPassengerType() {
        return passengerType;
    }

    public void setPassengerType(PassengerType passengerType) throws AACException {
        if (passengerType == null) {
            System.out.println("旅客類別為必要欄位!");
            throw new AACException("旅客類別為必要欄位!");
        } else {
            this.passengerType = passengerType;
        }
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) throws AACException {
        if (firstName == null || (firstName = firstName.trim()).length() == 0) {
            System.out.println("旅客名字為必要欄位!");
            throw new AACException("旅客名字為必要欄位!");
        } else {
            this.firstName = firstName.toUpperCase();
        }
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) throws AACException {
        if (lastName == null || (firstName = firstName.trim()).length() == 0) {
            System.out.println("旅客姓氏為必要欄位!");
            throw new AACException("旅客姓氏為必要欄位!");
        } else {
            this.lastName = lastName.toUpperCase();
        }
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) throws AACException {
        if (gender == null) {
            System.out.println("旅客性別為必要欄位!");
            throw new AACException("旅客性別為必要欄位!");
        } else {
            this.gender = gender;
        }
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) throws AACException {
        Date today = new Date();
        if (birthday == null || birthday.after(today)) {
            System.out.println("旅客生日必須小於現在!");
            throw new AACException("旅客生日必須小於現在!");
        } else {
            this.birthday = birthday;
        }
    }

    public void setBirthday(String birthdayStr) throws AACException { //yyyy-MM-dd
        if (birthdayStr != null && (birthdayStr = birthdayStr.trim()).length() > 0) {
            birthdayStr = birthdayStr.replace('/', '-');
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date date = dateFormat.parse(birthdayStr); //checked exception: ParseException            
                //System.out.println("birthday = " + birthday);
                this.setBirthday(date);
            } catch (ParseException ex) {
                System.err.println("客戶生日日期格式不正確: " + birthdayStr + ex);
                throw new AACException("客戶生日日期格式不正確: " + birthdayStr + ex);
            }
        } else {
            birthday = null;
        }
    }

    public void setBirthday(int year, int month, int day) throws AACException {
        Date date = new GregorianCalendar(year, month - 1, day).getTime();
        this.setBirthday(date);
    }

    public String getBirthdayStr() {
        return birthdayStr;
    }

    public void setBirthdayStr(String birthdayStr) {
        this.birthdayStr = birthdayStr;
    }    

    public Country getResidence() {
        return residence;
    }

    public void setResidence(Country residence) throws AACException {
        if (residence == null) {
            System.out.println("居住地為必要欄位!");
            throw new AACException("居住地為必要欄位!");
        } else {
            this.residence = residence;
        }
    }

    public Country getNation() {
        return nation;
    }

    public void setNation(Country nation) throws AACException {
        this.nation = nation;
    }

    public String getPassportNumber() {
        return passportNumber;
    }

    public void setPassportNumber(String passportNumber) throws AACException {
        if (passportNumber == null || (passportNumber = passportNumber.trim()).length() == 0) {
            System.out.println("護照號碼為必要欄位!");
            throw new AACException("護照號碼為必要欄位!");
        } else {
            this.passportNumber = passportNumber;
        }
    }

    public Country getPassportIssuePlace() {
        return passportIssuePlace;
    }

    public void setPassportIssuePlace(Country passportIssuePlace) throws AACException {
        this.passportIssuePlace = passportIssuePlace;
    }

    public Date getPassportExpiryDate() {
        return passportExpiryDate;
    }

    public void setPassportExpiryDate(Date passportExpiryDate) throws AACException {
        Date today = new Date();
        if (passportExpiryDate == null) {
            System.out.println("護照到期日為必要欄位!");
            throw new AACException("護照到期日為必要欄位!");
        } else if (passportExpiryDate.before(today)) {
            System.out.println("護照到期日必須大於今日!");
            throw new AACException("護照到期日必須大於今日!");
        } else {
            this.passportExpiryDate = passportExpiryDate;
        }
    }

    public void setPassportExpiryDate(String passportExpiryDateStr) throws AACException { //yyyy-MM-dd
        if (passportExpiryDateStr != null && (passportExpiryDateStr = passportExpiryDateStr.trim()).length() > 0) {
            passportExpiryDateStr = passportExpiryDateStr.replace('/', '-');
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date date = dateFormat.parse(passportExpiryDateStr); //checked exception: ParseException            
                //System.out.println("date = " + date);
                this.setPassportExpiryDate(date);
            } catch (ParseException ex) {
                System.err.println("護照日期格式不正確: " + passportExpiryDateStr + ex);
                throw new AACException("護照日期格式不正確: " + passportExpiryDateStr + ex);
            }
        } else {
            birthday = null;
        }
    }

    public void setPassportExpiryDate(int year, int month, int day) throws AACException {
        Date date = new GregorianCalendar(year, month - 1, day).getTime();
        this.setPassportExpiryDate(date);
    }

    @Override
    public String toString() {
        return super.toString() + "Passenger{" + "id=" + id + ", passengerSet=" + passengerType
                + ", firstName=" + firstName + ", lastName=" + lastName
                + ", gender=" + gender + ", birthday=" + birthday
                + ", residence=" + residence + ", nation=" + nation
                + ", passportNumber=" + passportNumber + ", passportIssuePlace=" + passportIssuePlace
                + ", passportExpiryDate=" + passportExpiryDate + '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        final Passenger other = (Passenger) obj;
        if (Objects.equals(this.firstName, other.firstName)
                && Objects.equals(this.lastName, other.lastName)
                && Objects.equals(this.gender, other.gender)
                && Objects.equals(this.birthday, other.birthday)) {
            return true;
        }
        return false; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int hashCode() {
        return super.hashCode(); //To change body of generated methods, choose Tools | Templates.
    }

    public String getCode() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
