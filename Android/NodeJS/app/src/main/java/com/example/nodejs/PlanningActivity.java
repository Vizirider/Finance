package com.example.nodejs;

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

import com.example.nodejs.R;
import com.example.nodejs.TransactionItem;
import com.example.nodejs.User;
import com.example.nodejs.retrofit.FinanceBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.example.nodejs.utils.TransactionRecycleViewAdapter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.util.ArrayList;

import in.galaxyofandroid.spinerdialog.SpinnerDialog;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class PlanningActivity extends AppCompatActivity implements TransactionRecycleViewAdapter.ItemClickListener {

    FinanceBackend myAPI;
    Gson gson = new GsonBuilder().setLenient().create();
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    TransactionRecycleViewAdapter transactionRecycleViewAdapter;

    public void addCatalogueJsonArrayToRecyclerView(RecyclerView recyclerView, JsonArray catalogueJsonArray) {
        transactionRecycleViewAdapter = new TransactionRecycleViewAdapter(PlanningActivity.this, catalogueJsonArray);
        transactionRecycleViewAdapter.setClickListener(PlanningActivity.this);
        transactionRecycleViewAdapter.setHasStableIds(true);
        recyclerView.setAdapter(transactionRecycleViewAdapter);
    }

    private void cancelUpdate() {
        Intent myIntent = new Intent(PlanningActivity.this, HomeActivity.class);
        PlanningActivity.this.startActivity(myIntent);
        finish();
    }

   /* private void startItemActivity(){
        Intent myIntent = new Intent(PlanningActivity.this, PlanningItemViewActivity.class);
        this.startActivity(myIntent);
    }*/

    private boolean isThereStoredCatalogue() {
        final SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(PlanningActivity.this);
        final String userString = settings.getString("planning", "{}");

        return !userString.equals("{}");
    }

    @Override
    public void onItemClick(View view, int position) {
        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(PlanningActivity.this);
        TransactionItem catalogueItem = transactionRecycleViewAdapter.getItem(position);
        settings.edit().putString("planningItem", gson.toJson(catalogueItem)).apply();
        //startItemActivity();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_planning);

        final RecyclerView recyclerView = findViewById(R.id.recyclerViewPlanning);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setItemViewCacheSize(20);
        recyclerView.setDrawingCacheEnabled(true);
        recyclerView.setDrawingCacheQuality(View.DRAWING_CACHE_QUALITY_HIGH);
        recyclerView.setHasFixedSize(true);

        final SpinnerDialog siteSpinnerDialog;
        final SpinnerDialog categorySpinnerDialog;

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(FinanceBackend.class);
        final SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(PlanningActivity.this);


        Button catalogueListButton = findViewById(R.id.updateListPlanningButton);
        Button cancelUpdate = findViewById(R.id.updateListPlanningButton2);
        final LinearLayout linearLayout = new LinearLayout(PlanningActivity.this);

        // Set GUI element parameters
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setHorizontalGravity(LinearLayout.TEXT_ALIGNMENT_CENTER);
        linearLayout.getDividerDrawable();

       /* // Load stored catalogue if exists
        if (isThereStoredCatalogue()){
            JsonArray catalogueJsonArray = gson.fromJson(settings.getString("planning", "{}"), JsonArray.class);
            addCatalogueJsonArrayToRecyclerView(recyclerView, catalogueJsonArray);
        }*/

        cancelUpdate.setOnClickListener(v -> cancelUpdate());

        catalogueListButton.setOnClickListener(v -> {

            String token = settings.getString("token", "");
            String bearerToken = getString(R.string.bearer_token) + " " + token;
            linearLayout.removeAllViews();

            myAPI = retrofit.create(FinanceBackend.class);
            compositeDisposable.add(myAPI.getPlanning(bearerToken)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(response -> {
                        if (response.code() >= 200 && response.code() < 300) {
                            JsonArray allUsersJsonArray = response.body().getAsJsonArray("planning");
                            settings.edit().putString("planning", gson.toJson(allUsersJsonArray)).apply();
                            addCatalogueJsonArrayToRecyclerView(recyclerView, allUsersJsonArray);
                            User.storeTokenIfChanged(this, bearerToken, response.headers().get("Authorization"));
                            Toast.makeText(PlanningActivity.this, "Planning list retrieve successful.", Toast.LENGTH_LONG).show();
                        } else {
                            Toast.makeText(PlanningActivity.this, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                        }
                    }));
        });

    }

    }