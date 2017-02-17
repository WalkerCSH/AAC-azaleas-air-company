/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain.flight;

import aac.domain.dataCategory.Aircraft;
import aac.domain.dataCategory.CabinClass;

/**
 *
 * @author Walker
 */
public class SeatDistribute {

    private String columnA;
    private String columnB;
    private String columnC;
    private String columnD;
    private String columnE;
    private String columnF;
    private String columnG;
    private String columnH;
    private String columnJ;
    private String columnK;
    private static String[] colName = {"A", "B", "C", "D", "E",
        "F", "G", "H", "J", "K"};

    public SeatDistribute() {

    }

    public SeatDistribute(Aircraft aircraft) {
        String binStr = "0000000000000000000000000000000"; // 0*31
//        String bin29Str = "00000000000000000000000000000";
//        String bin25Str = "0000000000000000000000000";
//        String bin24Str = "000000000000000000000000";

        switch (aircraft.name()) {
            case "A330":
                // columnA,columnE,columnF,columnK = 31 個座位 >> 0b1111111111111111111111111111111
                // columnB,columnJ = 29 個座位 >> 0b11111111111111111111111111111
                // columnC,columnD,columnG,columnH = 24 個座位 >> 0b111111111111111111111111
                this.columnA = binStr;
                this.columnB = binStr;
                this.columnC = binStr;
                this.columnD = binStr;
                this.columnE = binStr;
                this.columnF = binStr;
                this.columnG = binStr;
                this.columnH = binStr;
                this.columnJ = binStr;
                this.columnK = binStr;
                break;
            case "B777":
                // columnA,columnE,columnF,columnK = 31 個座位 >> 1111111111111111111111111111111
                // columnB,columnJ = 29 個座位 >> 11111111111111111111111111111
                // columnC,columnD,columnG,columnH = 25 個座位 >> 1111111111111111111111111
                this.columnA = binStr;
                this.columnB = binStr;
                this.columnC = binStr;
                this.columnD = binStr;
                this.columnE = binStr;
                this.columnF = binStr;
                this.columnG = binStr;
                this.columnH = binStr;
                this.columnJ = binStr;
                this.columnK = binStr;
                break;
        }

    }

    public static boolean getSeatStatusIsAvailable(SeatDistribute sd, String colName, int colIndex) {
        String colBinStr = sd.getColBinStr(colName);
        char status = colBinStr.charAt(colIndex - 1);
        if (status == '0') {
            return true;
        } else {
            return false;
        }
    }

    public static String[] getColName() {
        return colName;
    }

    public static int getColInt(String column) {
        int colInt = Integer.parseInt(column, 2);
        return colInt;
    }

    public static int countPassengers(Aircraft type, CabinClass name, SeatDistribute sd) {
        int passengers = 0;
        int glorySeatsInCol = 0;
        int fancySeatsInCol = 0;
        int happySeatsInCol = 0;
        switch (type.name()) {
            case "A330":
                glorySeatsInCol = 2;
                fancySeatsInCol = 5;
                happySeatsInCol = 24;
                break;
            case "B777":
                glorySeatsInCol = 2;
                fancySeatsInCol = 4;
                happySeatsInCol = 25;
                break;
        }
        switch (name.name()) {
            case "GLORY":
                for (int i = 0; i < SeatDistribute.getColName().length; i++) {
                    if (i == 0 || i == 4 || i == 5 || i == 9) {
                        String colBinStr = sd.getColBinStr(SeatDistribute.getColName()[i]);
                        for (int j = 0; j < glorySeatsInCol; j++) {
                            if (colBinStr.charAt(j) == '1') {
                                passengers += 1;
                            }
                        }
                    }
                }
                break;
            case "FANCY":
                for (int i = 0; i < SeatDistribute.getColName().length; i++) {
                    if (!(i == 2 && i == 3 && i == 6 && i == 7)) {
                        String colBinStr = sd.getColBinStr(SeatDistribute.getColName()[i]);
                        for (int j = glorySeatsInCol; j < (glorySeatsInCol + fancySeatsInCol); j++) {
                            if (colBinStr.charAt(j) == '1') {
                                passengers += 1;
                            }
                        }
                    }
                }
                break;
            case "HAPPY":
                for (int i = 0; i < SeatDistribute.getColName().length; i++) {
                    String colBinStr = sd.getColBinStr(SeatDistribute.getColName()[i]);
                    for (int j = (glorySeatsInCol + fancySeatsInCol); j < (glorySeatsInCol + fancySeatsInCol + happySeatsInCol); j++) {
                        if (colBinStr.charAt(j) == '1') {
                            passengers += 1;
                        }
                    }
                }
                break;
        }
        return passengers;
    }

