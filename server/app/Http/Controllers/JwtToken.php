<?php

namespace App\Http\Controllers;


use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use DB;



class JwtToken{

    private static $secret_key = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImZzZnNmc2ZAZ21haWwuY29tIiwibmFtZSI6ImZzZnMiLCJzdHVkZW50X2lkIjoxMDAxMDcsImV4cCI6MTcxOTgyNzYxMX0.Dw5Zlo9n1OlfamGoVkJyCRapRlH6urY1VUOKFz20O7I";


    public static function createToken($user,$time){
        return json_encode(
            [
            "jwt" => JWT::encode($user,static::$secret_key,"HS256"),
            "refresh_token" => JWT::encode(["unique"=>uniqid("",true)],static::$secret_key,"HS256"),
            "token_type"=> "bearer",
            "expired_in"=> $time,
            ]
        );
    }


    public static function check($jwt){
        if (empty($jwt)){
            abort(401);
        }
        else if ($decoded =  JWT::decode($jwt, new Key(static::$secret_key,'HS256'))){
            return $decoded->student_id;
        }
        else{
            abort(401);
        }
       
    }
   

}