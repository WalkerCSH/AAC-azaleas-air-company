/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aac.domain.dataCategory;

/**
 *
 * @author Administrator
 */
public enum Country {
    ROC("台灣"), CHN("中國大陸"), JPN("日本"), KOR("韓國"),
    SIN("新加坡"), MYS("馬來西亞"), PHL("菲律賓"), THA("泰國"),
    VNM("越南"), MMR("緬甸"), LAO("寮國"), KHM("柬埔寨"),OTHER("其他國家");

    private final String nameTCN;

    //資料來源 : https://www.cadiis.com.tw/zh-tw/tool-box/494-internet-country-code-table
    // https://zh.wikipedia.org/wiki/%E5%9C%8B%E5%AE%B6%E5%9C%B0%E5%8D%80%E4%BB%A3%E7%A2%BC
    private Country(String nameTCN) {
        this.nameTCN = nameTCN;
    }

    public static Country getROC() {
        return ROC;
    }

    public static Country getCHN() {
        return CHN;
    }

    public static Country getJPN() {
        return JPN;
    }

    public static Country getKOR() {
        return KOR;
    }

    public static Country getSIN() {
        return SIN;
    }

    public static Country getMYS() {
        return MYS;
    }

    public static Country getPHL() {
        return PHL;
    }

    public static Country getTHA() {
        return THA;
    }

    public static Country getVNM() {
        return VNM;
    }

    public static Country getMMR() {
        return MMR;
    }

    public static Country getLAO() {
        return LAO;
    }

    public static Country getKHM() {
        return KHM;
    }

    public String getNameTCN() {
        return nameTCN;
    }

}
