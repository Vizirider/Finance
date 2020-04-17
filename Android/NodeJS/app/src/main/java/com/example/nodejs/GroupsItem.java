package com.example.nodejs;

import android.os.Parcel;
import android.os.Parcelable;

public class GroupsItem implements Parcelable {
    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(Groups);
        dest.writeString(income_outcome);
        dest.writeString(currency);
        dest.writeString(Date);
        dest.writeString(category_name);
        dest.writeString(balance);
        dest.writeString(message);

    }

    private GroupsItem(Parcel in) {
        Groups = in.readInt();
        income_outcome = in.readString();
        currency = in.readString();
        Date = in.readString();
        category_name = in.readString();
        balance = in.readString();
        message = in.readString();


    }
    public static final Parcelable.Creator<GroupsItem> CREATOR = new Parcelable.Creator<GroupsItem>() {
        public GroupsItem createFromParcel(Parcel in) {
            return new GroupsItem(in);
        }

        public GroupsItem[] newArray(int size) {
            return new GroupsItem[size];
        }
    };

    private Integer Groups;
    private String category_name;
    private String income_outcome;
    private String currency;
    private String Date;
    private String balance;
    private String message;

    public Integer getGroups() { return Groups; }

    public void setGroups(Integer Groups) { this.Groups = Groups; }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getIncome_outcome() {
        return income_outcome;
    }

    public void setIncome_outcome(String income_outcome) {
        this.income_outcome = income_outcome;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getDate() {
        return Date;
    }

    public void setDate(String Date) {
        this.Date = Date;
    }

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
