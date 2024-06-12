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
        if ($jwt == NULL){
            abort(401);
        }
        else if ($decoded =  JWT::decode($jwt, new Key("helllllloooooooooo",'HS256'))){
            return $decoded->student_id;
        }
        else{
            abort(401);
        }
    }
}