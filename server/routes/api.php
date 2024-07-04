<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\FileDownloader;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthJwtController;
use App\Http\Controllers\MealDaysController;
use App\Http\Controllers\TeachersController;
use App\Http\Controllers\V1\StudentsController;


Route::group(['prefix'=>"v1","namespace"=>"App\Http\Controllers\V1"],function(){
    Route::apiResource('students',StudentsController::class);
});


Route::patch("meal", [MealDaysController::class, "update"]);
Route::get("day",[MealDaysController::class, "show"]);

Route::group([

    'middleware' => 'api',
    'prefix' => 'auth'

], function () {

    Route::post("register", [AuthController::class, "register"]);
    Route::post('login', [AuthController::class,'login']);
    Route::post('logout', [AuthController::class,'logout']);
    Route::post('refresh', [AuthController::class,'refresh']);
    Route::get('me', [AuthController::class,'me']);
    Route::get('profile', [AuthController::class,'profile']);
    Route::post('pass', [AuthController::class,'updatePassword']);
    Route::post('email', [AuthController::class,'updateEmail']);
    Route::post('phone', [AuthController::class,'updatePhone']);
});

Route::group([
    "prefix" => "auth",
], function (){
    Route::post("admin",[AuthController::class,'admin']);
});

Route::group([
    'middleware' => ['web'],
    "prefix" => "auth",
], function () {
    Route::get("test",[AdminController::class,'show']);

    Route::get("exit/{id}",[AdminController::class,'exit']);
});
Route::get("teachers",[TeachersController::class,'show']);
