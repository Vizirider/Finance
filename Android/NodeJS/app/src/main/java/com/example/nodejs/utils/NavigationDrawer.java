package com.example.nodejs.utils;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.drawable.Drawable;
import android.preference.PreferenceManager;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.example.nodejs.statistics.ChartView;
import com.example.nodejs.adminActivities.ListAllUsersActivity;
import com.example.nodejs.catalogueActivities.DiscountCatalogueActivity;
import com.example.nodejs.LoginActivity;
import com.example.nodejs.R;
import com.example.nodejs.groupsActivities.FinanceGroupsActivity;
import com.example.nodejs.groupsActivities.GroupsAddActivity;
import com.example.nodejs.loanActivities.FinanceLoanActivity;
import com.example.nodejs.retrofit.FinanceBackend;
import com.example.nodejs.retrofit.RetrofitClient;
import com.example.nodejs.User;
import com.example.nodejs.statistics.FinanceStatisticsActivity;
import com.example.nodejs.transactionActivities.FinanceTransactionActivity;
import com.example.nodejs.userActivities.SetProfilePictureActivity;
import com.example.nodejs.userActivities.UpdateActivity;
import com.github.javiersantos.materialstyleddialogs.MaterialStyledDialog;
import com.mikepenz.materialdrawer.AccountHeader;
import com.mikepenz.materialdrawer.AccountHeaderBuilder;
import com.mikepenz.materialdrawer.Drawer;
import com.mikepenz.materialdrawer.DrawerBuilder;
import com.mikepenz.materialdrawer.model.DividerDrawerItem;
import com.mikepenz.materialdrawer.model.PrimaryDrawerItem;
import com.mikepenz.materialdrawer.model.ProfileDrawerItem;
import com.mikepenz.materialdrawer.model.SecondaryDrawerItem;

import java.io.File;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

import static android.content.Context.MODE_PRIVATE;

public class NavigationDrawer {

    private Activity callingActivity;
    private Drawable profilePic;
    private User user;
    private Drawer drawer;
    private String token;

    public NavigationDrawer(Activity callingActivity, Drawable profilePic, User user, String token) {
        this.callingActivity = callingActivity;
        this.profilePic = profilePic;
        this.user = user;
        this.token = token;
    }

    private void startActivity(Class activityClass) {
        Intent myIntent = new Intent(callingActivity, activityClass);
        callingActivity.startActivityForResult(myIntent, 200);
    }

    private void removeUserData(){
        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(callingActivity);
        File file = new File(callingActivity.getApplicationContext().getDir(callingActivity.getResources().getString(R.string.app_name), MODE_PRIVATE), "profile_pic.jpg");

        settings.edit().remove("token").apply();
        settings.edit().remove("user").apply();
        settings.edit().remove("filterResult").apply();
        settings.edit().remove("locale").apply();
        settings.edit().remove("prev_locale").apply();
        file.delete();
    }

    private void logout() {
        Intent myIntent = new Intent(callingActivity, LoginActivity.class);
        callingActivity.startActivity(myIntent);
        removeUserData();
        callingActivity.finish();
    }

    private void deleteUser(final String email, final String token){
        final View enter_name_view = LayoutInflater.from(callingActivity).inflate(R.layout.delete_user_layout, null);

        final String bearerToken = callingActivity.getString(R.string.bearer_token) + " " + token;

        Retrofit retrofit = RetrofitClient.getInstance();
        FinanceBackend myAPI = retrofit.create(FinanceBackend.class);
        CompositeDisposable compositeDisposable = new CompositeDisposable();

        new MaterialStyledDialog.Builder(callingActivity)
                .setTitle(R.string.enter_password)
                .setDescription(R.string.one_more_step)
                .setCustomView(enter_name_view)
                .setNegativeText(R.string.cancel)
                .onNegative((dialog, which) -> {
                    dialog.dismiss();
                })
                .setPositiveText(R.string.delete)
                .onPositive((dialog, which) -> {
                    EditText deletePwText = enter_name_view.findViewById(R.id.deletePwText);
                    compositeDisposable.add(myAPI.deleteUser(bearerToken, email, deletePwText.getText().toString())
                            .subscribeOn(Schedulers.io())
                            .observeOn(AndroidSchedulers.mainThread())
                            .subscribe(response -> {
                                if (response.code() >= 200 && response.code() < 300) {
                                    Toast.makeText(callingActivity, callingActivity.getString(R.string.deletion_successful), Toast.LENGTH_LONG).show();
                                    logout();
                                } else {
                                    Toast.makeText(callingActivity, response.code() + " " + response.errorBody().string(), Toast.LENGTH_LONG).show();
                                }
                            }));
                }).show();
    }

