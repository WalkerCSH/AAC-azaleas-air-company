package aac.domain.dataCategory;

/**
 *
 * @author Walker
 */
public enum Airport {

    TSA("松山國際機場", "台北", "台灣"),
    BKK("曼谷國際機場", "曼谷", "泰國"),
    HND("羽田國際機場", "東京", "日本"),
    SIN("樟宜國際機場", "新加坡", "新加坡");

    private final String name;
    private final String city;
    private final String country;   

    private Airport(String name, String city, String country) {
        this.name = name;
        this.city = city;
        this.country = country;
    }

    public static Airport getTPE() {
        return TSA;
    }

    public static Airport getBKK() {
        return BKK;
    }

    public static Airport getNRT() {
        return HND;
    }

    public static Airport getSIN() {
        return SIN;
    }

    public String getName() {
        return name;
    }

    public String getCity() {
        return city;
    }

    public String getCountry() {
        return country;
    }

    @Override
    public String toString() {
        return "Airport{" + "name=" + name + ", city=" + city + ", country=" + country + '}';
    }

    

    
}
