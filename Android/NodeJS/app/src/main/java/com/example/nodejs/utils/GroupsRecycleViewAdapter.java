package com.example.nodejs.utils;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.nodejs.CatalogueItem;
import com.example.nodejs.R;
import com.example.nodejs.GroupsItem;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;

public class GroupsRecycleViewAdapter extends RecyclerView.Adapter<GroupsRecycleViewAdapter.ViewHolder> {
    private JsonArray mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;
    Gson gson = new GsonBuilder().setLenient().create();

    // Data is passed into the constructor
    public GroupsRecycleViewAdapter(Context context, JsonArray data){
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
    }

    // Inflates the row layout-w330dp from 'xml' when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.groups_card_layout, parent, false);
        return new ViewHolder(view);
    }

    // Binds the data to the 'TextView' in each row
    @Override
    public void onBindViewHolder(ViewHolder holder, int i) {
        GroupsItem GroupsItemElement = gson.fromJson(mData.get(i), GroupsItem.class);
        String GroupsItemElementincome_outcome = GroupsItemElement.getIncome_outcome();
        String GroupsItemElementCurrency = GroupsItemElement.getCurrency();
        String GroupsItemElementDate = GroupsItemElement.getDate();
        String GroupsItemElementCategory = GroupsItemElement.getCategory_name();
        String GroupsItemElementMessage = GroupsItemElement.getMessage();
        holder.GroupsItemIncomeOutcome.setText(GroupsItemElementincome_outcome);
        holder.GroupsItemCurrency.setText(GroupsItemElementCurrency);
        holder.GroupsItemDate.setText(GroupsItemElementDate);
        holder.GroupsCategory.setText(GroupsItemElementCategory);
        holder.GroupsMessage.setText(GroupsItemElementMessage);
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
        TextView GroupsItemIncomeOutcome;
        TextView GroupsItemCurrency;
        TextView GroupsItemDate;
        TextView GroupsCategory;
        TextView GroupsMessage;

        ViewHolder(View itemView) {
            super(itemView);
            GroupsItemIncomeOutcome = itemView.findViewById(R.id.income_outcome);
            GroupsItemCurrency = itemView.findViewById(R.id.currency);
            GroupsItemDate = itemView.findViewById(R.id.date);
            GroupsCategory = itemView.findViewById(R.id.category);
            GroupsMessage = itemView.findViewById(R.id.message);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            if (mClickListener != null) mClickListener.onItemClick(view, getAdapterPosition());
        }
    }

    // Convenience method for getting data at click position
    public GroupsItem getItem(int id) {
        return gson.fromJson(mData.get(id), GroupsItem.class);
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
