package aac.domain.dataCategory;

/**
 *
 * @author Walker
 */
public enum Aircraft {

    A330(8, 30, 240, 4, 6, 10, 1, 0, 2), B777(8, 24, 250, 4, 6, 10, 1, 0, 2);

    private final int carryCapacity;
    private final int gloryCapacity;
    private final int fancyCapacity;
    private final int happyCapacity;
    private final int gloryColumns;
    private final int fancyColumns;
    private final int happyColumns;
    private final int gloryAisle;
    private final int fancyAisle;
    private final int happyAisle;

    Aircraft(int gloryCapacity, int fancyCapacity, int happyCapacity, int gloryColumns, int fancyColumns, int happyColumns,
            int gloryAisle, int fancyAisle, int happyAisle) {
        this.carryCapacity = gloryCapacity + fancyCapacity + happyCapacity;
        this.gloryCapacity = gloryCapacity;
        this.fancyCapacity = fancyCapacity;
        this.happyCapacity = happyCapacity;
        this.gloryColumns = gloryColumns;
        this.fancyColumns = fancyColumns;
        this.happyColumns = happyColumns;
        this.gloryAisle = gloryAisle;
        this.fancyAisle = fancyAisle;
        this.happyAisle = happyAisle;
    }

    public static Aircraft getA330() {
        return A330;
    }

    public static Aircraft getB777() {
        return B777;
    }

    public int getCarryCapacity() {
        return carryCapacity;
    }

    public int getGloryCapacity() {
        return gloryCapacity;
    }

    public int getFancyCapacity() {
        return fancyCapacity;
    }

    public int getHappyCapacity() {
        return happyCapacity;
    }

    public int getGloryColumns() {
        return gloryColumns;
    }

    public int getFancyColumns() {
        return fancyColumns;
    }

    public int getHappyColumns() {
        return happyColumns;
    }

    public int getGloryAisle() {
        return gloryAisle;
    }

    public int getFancyAisle() {
        return fancyAisle;
    }

    public int getHappyAisle() {
        return happyAisle;
    }

    @Override
    public String toString() {
        return this.name() + "{" + "carryCapacity=" + carryCapacity + ", gloryCapacity=" + gloryCapacity + ", fancyCapacity=" + fancyCapacity + ", happyCapacity=" + happyCapacity + ", gloryColumns=" + gloryColumns + ", fancyColumns=" + fancyColumns + ", happyColumns=" + happyColumns + ", gloryAisle=" + gloryAisle + ", fancyAisle=" + fancyAisle + ", happyAisle=" + happyAisle + '}';
    }
}
