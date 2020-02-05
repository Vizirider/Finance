package com.example.nodejs.loanActivities;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.nodejs.LoanItem;
import com.example.nodejs.R;
import com.example.nodejs.TransactionItem;
import com.example.nodejs.User;
import com.example.nodejs.retrofit.ITSHBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.example.nodejs.utils.LoanRecycleViewAdapter;
import com.example.nodejs.utils.TransactionRecycleViewAdapter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;

import java.util.ArrayList;

import in.galaxyofandroid.spinerdialog.SpinnerDialog;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class LoanActivity extends AppCompatActivity implements LoanRecycleViewAdapter.ItemClickListener {

    ITSHBackend myAPI;
    Gson gson = new GsonBuilder().setLenient().create();
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    LoanRecycleViewAdapter loanRecycleViewAdapter;

    public void addCatalogueJsonArrayToRecyclerView(RecyclerView recyclerView, JsonArray catalogueJsonArray) {
        loanRecycleViewAdapter = new LoanRecycleViewAdapter(LoanActivity.this, catalogueJsonArray);
        loanRecycleViewAdapter.setClickListener(LoanActivity.this);
        loanRecycleViewAdapter.setHasStableIds(true);
        recyclerView.setAdapter(loanRecycleViewAdapter);
    }

    private void cancelUpdate() {
        Intent myIntent = new Intent(LoanActivity.this, FinanceLoanActivity.class);
        LoanActivity.this.startActivity(myIntent);
        finish();
    }

    private void startItemActivity(){
        Intent myIntent = new Intent(LoanActivity.this, LoanItemViewActivity.class);
        this.startActivity(myIntent);
    }

    private boolean isThereStoredCatalogue() {
        final SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(LoanActivity.this);
        final String userString = settings.getString("loan", "{}");

        return !userString.equals("{}");
    }

    @Override
    public void onItemClick(View view, int position) {
        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(LoanActivity.this);
        //LoanItem catalogueItem = loanRecycleViewAdapter.getItem(position);
        //settings.edit().putString("loanItem", gson.toJson(catalogueItem)).apply();
        startItemActivity();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_catalogue);

        final RecyclerView recyclerView = findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setItemViewCacheSize(20);
        recyclerView.setDrawingCacheEnabled(true);
        recyclerView.setDrawingCacheQuality(View.DRAWING_CACHE_QUALITY_HIGH);
        recyclerView.setHasFixedSize(true);

        final SpinnerDialog siteSpinnerDialog;
        final SpinnerDialog categorySpinnerDialog;

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(ITSHBackend.class);
        final SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(LoanActivity.this);

        final TransactionItem transactionItem = gson.fromJson(settings.getString("loan","{}"), TransactionItem.class);

        // Initialize GUI elements
        final ArrayList<TextView> filterTextArrayList = new ArrayList<>();
        filterTextArrayList.add(findViewById(R.id.filterTextView1));
        filterTextArrayList.add(findViewById(R.id.filterTextView2));
        filterTextArrayList.add(findViewById(R.id.filterTextView3));
        filterTextArrayList.add(findViewById(R.id.filterTextView4));
        filterTextArrayList.add(findViewById(R.id.filterTextView5));

        Button catalogueListButton = findViewById(R.id.updateListButton);
        final Button cancelCatalogue = findViewById(R.id.cancelCatalogueButton);
        final LinearLayout linearLayout = new LinearLayout(LoanActivity.this);

        // Set GUI element parameters
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setHorizontalGravity(LinearLayout.TEXT_ALIGNMENT_CENTER);
        linearLayout.getDividerDrawable();

        // Load stored catalogue if exists
        if (isThereStoredCatalogue()){
            JsonArray catalogueJsonArray = gson.fromJson(settings.getString("loan", "{}"), JsonArray.class);
            addCatalogueJsonArrayToRecyclerView(recyclerView, catalogueJsonArray);
        }

        // Remove filters
        for (final TextView filter: filterTextArrayList) {
            filter.setOnClickListener(v -> {
                filter.setVisibility(View.INVISIBLE);
                filter.setText("");
            });
        }

        Button siteDialogButton = findViewById(R.id.siteDialogButton);
        siteDialogButton.setVisibility(View.GONE);

        cancelCatalogue.setOnClickListener(v -> cancelUpdate());

        catalogueListButton.setOnClickListener(v -> {

            String token = settings.getString("token", "");
            String bearerToken = getString(R.string.bearer_token) + " " + token;
            linearLayout.removeAllViews();

            myAPI = retrofit.create(ITSHBackend.class);
            compositeDisposable.add(myAPI.getTransaction(bearerToken)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(response -> {
                        if (response.code() >= 200 && response.code() < 300) {
                            JsonArray allUsersJsonArray = response.body().getAsJsonArray("transaction");
                            settings.edit().putString("transaction", gson.toJson(allUsersJsonArray)).apply();
                            addCatalogueJsonArrayToRecyclerView(recyclerView, allUsersJsonArray);
                            User.storeTokenIfChanged(this, bearerToken, response.headers().get("Authorization"));
                            Toast.makeText(LoanActivity.this, "Loan list retrieve successful.", Toast.LENGTH_LONG).show();
                        } else {
                            Toast.makeText(LoanActivity.this, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                        }
                    }));
        });

        Button categoryDialogButton = findViewById(R.id.catalogueDialogButton);
        categoryDialogButton.setText("SUM Amount");

        categoryDialogButton.setOnClickListener(v -> {

            String token = settings.getString("token", "");
            String bearerToken = getString(R.string.bearer_token) + " " + token;
            linearLayout.removeAllViews();

            myAPI = retrofit.create(ITSHBackend.class);
            compositeDisposable.add(myAPI.sumTransaction(bearerToken)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(response -> {
                        if (response.code() >= 200 && response.code() < 300) {
                            JsonArray allUsersJsonArray = response.body().getAsJsonArray("loan");
                            settings.edit().putString("loan", gson.toJson(allUsersJsonArray)).apply();
                            User.storeTokenIfChanged(this, bearerToken, response.headers().get("Authorization"));
                            Toast.makeText(LoanActivity.this, allUsersJsonArray + "", Toast.LENGTH_LONG).show();
                        } else {
                            Toast.makeText(LoanActivity.this, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                        }
                    }));
        });

    }

    }