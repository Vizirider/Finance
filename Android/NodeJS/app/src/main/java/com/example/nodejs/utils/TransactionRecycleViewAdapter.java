package com.example.nodejs.utils;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.nodejs.CatalogueItem;
import com.example.nodejs.R;
import com.example.nodejs.TransactionItem;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;

public class TransactionRecycleViewAdapter extends RecyclerView.Adapter<TransactionRecycleViewAdapter.ViewHolder> {
    private JsonArray mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;
    Gson gson = new GsonBuilder().setLenient().create();

    // Data is passed into the constructor
    public TransactionRecycleViewAdapter(Context context, JsonArray data){
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
    }

    // Inflates the row layout-w330dp from 'xml' when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.transaction_card_layout, parent, false);
        return new ViewHolder(view);
    }

    // Binds the data to the 'TextView' in each row
    @Override
    public void onBindViewHolder(ViewHolder holder, int i) {
        TransactionItem TransactionItemElement = gson.fromJson(mData.get(i), TransactionItem.class);
        String transactionItemElementincome_outcome = TransactionItemElement.getIncome_outcome();
        String transactionItemElementCurrency = TransactionItemElement.getCurrency();
        String transactionItemElementDate = TransactionItemElement.getDate();
        String transactionItemElementCategory = TransactionItemElement.getCategory_name();
        String transactionItemElementMessage = TransactionItemElement.getMessage();
        holder.transactionItemIncomeOutcome.setText(transactionItemElementincome_outcome);
        holder.transactionItemCurrency.setText(transactionItemElementCurrency);
        holder.transactionItemDate.setText(transactionItemElementDate);
        holder.transactionCategory.setText(transactionItemElementCategory);
        holder.transactionMessage.setText(transactionItemElementMessage);
    }

    // Total number of rows
    @Override
    public int getItemCount() {
        System.out.print(mData);
        if (mData != null) {
            return mData.size();
        }
        return 0;
    }

    // Stores and recycles views as they are scrolled off screen
    public class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener{
        TextView transactionItemIncomeOutcome;
        TextView transactionItemCurrency;
        TextView transactionItemDate;
        TextView transactionCategory;
        TextView transactionMessage;

        ViewHolder(View itemView) {
            super(itemView);
            transactionItemIncomeOutcome = itemView.findViewById(R.id.income_outcome);
            transactionItemCurrency = itemView.findViewById(R.id.currency);
            transactionItemDate = itemView.findViewById(R.id.date);
            transactionCategory = itemView.findViewById(R.id.category);
            transactionMessage = itemView.findViewById(R.id.message);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            if (mClickListener != null) mClickListener.onItemClick(view, getAdapterPosition());
        }
    }

    // Convenience method for getting data at click position
    public TransactionItem getItem(int id) {
        return gson.fromJson(mData.get(id), TransactionItem.class);
    }

    // Parent activity will implement this method to respond to click events
    public interface ItemClickListener{
        void onItemClick(View view, int position);
    }

    // Allows clicks events to be caught
    public void setClickListener(ItemClickListener itemClickListener){
        this.mClickListener = itemClickListener;
    }
}
