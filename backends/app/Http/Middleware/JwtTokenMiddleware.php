<?php

namespace App\Http\Middleware;

use DB;
use Closure;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\JwtToken;
use Symfony\Component\HttpFoundation\Response;


class JwtTokenMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
       
        if($payload = JwtToken::attempt($request->bearerToken())){
            // print_r($user->room_id);
            // $result = [];
            // $result["student_id"] = $payload[2];
            
            $result = [];
            $ArrayPayload = (array) $payload;
            $student_id = $ArrayPayload["student_id"];
            $informations = User::find($student_id)->students->where("student_id","=",$student_id)->first();
            $result["student_id"] = $student_id;
            $result["fullName"] = $informations->name;
            $result["birth"] = $informations->birth;
            $result["phoneNumber"] = $informations->phone;
            print_r($result);
        } 

        return $next($request);
    }
}
