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
    public static function check($jwt){
        $secret_key = "helllllloooooooooo";
        if ($decoded =  JWT::decode($jwt, new Key($secret_key,'HS256'))){
            return true;
        }
        else{
            return false;
        }
    }
    public static function attempt($jwt) {
        $secret_key = "helllllloooooooooo";
        try {
            $decoded =  JWT::decode($jwt, new Key($secret_key,'HS256'));
            
            return $decoded;
        }
        catch (Exception $e) {
            
        }

    }
}