<?php

use App\Http\Controllers\Web\AddressController;
use App\Http\Controllers\Web\AdvertiseController;
use App\Http\Controllers\Web\CategoryController;
use App\Http\Controllers\Web\ProductController;
use App\Http\Controllers\Web\DashboardController;
use App\Http\Controllers\Web\AuthController;
use App\Http\Controllers\Web\BrandController;
use App\Http\Controllers\Web\CommuneController;
use App\Http\Controllers\Web\DistrictController;
use App\Http\Controllers\Web\OrderController;
use App\Http\Controllers\Web\PaymentMethodController;
use App\Http\Controllers\Web\ProvinceController;
use App\Http\Controllers\Web\StockController;
use App\Http\Controllers\Web\UserController;
use Illuminate\Support\Facades\Route;

// Auth routes
Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('/login', [AuthController::class, 'login']);
Route::get('/register', [AuthController::class, 'showRegistrationForm'])->name('register');
Route::post('/register', [AuthController::class, 'register']);
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

// Protected routes
Route::middleware(['App\Http\Middleware\AuthAdmin'])->group(function () {
    Route::get('/', function () {
        return view('index');
    })->name('admin.index');

    // dashboard
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('admin.index');
    // user profile
    Route::get('/setting/view/account', [AuthController::class, 'getCurrentUser'])->name('admin.profile');
    // update psassword
    Route::get('/setting/view/change/password', [AuthController::class, 'changePasswordForm'])->name('admin.change_password');
    Route::post('/setting/send/code', [AuthController::class, 'sendCode'])->name('admin.send_code');
    Route::get('/setting/view/update/password', [AuthController::class, 'updatePasswordForm'])->name('admin.update_password_form');
    Route::post('/setting/update/password/verified', [AuthController::class, 'updatePasswordWithCode'])->name('admin.verify_code.update_password');
    // users
    Route::get('/users', [UserController::class, 'index'])->name('users.index');
    // advertisements
    Route::resource('advertisements', AdvertiseController::class);
    // categories crud
    Route::resource('categories', CategoryController::class);
    // brands crud
    Route::resource('brands', BrandController::class);
    // products crud
    Route::resource('products', ProductController::class);
    // update stock
    Route::get('/update-quantity', [StockController::class, 'showQuantityForm'])->name('update-quantity');
    Route::post('/add-quantity', [StockController::class, 'updateQuantity'])->name('update-quantity.store');
    Route::get('/subtract-quantity', [StockController::class, 'showSubtractForm'])->name('subtract-quantity.form');
    Route::post('/substract-quantity', [StockController::class, 'decreaseQuantity'])->name('update-quantity.decrease');

    // address
    Route::resource('provinces', ProvinceController::class);
    Route::resource('districts', DistrictController::class);
    Route::resource('communes', CommuneController::class);
    Route::resource('addresses', AddressController::class);

    // payment methods
    Route::resource('payment_methods', PaymentMethodController::class);

    // orders
    // Route::resource('orders', OrderController::class);
    Route::get('/orders', [OrderController::class, 'index'])->name('orders.index');
    Route::get('/orders/{order}/edit', [OrderController::class, 'edit'])->name('orders.edit');
    Route::put('/orders/{order}/update', [OrderController::class, 'update'])->name('orders.update');
    Route::get('/orders/{order}/show', [OrderController::class, 'show'])->name('orders.show');
    Route::get('/orders/preparing', [OrderController::class, 'getAllOrdersPreparing'])->name('orders.preparing');
    Route::get('/order/delivering', [OrderController::class, 'getAllOrdersDelivering'])->name('orders.delivering');
    Route::get('/orders/delivered', [OrderController::class, 'getAllOrdersDelivered'])->name('orders.delivered');
    Route::get('/orders/cancelled', [OrderController::class, 'getAllOrdersCancelled'])->name('orders.cancelled');
});
