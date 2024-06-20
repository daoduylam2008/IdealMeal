<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\FileDownloader;
use App\Http\Controllers\AuthJwtController;
use App\Http\Controllers\MealDaysController;
use App\Http\Controllers\V1\StudentsController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::group(['prefix'=>"v1","namespace"=>"App\Http\Controllers\V1"],function(){
    Route::apiResource('students',StudentsController::class);
});

// Route::post("register",[AuthJwtController::class, "register"]);
// Route::post("login",[AuthJwtController::class, "login"]);
// Route::get("profile",[AuthJwtController::class, "profile"]);
// Route::get("account",[AuthJwtController::class, "account"]);
// Route::post("pass",[AuthJwtController::class, "updatePassword"]);

// Route::post("food",[MealDaysController::class, "store"]);
// ->middleware("meal_days");

// Route::get("file",[FileDownloader::class, "download"]);

// Route::get("days",[MealDaysController::class, "index"]);
Route::get("day/{day}",[MealDaysController::class, "show"]);

Route::group([

    'middleware' => 'api',
    'prefix' => 'auth'

], function ($router) {

    Route::post('login', [AuthController::class,'login']);
    Route::post('logout', [AuthController::class,'logout']);
    Route::post('refresh', [AuthController::class,'refresh']);
    Route::get('me', [AuthController::class,'me']);
    Route::get('profile', [AuthController::class,'profile']);
    Route::post('pass', [AuthController::class,'updatePassword']);
});

