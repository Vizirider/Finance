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
        dest.writeString(salary);
        dest.writeString(fix_outcome);
        dest.writeString(cost);
        dest.writeString(long_term);
        dest.writeString(short_term);

    }

    private PlanningItem(Parcel in) {

        currency = in.readString();
        salary = in.readString();
        fix_outcome = in.readString();
        cost = in.readString();
        long_term = in.readString();
        short_term = in.readString();


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

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getFix_outcome() {
        return fix_outcome;
    }

    public void setFix_outcome(String fix_outcome) {
        this.fix_outcome = fix_outcome;
    }

    public String getCost() {
        return cost;
    }

    public void setCost(String cost) {
        this.cost = cost;
    }

    public String getLong_term() {
        return long_term;
    }

    public void setLong_term(String long_term) {
        this.long_term = long_term;
    }

    public String getShort_term() {
        return short_term;
    }

    public void setShort_term(String short_term) {
        this.short_term = short_term;
    }

    private String salary;
    private String fix_outcome;
    private String cost;
    private String long_term;
    private String short_term;


    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }


}
