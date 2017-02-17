package aac.domain;

import aac.domain.dataCategory.FlightRoute;
import java.text.SimpleDateFormat;
import java.util.Date;

public final class PriceSheet {

    private String code;
    private Date effectiveDate;
    private Date expiryDate;
    private FlightRoute flightNumber;
    private int gloryPrice;
    private int fancyPrice;
    private int happyPrice;

    public PriceSheet() {
    }

    public PriceSheet(Date effectiveDate, Date expiryDate, FlightRoute flightNumber, int gloryPrice, int fancyPrice, int happyPrice) {
        this.setEffectiveDate(effectiveDate);
        this.setExpiryDate(expiryDate);
        this.setFlightNumber(flightNumber);
        this.setCode();
        this.setGloryPrice(gloryPrice);
        this.setFancyPrice(fancyPrice);
        this.setHappyPrice(happyPrice);
    }

    public String getCode() {
        return code;
    }

    public void setCode() {
        // 由航班日期和航班編號組成
        SimpleDateFormat sdfDateOnly = new SimpleDateFormat("yyyy/MM/dd");
        String effectiveDateStr = sdfDateOnly.format(effectiveDate).replace("/", "");
        String expiryDateStr = sdfDateOnly.format(expiryDate).replace("/", "");

        if (this.effectiveDate != null && this.expiryDate != null && this.flightNumber != null) {
            this.code = effectiveDateStr + expiryDateStr + this.flightNumber.name();
        } else {
            System.out.println("Code輸入失敗");
        }
    }

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        if (effectiveDate != null) {
            this.effectiveDate = effectiveDate;
        } else {
            System.out.println("EffectiveDate輸入失敗");
        }
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        if (expiryDate != null) {
            this.expiryDate = expiryDate;
        } else {
            System.out.println("ExpiryDate輸入失敗");
        }
    }

    public FlightRoute getFlightNumber() {
        return flightNumber;
    }

    public void setFlightNumber(FlightRoute flightNumber) {
        if (flightNumber != null) {
            this.flightNumber = flightNumber;
        } else {
            System.out.println("FlightNumber輸入失敗");
        }
    }

    public int getGloryPrice() {
        return gloryPrice;
    }

    public void setGloryPrice(int gloryPrice) {
        if (gloryPrice > 0) {
            this.gloryPrice = gloryPrice;
        } else {
            System.out.println("GloryPrice非正常數值");
        }
    }

    public int getFancyPrice() {
        return fancyPrice;
    }

    public void setFancyPrice(int fancyPrice) {
        if (fancyPrice > 0) {
            this.fancyPrice = fancyPrice;
        } else {
            System.out.println("FancyPrice非正常數值");
        }
    }

    public int getHappyPrice() {
        return happyPrice;
    }

    public void setHappyPrice(int happyPrice) {
        if (happyPrice > 0) {
            this.happyPrice = happyPrice;
        } else {
            System.out.println("HappyPrice非正常數值");
        }
    }

}
