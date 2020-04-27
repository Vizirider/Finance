package com.example.nodejs;

import android.content.SharedPreferences;
import android.location.Address;
import android.location.Geocoder;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.widget.Button;
import android.widget.TextView;

import com.example.nodejs.R;
import com.example.nodejs.GroupsItem;
import com.example.nodejs.retrofit.FinanceBackend;
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

import io.reactivex.disposables.CompositeDisposable;
import retrofit2.Retrofit;

public class PlanningItemViewActivity extends AppCompatActivity implements OnMapReadyCallback {
    FinanceBackend myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    Gson gson = new GsonBuilder().setLenient().create();
    private MapView mapView;
    private GoogleMap gmap;
    private static final String MAP_VIEW_BUNDLE_KEY = "MapViewBundleKey";
    String address;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_groups_item_view);

        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create(FinanceBackend.class);

        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(PlanningItemViewActivity.this);
        final GroupsItem GroupsItem = gson.fromJson(settings.getString("Planning","{}"), GroupsItem.class);
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

        sellerTextView.setText(GroupsItem.getIncome_outcome());
        categoryTextView.setText(GroupsItem.getCurrency());
        siteTextView.setText(GroupsItem.getCategory_name());
        addressTextView.setText(GroupsItem.getDate());

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
}
