package com.example.nodejs.retrofit;

import com.google.gson.JsonObject;

import io.reactivex.Observable;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Response;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.HTTP;
import retrofit2.http.Header;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;
import retrofit2.http.Path;

public interface FinanceBackend {
    @FormUrlEncoded
    @POST("/api/v1/register")
    Observable<Response<ResponseBody>> registerUser(@Field("email") String email,
                            @Field("name") String name,
                            @Field("password") String password,
                            @Field("defaultSite") String default_site);

    @FormUrlEncoded
    @POST("/api/v1/login")
    Observable<Response<JsonObject>> loginUser(@Field("email") String email,
                                    @Field("password") String password);

    @FormUrlEncoded
    @HTTP(method = "DELETE", path = "/api/v1/user/", hasBody = true)
    Observable<Response<ResponseBody>> deleteUser(@Header("Authorization") String token,
                                                  @Field("email") String email,
                                                  @Field("password") String password);

    @HTTP(method = "DELETE", path = "/api/v1/user/{id}", hasBody = true)
    Observable<Response<ResponseBody>> adminDeleteUser(@Header("Authorization") String token,
                                                       @Path("id") Integer id);

    @FormUrlEncoded
    @HTTP(method = "PUT", path = "/api/v1/user", hasBody = true)
    Observable<Response<ResponseBody>> updateUser(@Header("Authorization") String token,
                                                  @Field("name")String name,
                                                  @Field("email") String email,
                                                  @Field("password") String password,
                                                  @Field("defaultSite") String default_site);

    @FormUrlEncoded
    @HTTP(method = "PUT", path = "/api/v1/user/{id}", hasBody = true)
    Observable<Response<ResponseBody>> adminUpdateUser(@Header("Authorization") String token,
                                                  @Path("id") Integer id,
                                                  @Field("name") String name,
                                                  @Field("email") String email,
                                                  @Field("password") String password,
                                                  @Field("defaultSite") String default_site);

    @GET("/api/v1/transaction")
    Observable<Response<JsonObject>> getTransaction(@Header("Authorization") String token );

    @GET("/api/v1/sumtransaction")
    Observable<Response<JsonObject>> sumTransaction(@Header("Authorization") String token );

    @FormUrlEncoded
    @POST("/api/v1/transaction")
    Observable<Response<JsonObject>> createTransaction(@Header("Authorization") String token,
                                                       @Field("product_category") Integer category,
                                                       @Field("amount") String income_outcome,
                                                       @Field("currency") String currency,
                                                       @Field("Date") String Date);
    @GET("/api/v1/groups")
    Observable<Response<JsonObject>> getGroups(@Header("Authorization") String token );

    @FormUrlEncoded
    @POST("/api/v1/groups")
    Observable<Response<JsonObject>> createGroups(@Header("Authorization") String token,
                                                       @Field("product_category") Integer category,
                                                       @Field("amount") String income_outcome,
                                                       @Field("currency") String currency,
                                                       @Field("Date") String Date);

    @GET("/api/v1/planning")
    Observable<Response<JsonObject>> getPlanning(@Header("Authorization") String token );

    @FormUrlEncoded
    @POST("/api/v1/planning")
    Observable<Response<JsonObject>> createPlanning(@Header("Authorization") String token,
                                                  @Field("currency") String currency,
                                                  @Field("salary") Integer salary,
                                                  @Field("fix_outcome") Integer fix_outcome,
                                                  @Field("cost") Integer cost,
                                                  @Field("long_term") Integer long_term,
                                                  @Field("short_term") Integer short_term);


    @GET("/api/v1/loan")
    Observable<Response<JsonObject>> getLoan(@Header("Authorization") String token );

    @GET("/api/v1/sumloan")
    Observable<Response<JsonObject>> sumLoan(@Header("Authorization") String token );

    @FormUrlEncoded
    @POST("/api/v1/loan")
    Observable<Response<JsonObject>> createLoan(@Header("Authorization") String token,
                                                       @Field("product_category") Integer category,
                                                       @Field("amount") String income_outcome,
                                                       @Field("currency") String currency,
                                                       @Field("Date") String Date);

    @FormUrlEncoded
    @POST("/api/v1/catalogue")
    Observable<Response<ResponseBody>> createCatalogueItem(@Header("Authorization") String token,
                                                         @Field("seller")String seller,
                                                         @Field("category") String category,
                                                         @Field("site") String site,
                                                         @Field("address")String address,
                                                         @Field("discountRate") String discountRate,
                                                         @Field("validFrom") String validFrom,
                                                         @Field("validTill")String validTill,
                                                         @Field("active") Boolean active,
                                                         @Field("url") String url,
                                                         @Field("description") String description);

    @HTTP(method = "DELETE", path = "/api/v1/catalogue/items/{id}", hasBody = true)
    Observable<Response<ResponseBody>> deleteCatalogueItem(@Header("Authorization") String token,
                                                           @Path("id") Integer id);

    @FormUrlEncoded
    @POST("/api/v1/catalogue/search")
    Observable<Response<JsonObject>> getCatalogueElementSearch(@Header("Authorization") String token,
                                                              @Field("siteIds") String[] siteIds,
                                                              @Field("categoryIds") String[] categoryIds );

    @GET("/api/v1/user/list")
    Observable<Response<JsonObject>> adminListAllUsers(@Header("Authorization") String token);


    @FormUrlEncoded
    @POST("/api/v1/user/reset-password-with-email")
    Observable<Response<ResponseBody>> resetPassword(@Field("email") String email);

    @FormUrlEncoded
    @POST("/api/v1/user/reset-password/{resetToken}")
    Observable<Response<ResponseBody>> setNewPassword(@Path("resetToken") String resetToken,
                                                  @Field("password") String password);

    @GET("/api/v1/user/reset-password/{resetToken}")
    Observable<Response<ResponseBody>> checkTokenAvailability(@Path("resetToken") String resetToken);

    @GET("/api/v1/user/picture")
    Observable<Response<ResponseBody>> getProfilePicture(@Header("Authorization") String token);

    @Multipart
    @POST("/api/v1/user/picture")
    Observable<Response<ResponseBody>> uploadProfilePicture(@Header("Authorization") String token,
                                                            @Part("picture\"; filename=\"profilePicture\"") RequestBody file);
    @POST("/api/v1/user/picture")
    Observable<Response<ResponseBody>> removeProfilePicture(@Header("Authorization") String token);


}
