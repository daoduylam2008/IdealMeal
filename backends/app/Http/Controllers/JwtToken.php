<?php

namespace App\Http\Controllers;


use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use DB;



class JwtToken{

    public static function createToken($user,$time){
        $secret_key = "helllllloooooooooo";
        return json_encode(
            [
            "jwt" => JWT::encode($user,$secret_key,"HS256"),
            "token_type"=> "bearer",
            "expired_in"=> strtotime($time)
            ]
        );
    }
    public static function attempt($jwt) {
        $secret_key = "helllllloooooooooo";
        try {
            $decoded =  JWT::decode($jwt, new Key($secret_key,'HS256'));
            $user = DB::table("users")->find($decoded["id"]);
            return true;
        }
        catch (Exception $e) {
            echo 'Caught exception: ',  $e->getMessage(), "\n";
        }

    }
    public static function profile(){
        //
    }
}