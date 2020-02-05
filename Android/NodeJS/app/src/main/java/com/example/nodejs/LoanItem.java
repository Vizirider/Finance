package com.example.nodejs;

import android.os.Parcel;
import android.os.Parcelable;

public class LoanItem implements Parcelable {
    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(loan);
        dest.writeString(amount);
        dest.writeString(currency);
        dest.writeString(Date);
        dest.writeString(category_name);

    }

    private LoanItem(Parcel in) {
        loan = in.readInt();
        amount = in.readString();
        currency = in.readString();
        Date = in.readString();
        category_name = in.readString();

    }
    public static final Parcelable.Creator<LoanItem> CREATOR = new Parcelable.Creator<LoanItem>() {
        public LoanItem createFromParcel(Parcel in) {
            return new LoanItem(in);
        }

        public LoanItem[] newArray(int size) {
            return new LoanItem[size];
        }
    };

    private Integer loan;
    private String category_name;
    private String amount;
    private String currency;
    private String Date;

    public Integer getLoan() { return loan; }

    public void setLoan(Integer transaction) { this.loan = loan; }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
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


}
