<?php

use App\Http\Controllers\UsersController;
use App\Http\Controllers\AppointmentsController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/login', [UsersController::class, 'login']);
Route::post('/register', [UsersController::class, 'register']);

Route::middleware('auth:sanctum')->group(function(){
    Route::get('/user', [UsersController::class, 'index']);
    Route::post('/bokin', [AppointmentsController::class, 'store']);
    Route::post('/reviews', [BarberController::class, 'store']);
    Route::get('/agendamento', [AppointmentsController::class, 'index']);
});

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');
