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
        dest.writeString(income_outcome);
        dest.writeString(currency);
        dest.writeString(Date);
        dest.writeString(category_name);
        dest.writeString(balance);
        dest.writeString(message);

    }

    private TransactionItem(Parcel in) {
        transaction = in.readInt();
        income_outcome = in.readString();
        currency = in.readString();
        Date = in.readString();
        category_name = in.readString();
        balance = in.readString();
        message = in.readString();


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
    private String category_name;
    private String income_outcome;
    private String currency;
    private String Date;
    private String balance;
    private String message;

    public Integer getTransaction() { return transaction; }

    public void setTransaction(Integer transaction) { this.transaction = transaction; }

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
