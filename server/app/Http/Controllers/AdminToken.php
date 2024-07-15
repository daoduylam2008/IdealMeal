<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class AdminToken extends Controller
{


    /***
     * 
     *  void randomCharacter
     * 
     */

     private static function randomCharacter(){
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $randomString = '';
        for ($i = 0; $i < 40; $i++) {
            $randomString.= $characters[rand(0, strlen($characters) - 1)];
        }
        return $randomString;
    }

    public static function createAdminToken($email){
        $token = static::randomCharacter();
        $expired_at = strtotime("+1 week");

        DB::table("admin_token")->insert([
            "email"=>$email,
            "token"=>$token,
            "expired_at"=>$expired_at,
        ]);

        
        
        return $token;
    }


    
    public static function refreshAdminToken(Request $request){
        $token = static::randomCharacter();
        $expired_at = strtotime("+1 week");

        $email = DB::table("device_id")?->where("ip_address","=",$request->ip())->first()->email;
        DB::table("admin_token")?->where("email","=",$email)->update(['token'=>$token,"expired_at"=>$expired_at]);

        return $token;

    }   
}
