package com.example.nodejs.loanActivities;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.Toast;

import com.example.nodejs.R;
import com.example.nodejs.retrofit.FinanceBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.example.nodejs.transactionActivities.TransactionAddActivity;
import com.example.nodejs.utils.CatalogueRecycleViewAdapter;
import com.example.nodejs.utils.LoanRecycleViewAdapter;

import java.util.Calendar;
import java.util.Date;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class LoanAddActivity extends AppCompatActivity implements LoanRecycleViewAdapter.ItemClickListener{
    FinanceBackend myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    CatalogueRecycleViewAdapter adapter;
    Date currentDate;

    private void cancelUpdate() {
        Intent myIntent = new Intent(LoanAddActivity.this, FinanceLoanActivity.class);
        LoanAddActivity.this.startActivity(myIntent);
        finish();
    }

    @Override
    public void onItemClick(View view, int position) {
        Toast.makeText(this, "You clicked " + adapter.getItem(position) + " on row number " + position, Toast.LENGTH_SHORT).show();
    }

    @SuppressLint("DefaultLocale")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_loan_add);

        final EditText amount = findViewById(R.id.sellerEditText);
        final Spinner category = findViewById(R.id.categorySpinner);
        final Spinner currency = findViewById(R.id.categorySpinner2);

        String[] categoriesStringArray = getResources().getStringArray(R.array.currency);

        currentDate = Calendar.getInstance().getTime();

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(FinanceBackend.class);

        Button newCatalogueButton = findViewById(R.id.newCatalogueButton);
        final Button cancelCatalogue = findViewById(R.id.cancelCatalogueButton);
        final LinearLayout linearLayout = new LinearLayout(LoanAddActivity.this);

        // Set GUI element parameters
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setHorizontalGravity(LinearLayout.TEXT_ALIGNMENT_CENTER);
        linearLayout.getDividerDrawable();

        cancelCatalogue.setOnClickListener(v -> cancelUpdate());

        newCatalogueButton.setOnClickListener(v -> {
            Integer selectedCategory;
            String selectedCurrency;

                selectedCategory = category.getSelectedItemPosition() + 1;
                selectedCurrency = categoriesStringArray[currency.getSelectedItemPosition()];
                createCatalogueItem(selectedCategory, amount.getText().toString(), selectedCurrency, currentDate.toString());
        });
    }

    private boolean isFieldsFilled(EditText amount, Spinner category, Spinner currency){
        if (amount.getText().toString().equals("") || category.getSelectedItem().toString().equals("") ||
                currency.getSelectedItem().toString().equals("") ){
            Toast.makeText(LoanAddActivity.this, "Fields cannot be empty!", Toast.LENGTH_LONG).show();
            return false;
        } else {
            return true;
        }
    }

    private void createCatalogueItem(final Integer category, final String amount, final String currency,final String currentDate){
        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(LoanAddActivity.this);
        String token = settings.getString("token", "");
        String bearerToken = getString(R.string.bearer_token) + " " + token;

                            compositeDisposable.add(myAPI.createLoan(token, category, amount, currency, currentDate)
                                    .subscribeOn(Schedulers.io())
                                    .observeOn(AndroidSchedulers.mainThread())
                                    .subscribe(response -> {
                                        if (response.code() >= 200 && response.code() < 300){
                                            Toast.makeText(LoanAddActivity.this, "LoanItem added successfully!", Toast.LENGTH_SHORT).show();
                                        } else {
                                            Toast.makeText(LoanAddActivity.this, "" + response.code(), Toast.LENGTH_SHORT).show();
                                        }
                                    }));
    }
}