    public void selectSeat(String seatCode) {
        String colNameSelected = (String) seatCode.substring(0, 1);
        int seatNum = Integer.parseInt(seatCode.substring(1));        
        StringBuilder colBinStrSelected = new StringBuilder();
        for (int i =0 ; i< 31;i++) {
            if(i==(seatNum-1)){
                colBinStrSelected.append("1");
            }else{
                colBinStrSelected.append("0");
            }            
        }
        this.setColBinStr(colNameSelected, colBinStrSelected.toString());
    }

    public void randomSeatDistribute(Aircraft ac) {
        int gseats = ac.getGloryCapacity() / ac.getGloryColumns();
        int fseats = ac.getFancyCapacity() / ac.getFancyColumns();
        int hseats = ac.getHappyCapacity() / ac.getHappyColumns();
        int maxseats = gseats + fseats + hseats;
        int middleseats = fseats + hseats;
        int minseats = hseats;
        for (int i = 0; i < colName.length; i++) {
            String colname = SeatDistribute.colName[i];
            StringBuilder ramdon = new StringBuilder();
            if (i == 0 || i == 4 || i == 5 || i == 9) {
                for (int j = 0; j < maxseats; j++) {
                    int seat = (int) Math.round(Math.random());
                    ramdon.append(seat);
                }
            } else if (i == 1 || i == 8) {
                for (int j = 0; j < middleseats; j++) {
                    int seat = (int) Math.round(Math.random());
                    ramdon.append(seat);
                }
            } else {
                for (int j = 0; j < minseats; j++) {
                    int seat = (int) Math.round(Math.random());
                    ramdon.append(seat);
                }
            }
            this.setColBinStr(colname, ramdon.toString());
        }
        // 補充資料-亂數 : http://hikari-solving.blogspot.tw/2012/02/java.html
    }

    public static String getColBinStr(int column) {
        StringBuilder colBinStr = new StringBuilder(Integer.toBinaryString(column));
        colBinStr.reverse();
        while (colBinStr.length() < 31) {
            colBinStr.append("0");
        }
        colBinStr.reverse();
        return colBinStr.toString();
    }

    public String getColBinStr(String colName) {
        String colBinStr;
        switch (colName) {
            default:
                colBinStr = "colName錯誤";
            case "A":
                colBinStr = this.columnA;
                break;
            case "B":
                colBinStr = this.columnB;
                break;
            case "C":
                colBinStr = this.columnC;
                break;
            case "D":
                colBinStr = this.columnD;
                break;
            case "E":
                colBinStr = this.columnE;
                break;
            case "F":
                colBinStr = this.columnF;
                break;
            case "G":
                colBinStr = this.columnG;
                break;
            case "H":
                colBinStr = this.columnH;
                break;
            case "J":
                colBinStr = this.columnJ;
                break;
            case "K":
                colBinStr = this.columnK;
        }
        return colBinStr;
    }

    public void setColBinStr(String colName, String ColBinStr) {
        switch (colName) {
            default:
                ColBinStr = "colName錯誤";
            case "A":
                this.resetColumnA(ColBinStr);
                break;
            case "B":
                this.resetColumnB(ColBinStr);
                break;
            case "C":
                this.resetColumnC(ColBinStr);
                break;
            case "D":
                this.resetColumnD(ColBinStr);
                break;
            case "E":
                this.resetColumnE(ColBinStr);
                break;
            case "F":
                this.resetColumnF(ColBinStr);
                break;
            case "G":
                this.resetColumnG(ColBinStr);
                break;
            case "H":
                this.resetColumnH(ColBinStr);
                break;
            case "J":
                this.resetColumnJ(ColBinStr);
                break;
            case "K":
                this.resetColumnK(ColBinStr);
        }
    }