    public Drawer createNavigationDrawer() {
        // Create the AccountHeader
        String name = user.getName();
        if (user.getIs_admin() == 1){
            name = name + " (Admin)";
        }

        AccountHeader headerResult = new AccountHeaderBuilder()
                .withActivity(callingActivity)
                .addProfiles(
                        new ProfileDrawerItem().withName(name).withEmail(user.getEmail()).withIcon(profilePic)
                )
                .withOnAccountHeaderListener((view, profile, currentProfile) -> {
                    // open upload dialog here
                    startActivity(SetProfilePictureActivity.class);
                    return false;
                })
                .build();

        //create the drawer and remember the `Drawer` drawer object
        drawer = new DrawerBuilder()
                .withActivity(callingActivity)
                .withAccountHeader(headerResult)
                .addDrawerItems(
                        new PrimaryDrawerItem().withIdentifier(1).withName(R.string.main_menu),
                        new DividerDrawerItem(),
                        new PrimaryDrawerItem().withIdentifier(2).withName(R.string.discount_catalogue),
                        new PrimaryDrawerItem().withIdentifier(3).withName(R.string.finance_transaction),
                        new PrimaryDrawerItem().withIdentifier(4).withName(R.string.finance_loan),
                        new PrimaryDrawerItem().withIdentifier(5).withName(R.string.statistic),
                        new PrimaryDrawerItem().withIdentifier(6).withName(R.string.groups)
                )
                .withOnDrawerItemClickListener((view, position, drawerItem) -> {
                    // do something with the clicked item
                    switch ((int) drawerItem.getIdentifier()){
                        case 1:
                            if (callingActivity.getLocalClassName().equals("HomeActivity")){
                                drawer.setSelection(-1);
                                break;
                            } else {
                                callingActivity.finish();
                                break;
                            }
                        case 2:
                            if (callingActivity.getLocalClassName().equals("DiscountCatalogueActivity")){
                                drawer.setSelection(-1);
                                break;
                            } else {
                                startActivity(DiscountCatalogueActivity.class);
                                drawer.closeDrawer();
                                break;
                            }
                        case 3:
                            if (callingActivity.getLocalClassName().equals("FinanceTransactionActivity")){
                                drawer.setSelection(-1);
                                break;
                            } else {
                                startActivity(FinanceTransactionActivity.class);
                                drawer.closeDrawer();
                                break;
                            }
                        case 4:
                            if (callingActivity.getLocalClassName().equals("FinanceLoanActivity")){
                                drawer.setSelection(-1);
                                break;
                            } else {
                                startActivity(FinanceLoanActivity.class);
                                drawer.closeDrawer();
                                break;
                            }
                        case 5:
                            if (callingActivity.getLocalClassName().equals("FinanceStatisticsActivity")){
                                drawer.setSelection(-1);
                                break;
                            } else {
                                startActivity(FinanceStatisticsActivity.class);
                                drawer.closeDrawer();
                                break;
                            }
                        case 6:
                            if (callingActivity.getLocalClassName().equals("FinanceGroupsActivity")){
                                drawer.setSelection(-1);
                                break;
                            } else {
                                startActivity(FinanceGroupsActivity.class);
                                drawer.closeDrawer();
                                break;
                            }
                        case 7:
                            startActivity(ListAllUsersActivity.class);
                            drawer.closeDrawer();
                            break;

                        case 8:
                            startActivity(UpdateActivity.class);
                            drawer.closeDrawer();
                            break;
                        case 9:
                            deleteUser(user.getEmail(), token);
                            break;

                        case 10:
                            logout();
                            break;
                    }

                    return true;
                })
                .withSelectedItem(-1)
                .build();

        if (user.getIs_admin() == 1){
            PrimaryDrawerItem listAllUsersDrawerItem = new PrimaryDrawerItem().withIdentifier(7).withName("(Admin) List all users");
            drawer.addItem(listAllUsersDrawerItem);
        }

        SecondaryDrawerItem updateUserDrawerItem = new SecondaryDrawerItem().withIdentifier(8).withName(callingActivity.getString(R.string.update_info));
        drawer.addStickyFooterItem(updateUserDrawerItem);

        SecondaryDrawerItem deleteUserDrawerItem = new SecondaryDrawerItem().withIdentifier(9).withName(callingActivity.getString(R.string.delete_user));
        drawer.addStickyFooterItem(deleteUserDrawerItem);

        drawer.addStickyFooterItem(new DividerDrawerItem());

        SecondaryDrawerItem logoutDrawerItem = new SecondaryDrawerItem().withIdentifier(10).withName(callingActivity.getString(R.string.logout));
        drawer.addStickyFooterItem(logoutDrawerItem);

        return drawer;
    }
}
