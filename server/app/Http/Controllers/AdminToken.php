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
        for ($i = 0; $i < 200; $i++) {
            $randomString.= $characters[rand(0, strlen($characters) - 1)];
        }
        return $randomString;
    }

    public static function createAdminToken($email,Request $request){
        $token = static::randomCharacter();

        DB::table("admin_token")->insert([
            "email"=>$email,
            "user_agent"=> $_SERVER['HTTP_USER_AGENT'],
            "token"=>$token,
            "ip_address"=>$request->ip(),
            "expired_at"=>strtotime('+1 week'),
        ]);

    
        return $token;
    }


    
    public static function refreshAdminToken(Request $request){
        $token = static::randomCharacter();
        $expired_at = strtotime("+1 week");

        DB::table("admin_token")?->where("ip_address","=",$request->ip())->update(['token'=>$token,"expired_at"=>$expired_at]);

        return $token;

    }   
}
