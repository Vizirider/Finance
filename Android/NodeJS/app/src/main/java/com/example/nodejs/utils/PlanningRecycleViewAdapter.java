package com.example.nodejs.utils;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

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
        View view = mInflater.inflate(R.layout.planning_card_layout, parent, false);
        return new ViewHolder(view);

    }

    // Binds the data to the 'TextView' in each row
    @Override
    public void onBindViewHolder(ViewHolder holder, int i) {
        PlanningItem GroupsItemElement = gson.fromJson(mData.get(i), PlanningItem.class);
        String GroupsItemElementincome_outcome = GroupsItemElement.getCurrency();
        String GroupsItemSalary = "Salary: " + GroupsItemElement.getSalary() + " "  + GroupsItemElement.getCurrency();
        String GroupsItemElementCurrency = "Fix outcome: " + GroupsItemElement.getFix_outcome() + " "  + GroupsItemElement.getCurrency();;
        String GroupsItemElementDate = "Cost:" + GroupsItemElement.getCost() + " "  + GroupsItemElement.getCurrency();;
        String GroupsItemElementCategory = "Long term: " + GroupsItemElement.getLong_term() + " "  + GroupsItemElement.getCurrency();;
        String GroupsItemElementMessage = "Short term: " + GroupsItemElement.getShort_term() + " "  + GroupsItemElement.getCurrency();;
        holder.GroupsItemElementDate.setText(GroupsItemElementDate);
        holder.GroupsItemElementCurrency.setText(GroupsItemElementCurrency);
        holder.GroupsItemSalary.setText(GroupsItemSalary);
        holder.GroupsItemElementCategory.setText(GroupsItemElementCategory);
        holder.GroupsItemElementMessage.setText(GroupsItemElementMessage);
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
        TextView GroupsItemSalary;
        TextView GroupsItemElementCurrency;
        TextView GroupsItemElementDate;
        TextView GroupsItemElementCategory;
        TextView GroupsItemElementMessage;

        ViewHolder(View itemView) {
            super(itemView);
            GroupsItemElementDate = itemView.findViewById(R.id.currency2);
            GroupsItemElementCurrency = itemView.findViewById(R.id.date);
            GroupsItemSalary = itemView.findViewById(R.id.income_outcome);
            GroupsItemElementCategory = itemView.findViewById(R.id.message);
            GroupsItemElementMessage = itemView.findViewById(R.id.category);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            if (mClickListener != null) mClickListener.onItemClick(view, getAdapterPosition());
        }
    }

    // Convenience method for getting data at click position
    public PlanningItem getItem(int id) {
        return gson.fromJson(mData.get(id), PlanningItem.class);
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
