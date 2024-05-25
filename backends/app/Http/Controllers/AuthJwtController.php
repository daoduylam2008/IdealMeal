<?php

namespace App\Http\Controllers;


use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\JwtToken;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthJwtController extends Controller
{
    
    public function register(Request $request){
        $request->validate([
            "name"=> "required|max:255",
            "email"=> "required|email|unique:users,email",
            "password"=> "required|min:8|"
        ]);

        $user = User::create([
            "name"=> $request->name,
            "email"=> $request->email,
            "password"=>  Hash::make($request->password),
        ]);
        return json_encode([
            "msg" => "Created successfully",
            "user" => $user,
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
           
            $token = JwtToken::createToken($user,"2025-10-10");
            return $token;
            
        }
    }
    public function profile(Request $request){
        //
    }
}
