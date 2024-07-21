<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\FileDownloader;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\AuthJwtController;
use App\Http\Controllers\MealDaysController;
use App\Http\Controllers\TeachersController;
use App\Http\Controllers\StudentsController;


Route::group(['prefix'=>"auth","namespace"=>"App\Http\Controllers"],function(){
    Route::get("students",[StudentsController::class,"index"])->middleware("token");
    Route::get("info",[StudentsController::class,"info"])->middleware("token");
    Route::post("delete",[StudentsController::class,"destroy"])->middleware("token");
    Route::post("modify",[StudentsController::class,"edit"])->middleware("token");
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
    Route::post("account",[AdminController::class,'register']);
    Route::get("refreshTokenAdmin",[AuthController::class,'refreshTokenAdmin'])->middleware("token");
    Route::get("deleteTokenAdmin",[AuthController::class,'deleteTokenAdmin'])->middleware("token");
    Route::get("check",[AuthController::class,'checkTokenAdmin'])->middleware("token");
    Route::get("show",[AdminController::class,'show'])->middleware("token");
    Route::get("teachers",[TeachersController::class,'show'])->middleware("token");
    Route::post("exchange",[TeachersController::class,'exchange'])->middleware("token");
    Route::post("trash",[TeachersController::class,'trash'])->middleware("token");
    Route::post("edit",[TeachersController::class,'edit'])->middleware("token");
    
});

