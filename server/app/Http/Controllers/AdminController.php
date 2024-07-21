<?php

namespace App\Http\Controllers;

use DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class AdminController extends Controller
{



    public function register(){
        $validated = request(['email','password','name']);
        DB::table("admins")->insert(['name' => $validated['name'],"email" =>$validated['email'],"password" =>Hash::make($validated['password'])]);
        return response()->json([
            "msg" => "Registered successfully",
        ]);
    }
    public function show (Request $request){
        $ip_address = $request->ip();

        $email = DB::table('admin_token')->where('ip_address','=',$ip_address)->first()->email;
        $userName = DB::table('admins')->where('email','=',$email)->first()->name;

        return response()->json([
            'email' => $email,
            'userName' => $userName,
        ]);
        
    }
}
