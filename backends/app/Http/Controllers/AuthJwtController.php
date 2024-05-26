<?php

namespace App\Http\Controllers;


use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\JwtToken;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use DB;

class AuthJwtController extends Controller
{
    
    public function register(Request $request){
        $request->validate([
            "name"=> "required|max:255",
            "email"=> "required|email|unique:users,email",
            "password"=> "required|min:8|",
            "student_id"=> "required|max:6|min:6|unique:users"
        ]);

        DB::table("users")->insert(
            ["name"=>$request->name,"email"=>$request->email, "password"=>Hash::make($request->password),"student_id"=>$request->student_id]
        );
        return json_encode([
            "msg" => "Created successfully",
        ]);
    }
    public function login(Request $request){
        $credentials = $request->validate([
            "email"=>"required",
            "password"=>"required",
        ]);

        if(Auth::attempt($credentials)){
            $associative_array = json_decode(Auth::user(),true);
            $user = [];
            $user["email"] = $associative_array["email"];
            $user["name"] = $associative_array["name"];
            $user["student_id"] = $associative_array["student_id"];
           
            $token = JwtToken::createToken($user,"2025-10-10");
            return $token;
            
        }
    }
    public function profile(Request $request){
        //
    }
}
