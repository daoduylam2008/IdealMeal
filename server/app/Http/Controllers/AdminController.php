<?php

namespace App\Http\Controllers;

use DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class AdminController extends Controller
{


    /***
     * 
     *  void randomCharacter
     * 
     */

     private function randomCharacter(){
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $randomString = '';
        for ($i = 0; $i < 30; $i++) {
            $randomString.= $characters[rand(0, strlen($characters) - 1)];
        }
        return $randomString;
    }

     /**
     * Show the profile for the given user.
     */
    public function show(Request $request) 
    {
        $deviceId= $this->randomCharacter();

        $request->session()->put($deviceId,"ideal meal"); 

        return response()->json($deviceId);

        // $request->session()->flush();         
 
    }
    public function exit($id,Request $request){
        $request->session()->forget($id);
        return response()->json([
            "msg" => "Logged out successfully",
        ]);
    }

    public function register(){
        $validated = request(['email','password','name']);
        DB::table("admins")->insert(['name' => $validated['name'],"email" =>$validated['email'],"password" =>Hash::make($validated['password'])]);
        return response()->json([
            "msg" => "Registered successfully",
        ]);
    }
    
}
