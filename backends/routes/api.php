<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthJwtController;
use App\Http\Controllers\MealDaysController;
use App\Http\Controllers\V1\StudentsController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::group(['prefix'=>"v1","namespace"=>"App\Http\Controllers\V1"],function(){
    Route::apiResource('students',StudentsController::class);
});

Route::post("register",[AuthJwtController::class, "register"]);
Route::post("login",[AuthJwtController::class, "login"]);
Route::get("profile",[AuthJwtController::class, "profile"])->middleware("jwtToken");

Route::post("food",[MealDaysController::class, "store"])->middleware("meal_days");

