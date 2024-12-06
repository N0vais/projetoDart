<?php

use App\Http\Controllers\BarberController;
use App\Http\Controllers\UsersController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
      Route::get('/dashboard', [BarberController::class, 'index'])->name('dashboard');
  });
