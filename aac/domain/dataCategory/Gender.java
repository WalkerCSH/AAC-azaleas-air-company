package aac.domain.dataCategory;

public enum Gender {

    MALE("男性"), FEMALE("女性");
    
    private final String nameTCN;

    private Gender(String nameTCN) {
        this.nameTCN = nameTCN;
    }

    public static Gender getMALE() {
        return MALE;
    }

    public static Gender getFEMALE() {
        return FEMALE;
    }

    public String getNameTCN() {
        return nameTCN;
    }
    
}
