package com.example.nodejs;

import android.os.Parcel;
import android.os.Parcelable;

public class PlanningItem implements Parcelable {
    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {

        dest.writeString(currency);
        dest.writeInt(salary);
        dest.writeInt(fix_outcome);
        dest.writeInt(cost);
        dest.writeInt(long_term);
        dest.writeInt(short_term);

    }

    private PlanningItem(Parcel in) {

        currency = in.readString();
        salary = in.readInt();
        fix_outcome = in.readInt();
        cost = in.readInt();
        long_term = in.readInt();
        short_term = in.readInt();


    }
    public static final Parcelable.Creator<PlanningItem> CREATOR = new Parcelable.Creator<PlanningItem>() {
        public PlanningItem createFromParcel(Parcel in) {
            return new PlanningItem(in);
        }

        public PlanningItem[] newArray(int size) {
            return new PlanningItem[size];
        }
    };
    private String currency;

    public Integer getSalary() {
        return salary;
    }

    public void setSalary(Integer salary) {
        this.salary = salary;
    }

    public Integer getFix_outcome() {
        return fix_outcome;
    }

    public void setFix_outcome(Integer fix_outcome) {
        this.fix_outcome = fix_outcome;
    }

    public Integer getCost() {
        return cost;
    }

    public void setCost(Integer cost) {
        this.cost = cost;
    }

    public Integer getLong_term() {
        return long_term;
    }

    public void setLong_term(Integer long_term) {
        this.long_term = long_term;
    }

    public Integer getShort_term() {
        return short_term;
    }

    public void setShort_term(Integer short_term) {
        this.short_term = short_term;
    }

    private Integer salary;
    private Integer fix_outcome;
    private Integer cost;
    private Integer long_term;
    private Integer short_term;


    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }


}
