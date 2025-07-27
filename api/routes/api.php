<?php

use App\Http\Controllers\AddressController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BrandController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\CartItemController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\FavoriteController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\PaymentMethodController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProductPhotoController;
use App\Http\Controllers\ProductVarientController;
use Faker\Provider\ar_EG\Payment;
use Illuminate\Support\Facades\Route;

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password/send-code', [AuthController::class, 'sendPasswordResetCode']);
Route::post('/forgot-password/verify-code', [AuthController::class, 'verifyPasswordCode']);
Route::post('/forgot-password/reset', [AuthController::class, 'resetPassword']);

Route::apiResource('categories', CategoryController::class);
Route::apiResource('brands', BrandController::class);
Route::apiResource('products', ProductController::class);
Route::get('products/filter/by/category/{categoryId}', [ProductController::class, 'filterByCategory']);

// Authenticated routes - only accessible with valid token
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'getOwnUser']);
    Route::get('/users', [AuthController::class, 'index']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/refresh', [AuthController::class, 'refresh']);
    Route::apiResource('product-variants', ProductVarientController::class);
    Route::get('/products/{product}/photos', [ProductPhotoController::class, 'index']);
    Route::post('/products/{product}/photos', [ProductPhotoController::class, 'store']);
    Route::delete('/products/{product}/photos', [ProductPhotoController::class, 'destroyByProduct']);
    Route::apiResource('favorites', FavoriteController::class);
    Route::get('/cart', [CartController::class, 'viewCart']);
    Route::post('/cart', [CartController::class, 'addToCart']);
    Route::delete('/cart/{productId}', [CartController::class, 'removeCartItem']);
    Route::get('/cart-items/{cartId}', [CartItemController::class, 'index']);
    Route::post('/cart-items', [CartItemController::class, 'store']);
    Route::put('/cart-items/{id}', [CartItemController::class, 'update']);
    Route::delete('/cart-items/{id}', [CartItemController::class, 'removeCartItem']);
    Route::apiResource('payment-methods', PaymentMethodController::class);
    Route::apiResource('orders', OrderController::class);

    Route::get('/get/provinces', [AddressController::class, 'getProvinces']);
    Route::get('/get/districts/{province_id}', [AddressController::class, 'getDistricts']);
    Route::get('/get/communes/{district_id}', [AddressController::class, 'getCommunes']);
    Route::apiResource('addresses', AddressController::class);
});
