package com.example.nodejs.utils;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.nodejs.CatalogueItem;
import com.example.nodejs.PlanningItem;
import com.example.nodejs.R;
import com.example.nodejs.GroupsItem;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;

public class PlanningRecycleViewAdapter extends RecyclerView.Adapter<PlanningRecycleViewAdapter.ViewHolder> {
    private JsonArray mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;
    Gson gson = new GsonBuilder().setLenient().create();

    // Data is passed into the constructor
    public PlanningRecycleViewAdapter(Context context, JsonArray data){
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
        PlanningItem GroupsItemElement = gson.fromJson(mData.get(i), PlanningItem.class);
        String GroupsItemElementincome_outcome = GroupsItemElement.getCurrency();
        Integer GroupsItemElementCurrency = GroupsItemElement.getFix_outcome();
        Integer GroupsItemElementDate = GroupsItemElement.getCost();
        Integer GroupsItemElementCategory = GroupsItemElement.getLong_term();
        Integer GroupsItemElementMessage = GroupsItemElement.getShort_term();
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
        TextView GroupsItemElementincome_outcome;
        TextView GroupsItemElementCurrency;
        TextView GroupsItemElementDate;
        TextView GroupsItemElementCategory;
        TextView GroupsItemElementMessage;

        ViewHolder(View itemView) {
            super(itemView);
            GroupsItemElementincome_outcome = itemView.findViewById(R.id.income_outcome);
            GroupsItemElementCurrency = itemView.findViewById(R.id.currency);
            GroupsItemElementDate = itemView.findViewById(R.id.date);
            GroupsItemElementCategory = itemView.findViewById(R.id.category);
            GroupsItemElementMessage = itemView.findViewById(R.id.message);
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
