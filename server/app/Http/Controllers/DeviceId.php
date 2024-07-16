<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class DeviceId extends Controller
{

    /***
     * 
     *  void randomCharacter
     * 
     */

     private static function randomCharacter(){
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $randomString = '';
        for ($i = 0; $i < 30; $i++) {
            $randomString.= $characters[rand(0, strlen($characters) - 1)];
        }
        return $randomString;
    }


    public static function createDeviceId($email,Request $request){
        $user_agent =  $_SERVER['HTTP_USER_AGENT'];
        $code = static::randomCharacter();


        DB::table("device_id")->insert([
            "email"=>$email,
            "user_agent"=>$user_agent,
            "code"=>$code,
            "ip_address"=>$request->ip(),
        ]);

        return $code;
    }



    public static function refreshDeviceId(Request $request){
        $user_agent =  $_SERVER['HTTP_USER_AGENT'];
        $code = static::randomCharacter();
        
        DB::table("device_id")?->where("ip_address","=",$request->ip())->update(["code"=>$code]);

        return $code;

    }
}
