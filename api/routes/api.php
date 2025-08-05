<?php

use App\Http\Controllers\Api\AddressController;
use App\Http\Controllers\Api\AdvertiseController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\BrandController;
use App\Http\Controllers\Api\CartController;
use App\Http\Controllers\Api\CartItemController;
use App\Http\Controllers\Api\CheckoutController;
use App\Http\Controllers\Api\CommuneController;
use App\Http\Controllers\Api\DistrictController;
use App\Http\Controllers\Api\FavoriteController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\ProvinceController;

// login
Route::post('login', [AuthController::class, 'login']);
// register
Route::post('register', [AuthController::class, 'register']);
// send email to get code verify for reset password
Route::post('send-password-reset-code', [AuthController::class, 'sendPasswordResetCode']);
// verfiy code from email before reset password
Route::post('verify-password-code', [AuthController::class, 'verifyPasswordCode']);
// reset password
Route::post('reset-password', [AuthController::class, 'resetPassword']);


// get all users
Route::get('users', [AuthController::class, 'index']);
// advertise
Route::get('advertisements', [AdvertiseController::class, 'index']);
// get categories
Route::apiResource('categories', CategoryController::class);
// get brands
Route::get('brands', [BrandController::class, 'index']);
// get products
Route::get('products', [ProductController::class, 'index']);
// get products by category
Route::get('products/by/category/{categoryId}', [ProductController::class, 'filterByCategory']);
// search products
Route::get('products/search', [ProductController::class, 'searchProducts']);

// middleware for check authorization
Route::middleware('auth:sanctum')->group(function () {
    // get user by owner
    Route::get('get-own-user', [AuthController::class, 'getOwnUser']);
    // logout
    Route::post('logout', [AuthController::class, 'logout']);
    // refresh token
    Route::post('refresh', [AuthController::class, 'refresh']);
    Route::get('me', [AuthController::class, 'me']);
    // update profile
    Route::post('update-profile', [AuthController::class, 'updateProfile']);
    Route::post('upload/profile/photo', [AuthController::class, 'uploadPhoto']);
    // favorite products
    Route::post('favorites/toggle', [FavoriteController::class, 'toggleFavorite']);
    Route::get('favorites', [FavoriteController::class, 'getFavorites']);
    Route::get('favorites/search', [FavoriteController::class, 'searchOwnFavorites']);
    Route::get('favorite/categories', [FavoriteController::class, 'getCategoryFavorite']);
    Route::get('favorites/filter/by/category/{categoryId}', [FavoriteController::class, 'filterFavoriteByCategory']);

    // addresses
    Route::get('provinces', [ProvinceController::class, 'index']);
    Route::get('districts', [DistrictController::class, 'index']);
    Route::get('communes', [CommuneController::class, 'index']);
    Route::resource('addresses', AddressController::class);
    Route::get('address/get', [AddressController::class, 'index']);
    Route::post('address/store', [AddressController::class, 'store']);
    Route::post('address/update/{id}', [AddressController::class, 'update']);
    Route::delete('address/delete/{id}', [AddressController::class, 'destroy']);

    // cart
    Route::get('cart/view', [CartController::class, 'viewCart']);
    Route::post('cart/add', [CartController::class, 'addToCart']);
    Route::delete('cart/remove/{productId}', [CartController::class, 'removeCartItemByProductId']);

    // cart items
    Route::get('cart/items/{cartId}/view', [CartItemController::class, 'getCartItems']);
    Route::post('cart/items/add', [CartItemController::class, 'storeCartItem']);
    Route::post('cart/items/{id}/update', [CartItemController::class, 'updateCartItem']);
    Route::delete('cart/items/{id}/delete', [CartItemController::class, 'removeCartItem']);

    // checkout
    Route::post('checkout', [CheckoutController::class, 'checkout']);

    // orders
    Route::get('orders', [OrderController::class, 'index']);
    Route::get('/checkout/success', [CheckoutController::class, 'checkoutSuccess'])->name('checkout.success');
    Route::get('/checkout/cancel', [CheckoutController::class, 'checkoutCancel'])->name('checkout.cancel');
});
