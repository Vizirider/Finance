package com.example.nodejs;

import android.os.Parcel;
import android.os.Parcelable;

public class TransactionItem implements Parcelable {
    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(transaction);
        dest.writeString(product_category);
        dest.writeInt(income_outcome);
        dest.writeString(currency);
        dest.writeString(Date);

    }

    private TransactionItem(Parcel in) {
        transaction = in.readInt();
        product_category = in.readString();
        income_outcome = in.readInt();
        currency = in.readString();
        Date = in.readString();

    }
    public static final Parcelable.Creator<TransactionItem> CREATOR = new Parcelable.Creator<TransactionItem>() {
        public TransactionItem createFromParcel(Parcel in) {
            return new TransactionItem(in);
        }

        public TransactionItem[] newArray(int size) {
            return new TransactionItem[size];
        }
    };

    private Integer transaction;
    private String product_category;
    private Integer income_outcome;
    private String currency;
    private String Date;


    public Integer getTransaction() { return transaction; }

    public void setTransaction(Integer transaction) { this.transaction = transaction; }

    public String getProduct_category() {
        return product_category;
    }

    public void setProduct_category(String product_category) {
        this.product_category = product_category;
    }

    public Integer getIncome_outcome() {
        return income_outcome;
    }

    public void setIncome_outcome(Integer income_outcome) {
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

}
