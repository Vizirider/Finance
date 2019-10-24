package com.example.nodejs.adminActivities;

import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.nodejs.R;
import com.example.nodejs.retrofit.ITSHBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.example.nodejs.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class SelectedUserActivity extends AppCompatActivity {

    ITSHBackend myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    Gson gson = new GsonBuilder().setLenient().create();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_selected_user);

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(ITSHBackend.class);

        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(SelectedUserActivity.this);
        final User selectedUser = gson.fromJson(settings.getString("selectedUser","{}"), User.class);
        final String token = settings.getString("token", "");

        TextView userIdTextView = findViewById(R.id.userIdTextView);
        CheckBox userAdminCheckBox = findViewById(R.id.userAdminCheckBox);
        EditText userNameEditText = findViewById(R.id.userNameEditText);
        EditText userEmailEditText = findViewById(R.id.userEmailEditText);
        EditText setPasswordEditText = findViewById(R.id.setPasswordEditText);
        EditText setPasswordAgainEditText = findViewById(R.id.setPasswordAgainEditText);
        Spinner adminUpdateSiteSpinner = findViewById(R.id.adminUpdateSiteSpinner);
        CheckBox userActiveCheckBox = findViewById(R.id.userActiveCheckBox);
        Button cancelSelectedUserActivity = findViewById(R.id.cancelSelectedUserActivity);
        Button adminUpdateButton = findViewById(R.id.adminUpdateButton);
        Button adminUserDeactivateButton = findViewById(R.id.adminUserDeleteButton);

        userIdTextView.setText(selectedUser.getId().toString());
        userNameEditText.setText(selectedUser.getName());
        userEmailEditText.setText(selectedUser.getEmail());

        if (selectedUser.getIs_admin() == 1){
            userAdminCheckBox.setChecked(true);
        }

        if (selectedUser.getIs_active() == 1) {
            userActiveCheckBox.setChecked(true);
        }

        switch (Integer.parseInt(selectedUser.getDefault_site_id())) {
            case 1:
                adminUpdateSiteSpinner.setSelection(0);
                break;
            case 2:
                adminUpdateSiteSpinner.setSelection(1);
                break;
            case 3:
                adminUpdateSiteSpinner.setSelection(2);
                break;
            case 4:
                adminUpdateSiteSpinner.setSelection(3);
                break;
        }

        adminUpdateButton.setOnClickListener(v -> {
            String pw = setPasswordEditText.getText().toString();
            String pwAgain = setPasswordAgainEditText.getText().toString();

            if (pw.equals(pwAgain)){
                adminUpdateData(selectedUser, userNameEditText.getText().toString(), userEmailEditText.getText().toString(), pw, token);
            }
        });

        adminUserDeactivateButton.setOnClickListener(v -> adminDeactivateUser(selectedUser, token));

        cancelSelectedUserActivity.setOnClickListener(v -> finish());

    }

    public void adminUpdateData(final User user, final String name, final String email, String password, String token){
        final String bearerToken = getString(R.string.bearer_token) + " " + token;
        final Spinner adminUpdateSiteSpinner = findViewById(R.id.adminUpdateSiteSpinner);
        final String defaultSite = adminUpdateSiteSpinner.getSelectedItem().toString();

        compositeDisposable.add(myAPI.adminUpdateUser(bearerToken, user.getId(), name, email, password, defaultSite)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(response -> {
                    if(response.code() >= 200 && response.code() < 300) {
                        Toast.makeText(SelectedUserActivity.this, "User successfully updated" , Toast.LENGTH_LONG).show();
                        user.setName(name);
                        user.setEmail(email);
                        finish();
                    } else {
                        Toast.makeText(SelectedUserActivity.this,  response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                    }
                }));
    }

    public void adminDeactivateUser(User user, String token) {
        String bearerToken = "Bearer" + " " + token;

        compositeDisposable.add(myAPI.adminDeleteUser(bearerToken, user.getId())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(response -> {
                    if(response.code() >= 200 && response.code() < 300) {
                        Toast.makeText(SelectedUserActivity.this, response.body().string() , Toast.LENGTH_LONG).show();
                        finish();
                    } else {
                        Toast.makeText(SelectedUserActivity.this,  response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                    }
                }));
    }

}