    public String getColumnA() {
        return columnA;
    }

    public void resetColumnA(String columnA) {
        StringBuilder columnAsb = new StringBuilder(columnA);
        columnAsb.reverse();
        while (columnAsb.length() < 31) {
            columnAsb.append("0");
        }
        columnAsb.reverse();
        this.columnA = columnAsb.toString();
    }

    public String getColumnB() {
        return columnB;
    }

    public void resetColumnB(String columnB) {
        StringBuilder columnBsb = new StringBuilder(columnB);
        columnBsb.reverse();
        while (columnBsb.length() < 31) {
            columnBsb.append("0");
        }
        columnBsb.reverse();
        this.columnB = columnBsb.toString();
    }

    public String getColumnC() {
        return columnC;
    }

    public void resetColumnC(String columnC) {
        StringBuilder columnCsb = new StringBuilder(columnC);
        columnCsb.reverse();
        while (columnCsb.length() < 31) {
            columnCsb.append("0");
        }
        columnCsb.reverse();
        this.columnC = columnCsb.toString();
    }

    public String getColumnD() {
        return columnD;
    }

    public void resetColumnD(String columnD) {
        StringBuilder columnDsb = new StringBuilder(columnD);
        columnDsb.reverse();
        while (columnDsb.length() < 31) {
            columnDsb.append("0");
        }
        columnDsb.reverse();
        this.columnD = columnDsb.toString();
    }

    public String getColumnE() {
        return columnE;
    }

    public void resetColumnE(String columnE) {
        StringBuilder columnEsb = new StringBuilder(columnE);
        columnEsb.reverse();
        while (columnEsb.length() < 31) {
            columnEsb.append("0");
        }
        columnEsb.reverse();
        this.columnE = columnEsb.toString();
    }

    public String getColumnF() {
        return columnF;
    }

    public void resetColumnF(String columnF) {
        StringBuilder columnFsb = new StringBuilder(columnF);
        columnFsb.reverse();
        while (columnFsb.length() < 31) {
            columnFsb.append("0");
        }
        columnFsb.reverse();
        this.columnF = columnFsb.toString();
    }

    public String getColumnG() {
        return columnG;
    }

    public void resetColumnG(String columnG) {
        StringBuilder columnGsb = new StringBuilder(columnG);
        columnGsb.reverse();
        while (columnGsb.length() < 31) {
            columnGsb.append("0");
        }
        columnGsb.reverse();
        this.columnG = columnGsb.toString();
    }

    public String getColumnH() {
        return columnH;
    }

    public void resetColumnH(String columnH) {
        StringBuilder columnHsb = new StringBuilder(columnH);
        columnHsb.reverse();
        while (columnHsb.length() < 31) {
            columnHsb.append("0");
        }
        columnHsb.reverse();
        this.columnH = columnHsb.toString();
    }

    public String getColumnJ() {
        return columnJ;
    }

    public void resetColumnJ(String columnJ) {
        StringBuilder columnJsb = new StringBuilder(columnJ);
        columnJsb.reverse();
        while (columnJsb.length() < 31) {
            columnJsb.append("0");
        }
        columnJsb.reverse();
        this.columnJ = columnJsb.toString();
    }

    public String getColumnK() {
        return columnK;
    }

    public void resetColumnK(String columnK) {
        StringBuilder columnKsb = new StringBuilder(columnK);
        columnKsb.reverse();
        while (columnKsb.length() < 31) {
            columnKsb.append("0");
        }
        columnKsb.reverse();
        this.columnK = columnKsb.toString();
    }

    @Override
    public String toString() {
        return "SeatDistribute{" + "columnA=" + columnA + ", columnB=" + columnB + ", columnC=" + columnC + ", columnD=" + columnD + ", columnE=" + columnE + ", columnF=" + columnF + ", columnG=" + columnG + ", columnH=" + columnH + ", columnJ=" + columnJ + ", columnK=" + columnK + '}';
    }
    // MySQL參考資料-資料型別: http://www.codedata.com.tw/database/mysql-tutorial-8-storage-engine-datatype/
}
