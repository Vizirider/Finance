package com.example.nodejs.catalogueActivities;

import android.content.SharedPreferences;
import android.location.Address;
import android.location.Geocoder;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.example.nodejs.CatalogueItem;
import com.example.nodejs.R;
import com.example.nodejs.retrofit.ITSHBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.IOException;
import java.util.List;
import java.util.Locale;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class CatalogueItemViewActivity extends AppCompatActivity implements OnMapReadyCallback {
    ITSHBackend myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    Gson gson = new GsonBuilder().setLenient().create();
    private MapView mapView;
    private GoogleMap gmap;
    private static final String MAP_VIEW_BUNDLE_KEY = "MapViewBundleKey";
    String address;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_catalogue_item_view);

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(ITSHBackend.class);

        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(CatalogueItemViewActivity.this);
        final CatalogueItem catalogueItem = gson.fromJson(settings.getString("catalogueItem","{}"), CatalogueItem.class);
        String token = settings.getString("token", " ");

        TextView sellerTextView = findViewById(R.id.sellerTextView);
        TextView categoryTextView = findViewById(R.id.categoryTextView);
        TextView siteTextView = findViewById(R.id.siteTextView);
        TextView addressTextView = findViewById(R.id.addressTextView);
        TextView discountTextView = findViewById(R.id.discountTextView);
        TextView urlTextView = findViewById(R.id.urlTextView);
        TextView descriptionTextView = findViewById(R.id.descriptionTextView);
        Button deactivateCatalogueItemButton = findViewById(R.id.deactivateCatalogueItemButton);
        Button cancelCatalogueItemButton = findViewById(R.id.cancelCatalogueItemButton);

        sellerTextView.setText(catalogueItem.getSeller());
        categoryTextView.setText(catalogueItem.getCategory_id());
        siteTextView.setText(catalogueItem.getSite_id());
        addressTextView.setText(catalogueItem.getAddress());
        discountTextView.setText(catalogueItem.getDiscount_rate());
        urlTextView.setText(catalogueItem.getUrl());
        descriptionTextView.setText(catalogueItem.getDescription());

        address = catalogueItem.getAddress();

        deactivateCatalogueItemButton.setOnClickListener(v -> deactivateCatalogueItem(catalogueItem, token));

        cancelCatalogueItemButton.setOnClickListener(v -> finish());

        Bundle mapViewBundle = null;
        if (savedInstanceState != null) {
            mapViewBundle = savedInstanceState.getBundle(MAP_VIEW_BUNDLE_KEY);
        }

        mapView = findViewById(R.id.mapView);
        mapView.onCreate(mapViewBundle);
        mapView.getMapAsync(this);
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);

        Bundle mapViewBundle = outState.getBundle(MAP_VIEW_BUNDLE_KEY);
        if (mapViewBundle == null) {
            mapViewBundle = new Bundle();
            outState.putBundle(MAP_VIEW_BUNDLE_KEY, mapViewBundle);
        }

        mapView.onSaveInstanceState(mapViewBundle);
    }
    @Override
    protected void onResume() {
        super.onResume();
        mapView.onResume();
    }

    @Override
    protected void onStart() {
        super.onStart();
        mapView.onStart();
    }

    @Override
    protected void onStop() {
        super.onStop();
        mapView.onStop();
    }
    @Override
    protected void onPause() {
        mapView.onPause();
        super.onPause();
    }
    @Override
    protected void onDestroy() {
        mapView.onDestroy();
        super.onDestroy();
    }
    @Override
    public void onLowMemory() {
        super.onLowMemory();
        mapView.onLowMemory();
    }
    @Override
    public void onMapReady(GoogleMap googleMap) {
        gmap = googleMap;
        gmap.setMinZoomPreference(12);
        LatLng location = getLatLongFromAddress(address);
        MarkerOptions markerOptions = new MarkerOptions();
        markerOptions.position(location);
        gmap.addMarker(markerOptions);
        gmap.getUiSettings().setScrollGesturesEnabled(false);
        gmap.moveCamera(CameraUpdateFactory.newLatLng(location));
        gmap.animateCamera(CameraUpdateFactory.zoomTo(15.0f));
    }

    private LatLng getLatLongFromAddress(String address) {
        double lat = 0.0, lng = 0.0;
        Geocoder geoCoder = new Geocoder(this, Locale.getDefault());

        try {
            List<Address> addressList = geoCoder.getFromLocationName(address, 1);
            if (addressList.size() > 0) {
                lat = addressList.get(0).getLatitude();
                lng = addressList.get(0).getLongitude();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return new LatLng(lat, lng);
    }

    public void deactivateCatalogueItem(CatalogueItem catalogueItem, String token){
        String bearerToken = "Bearer" + " " + token;

        compositeDisposable.add(myAPI.deleteCatalogueItem(bearerToken, catalogueItem.getId())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(response -> {
                    if(response.code() >= 200 && response.code() < 300) {
                        Toast.makeText(CatalogueItemViewActivity.this, "Catalogue item successfully deactivated" , Toast.LENGTH_LONG).show();
                        finish();
                    } else {
                        Toast.makeText(CatalogueItemViewActivity.this,  response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                    }
                }));
    }
}
