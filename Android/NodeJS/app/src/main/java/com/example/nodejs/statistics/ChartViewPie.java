package com.example.nodejs.statistics;

import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.anychart.chart.common.dataentry.DataEntry;
import com.anychart.chart.common.dataentry.ValueDataEntry;
import com.example.nodejs.R;
import com.example.nodejs.User;
import com.github.mikephil.charting.charts.PieChart;
import com.github.mikephil.charting.data.BarData;
import com.github.mikephil.charting.data.BarDataSet;
import com.github.mikephil.charting.data.BarEntry;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.PieData;
import com.github.mikephil.charting.data.PieDataSet;
import com.github.mikephil.charting.formatter.PercentFormatter;
import com.github.mikephil.charting.utils.ColorTemplate;
import com.example.nodejs.retrofit.FinanceBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import java.util.ArrayList;
import java.util.List;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class ChartViewPie extends AppCompatActivity {

    FinanceBackend myAPI;
    Gson gson = new GsonBuilder().setLenient().create();
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.fragment_chart_pie);
        PieChart pieChart = findViewById(R.id.piechart);

        ArrayList NoOfEmp = new ArrayList();

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(FinanceBackend.class);
        final SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(ChartViewPie.this);
        final LinearLayout linearLayout = new LinearLayout(ChartViewPie.this);


        String token = settings.getString("token", "");
        String bearerToken = getString(R.string.bearer_token) + " " + token;
        linearLayout.removeAllViews();

        myAPI = retrofit.create(FinanceBackend.class);
        compositeDisposable.add(myAPI.getTransaction(bearerToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(response -> {
                    if (response.code() >= 200 && response.code() < 300) {
                        JsonArray allUsersJsonArray = response.body().getAsJsonArray("transaction");
                        settings.edit().putString("transaction", gson.toJson(allUsersJsonArray)).apply();
                        User.storeTokenIfChanged(this, bearerToken, response.headers().get("Authorization"));


                        List<Integer> income_outcome = new ArrayList<Integer>();
                        List<String> date = new ArrayList<>();

                        for(int i = 0; i < allUsersJsonArray.size(); i++){
                            income_outcome.add(Integer.parseInt(allUsersJsonArray.get(i).getAsJsonObject().get("income_outcome").toString().replaceAll("\"", "")));
                            date.add(allUsersJsonArray.get(i).getAsJsonObject().get("category_name").toString().replaceAll("\"", ""));
                        }

                        String[] dateArray = new String[date.size()];
                        dateArray = date.toArray(dateArray);
                        ArrayList year = new ArrayList();

                        Integer[] income_outcomeArray = new Integer[income_outcome.size()];
                        income_outcomeArray = income_outcome.toArray(income_outcomeArray);
                        for(int i = 1; i < allUsersJsonArray.size() -1; i++) {
                            NoOfEmp.add(new BarEntry(income_outcomeArray[i], i));
                            year.add(dateArray[i]);
                        }


                        PieDataSet dataSet = new PieDataSet(NoOfEmp, "Income outcome by category");

                        PieData data = new PieData(year, dataSet);
                        pieChart.setData(data);
                        dataSet.setColors(ColorTemplate.COLORFUL_COLORS);
                        pieChart.animateXY(5000, 5000);


                    } else {
                        Toast.makeText(ChartViewPie.this, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                    }
                }));

    }
}
