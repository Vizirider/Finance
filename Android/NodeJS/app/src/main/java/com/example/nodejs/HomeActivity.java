package com.example.nodejs;

import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.nodejs.retrofit.FinanceBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.example.nodejs.utils.NavigationDrawer;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mikepenz.materialdrawer.Drawer;

import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class HomeActivity extends AppCompatActivity {

    FinanceBackend myAPI;
    Gson gson = new GsonBuilder().setLenient().create();
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    Bitmap profilePicBitmap = null;
    Drawer drawer;
    File file;
    TransactionItem transactionItem;

    private void logout() {
        Intent myIntent = new Intent(HomeActivity.this, LoginActivity.class);
        HomeActivity.this.startActivity(myIntent);
        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(HomeActivity.this);
        settings.edit().remove("token").apply();
        settings.edit().remove("user").apply();
        settings.edit().remove("filterResult").apply();
        settings.edit().remove("locale").apply();
        settings.edit().remove("prev_locale").apply();
        file.delete();
        finish();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(HomeActivity.this);
        final User user = gson.fromJson(settings.getString("user","{}"), User.class);
        final String token = settings.getString("token", "");

        file = new File(getApplicationContext().getDir(getResources().getString(R.string.app_name), MODE_PRIVATE), "profile_pic.jpg");
        if (file.exists()) {
            profilePicBitmap = BitmapFactory.decodeFile(file.getAbsolutePath());
        } else {
            profilePicBitmap = BitmapFactory.decodeResource(this.getResources(), R.drawable.empty_profile);
            getProfilePicture(token);
        }

        Drawable profilePic = new BitmapDrawable(getResources(), cropToSquare(profilePicBitmap));

        drawer = new NavigationDrawer(this, profilePic, user, token).createNavigationDrawer();

        if (user.getName() == null) {
            logout();
        }

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(FinanceBackend.class);

        TextView welcomeText = findViewById(R.id.itemNameTextView);
        ImageView hamburgerImageView = findViewById(R.id.hamburgerImageView);

        List<String> splitName = new ArrayList<>(Arrays.asList(user.getName().split(" ")));

        String nameToDisplay = splitName.get(splitName.size() - 1);

        String bearerToken = getString(R.string.bearer_token) + " " + token;

        myAPI = retrofit.create(FinanceBackend.class);
        compositeDisposable.add(myAPI.sumTransaction(bearerToken)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(response -> {
                    if (response.code() >= 200 && response.code() < 300) {

                        JsonArray allUsersJsonArray = response.body().getAsJsonArray("transaction");
                        JsonObject jsonamount = allUsersJsonArray.get(0).getAsJsonObject();

                        settings.edit().putString("transaction", gson.toJson(allUsersJsonArray)).apply();
                        User.storeTokenIfChanged(this, bearerToken, response.headers().get("Authorization"));
                        String newText = getString(R.string.welcome_onboard) + " " + nameToDisplay +  " balance: " + jsonamount.get("balance").toString().replaceAll("\"", "") +  " HUF !";
                        welcomeText.setText(newText);
                    } else {
                        Toast.makeText(HomeActivity.this, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                    }
                }));

        hamburgerImageView.setOnClickListener(v -> drawer.openDrawer());
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        recreate();
    }

    @Override
    protected void onStart(){
        super.onStart();
        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(HomeActivity.this);
        String currentLocale = getResources().getConfiguration().locale.getLanguage().toLowerCase();
        String storedLocale = settings.getString("locale", "");
        if (!currentLocale.equals(storedLocale)){
            setLocale(storedLocale);
            recreate();
        }
    }

    @Override
    protected void onResume(){
        super.onResume();
        drawer.setSelection(0);
    }

    public void setLocale(String lang){
        Locale myLocale = new Locale(lang);
        Locale.setDefault(myLocale);
        Configuration config = new Configuration();
        config.locale = myLocale;
        Resources resources = getResources();
        resources.updateConfiguration(config, resources.getDisplayMetrics());
    }

    public Bitmap cropToSquare(Bitmap bitmap){
        int width  = bitmap.getWidth();
        int height = bitmap.getHeight();
        int newWidth = (height > width) ? width : height;
        int newHeight = (height > width)? height - ( height - width) : height;
        int cropW = (width - height) / 2;
        cropW = (cropW < 0)? 0: cropW;
        int cropH = (height - width) / 2;
        cropH = (cropH < 0)? 0: cropH;

        return Bitmap.createBitmap(bitmap, cropW, cropH, newWidth, newHeight);
    }

    private void saveToInternalStorage(Bitmap bitmapImage){
        File directory = getApplicationContext().getDir(getResources().getString(R.string.app_name), MODE_PRIVATE);

        File myPath =new File(directory,"profile_pic.jpg");

        FileOutputStream fileOutputStream = null;
        try {
            fileOutputStream = new FileOutputStream(myPath);
            // Use the compress method on the BitMap object to write image to the OutputStream
            Bitmap croppedBitmapImage = cropToSquare(bitmapImage);
            croppedBitmapImage.compress(Bitmap.CompressFormat.PNG, 100, fileOutputStream);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void getProfilePicture(String token){
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(FinanceBackend.class);
        compositeDisposable.add(myAPI.getProfilePicture(token)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe(response -> {
                if (response.code() >= 200 && response.code() < 300) {
                    Bitmap profilePicture = BitmapFactory.decodeStream(response.body().byteStream());
                    if (profilePicture != null){
                        saveToInternalStorage(profilePicture);
                        recreate();
                    }
                } else {
                    Toast.makeText(HomeActivity.this, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                    profilePicBitmap = BitmapFactory.decodeResource(this.getResources(), R.drawable.empty_profile);
                }
            }));
    }
}