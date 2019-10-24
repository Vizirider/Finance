package com.example.nodejs.transactionActivities;

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

import com.example.nodejs.CatalogueItem;
import com.example.nodejs.HomeActivity;
import com.example.nodejs.R;
import com.example.nodejs.TransactionItem;
import com.example.nodejs.User;
import com.example.nodejs.adminActivities.ListAllUsersActivity;
import com.example.nodejs.adminActivities.SelectedUserActivity;
import com.example.nodejs.catalogueActivities.CatalogueActivity;
import com.example.nodejs.catalogueActivities.CatalogueItemViewActivity;
import com.example.nodejs.catalogueActivities.DiscountCatalogueActivity;
import com.example.nodejs.retrofit.ITSHBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.example.nodejs.utils.CatalogueRecycleViewAdapter;
import com.example.nodejs.utils.TransactionRecycleViewAdapter;
import com.example.nodejs.utils.UsersRecycleViewAdapter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;

import java.util.ArrayList;
import java.util.HashMap;

import in.galaxyofandroid.spinerdialog.SpinnerDialog;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class TransactionActivity extends AppCompatActivity implements TransactionRecycleViewAdapter.ItemClickListener {

    ITSHBackend myAPI;
    Gson gson = new GsonBuilder().setLenient().create();
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    TransactionRecycleViewAdapter transactionRecycleViewAdapter;

    HashMap<String, Integer> siteHashMap = new HashMap<>();
    HashMap<String, Integer> categoryHashMap = new HashMap<>();

    public void addCatalogueJsonArrayToRecyclerView(RecyclerView recyclerView, JsonArray catalogueJsonArray) {
        transactionRecycleViewAdapter = new TransactionRecycleViewAdapter(TransactionActivity.this, catalogueJsonArray);
        transactionRecycleViewAdapter.setClickListener(TransactionActivity.this);
        transactionRecycleViewAdapter.setHasStableIds(true);
        recyclerView.setAdapter(transactionRecycleViewAdapter);
    }

    private void cancelUpdate() {
        Intent myIntent = new Intent(TransactionActivity.this, FinanceTransactionActivity.class);
        TransactionActivity.this.startActivity(myIntent);
        finish();
    }

    private void startItemActivity(){
        Intent myIntent = new Intent(TransactionActivity.this, TransactionItemViewActivity.class);
        this.startActivity(myIntent);
    }

    private boolean isThereStoredCatalogue() {
        final SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(TransactionActivity.this);
        final String userString = settings.getString("transaction", "{}");

        return !userString.equals("{}");
    }

    @Override
    public void onItemClick(View view, int position) {
        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(TransactionActivity.this);
        TransactionItem catalogueItem = transactionRecycleViewAdapter.getItem(position);
        settings.edit().putString("transactionItem", gson.toJson(catalogueItem)).apply();
        startItemActivity();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_catalogue);

        siteHashMap.put(getResources().getString(R.string.szeged), 1);
        siteHashMap.put(getResources().getString(R.string.pecs), 2);
        siteHashMap.put(getResources().getString(R.string.debrecen), 3);
        siteHashMap.put(getResources().getString(R.string.budapest), 4);
        siteHashMap.put(getResources().getString(R.string.country_wise), 5);

        String[] categoriesFromStrings = getResources().getStringArray(R.array.category_id);

        for (String cat: categoriesFromStrings){
            categoryHashMap.put(cat, categoryHashMap.size()+1);
        }

        final ArrayList<String> siteList = new ArrayList<>(siteHashMap.keySet());
        final ArrayList<String> categoryList = new ArrayList<>(categoryHashMap.keySet());

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
        final SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(TransactionActivity.this);

        siteSpinnerDialog = new SpinnerDialog(TransactionActivity.this, siteList, getString(R.string.select_site));
        categorySpinnerDialog = new SpinnerDialog(TransactionActivity.this, categoryList, getString(R.string.select_category));

        // Initialize GUI elements
        final ArrayList<TextView> filterTextArrayList = new ArrayList<>();
        filterTextArrayList.add(findViewById(R.id.filterTextView1));
        filterTextArrayList.add(findViewById(R.id.filterTextView2));
        filterTextArrayList.add(findViewById(R.id.filterTextView3));
        filterTextArrayList.add(findViewById(R.id.filterTextView4));
        filterTextArrayList.add(findViewById(R.id.filterTextView5));

        Button catalogueListButton = findViewById(R.id.updateListButton);
        final Button cancelCatalogue = findViewById(R.id.cancelCatalogueButton);
        final LinearLayout linearLayout = new LinearLayout(TransactionActivity.this);

        // Set GUI element parameters
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setHorizontalGravity(LinearLayout.TEXT_ALIGNMENT_CENTER);
        linearLayout.getDividerDrawable();

        // Load stored catalogue if exists
        if (isThereStoredCatalogue()){
            JsonArray catalogueJsonArray = gson.fromJson(settings.getString("transaction", "{}"), JsonArray.class);
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
        siteDialogButton.setOnClickListener(v -> siteSpinnerDialog.showSpinerDialog());

        Button categoryDialogButton = findViewById(R.id.catalogueDialogButton);
        categoryDialogButton.setOnClickListener(v -> categorySpinnerDialog.showSpinerDialog());

        siteSpinnerDialog.bindOnSpinerListener((item, position) -> {
            for (int i = 0; i < siteHashMap.size(); i++) {
                if (filterTextArrayList.get(i).getText().equals("") || filterTextArrayList.get(i).getText().equals(item)) {
                    filterTextArrayList.get(i).setVisibility(View.VISIBLE);
                    filterTextArrayList.get(i).setText(item);
                    break;
                }
            }
        });

        categorySpinnerDialog.bindOnSpinerListener((item, position) -> {
            for (int j = 0; j < siteHashMap.size(); j++) {
                if (filterTextArrayList.get(j).getText().equals("") || filterTextArrayList.get(j).getText().equals(item)) {
                    filterTextArrayList.get(j).setVisibility(View.VISIBLE);
                    filterTextArrayList.get(j).setText(item);
                    break;
                }
            }
        });

        cancelCatalogue.setOnClickListener(v -> cancelUpdate());

        catalogueListButton.setOnClickListener(v -> {
            final ArrayList<String> selectedSiteIds = new ArrayList<>();
            final ArrayList<String> selectedCategoryIds = new ArrayList<>();

            for (int i = 0; i < filterTextArrayList.size(); i++) {
                String text = filterTextArrayList.get(i).getText().toString();
                Integer siteId = siteHashMap.get(text);
                if (siteId != null) {
                    selectedSiteIds.add(siteId.toString());
                }
            }

            for (int j = 0; j < filterTextArrayList.size(); j++) {
                Integer categoryId = categoryHashMap.get(filterTextArrayList.get(j).getText());
                if (categoryId != null) {
                    selectedCategoryIds.add(categoryId.toString());
                }
            }

            String[] siteStringArray = selectedSiteIds.toArray(new String[selectedSiteIds.size()]);
            String[] categoryStringArray = selectedCategoryIds.toArray(new String[selectedCategoryIds.size()]);

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
                            Toast.makeText(TransactionActivity.this, "Transaction list retrieve successful.", Toast.LENGTH_LONG).show();
                        } else {
                            Toast.makeText(TransactionActivity.this, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                        }
                    }));
        });
    }

    }