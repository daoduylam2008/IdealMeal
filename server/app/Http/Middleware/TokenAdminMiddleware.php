<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use DB;

class TokenAdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $tokens= explode(".",$request->bearerToken());
        
        if(count($tokens)!=2){
            return response()->json(['error'=>'Token invalid'],401);
        }

        $infoDevice = DB::table("device_id")->where("code","=",$tokens[0]);
        $infoAdminToken = DB::table("admin_token")?->where("token","=",$tokens[1]);

        if ($infoDevice->exists() == false || $infoAdminToken->exists() == false){
            return response()->json(['msg'=>"Unauthenticated"],403);
        }
        if ($infoAdminToken->first()->expired_at < strtotime("now")){
            return response()->json(['msg'=>"Token expired"],403);
        }        
        if($infoDevice->first()->email != $infoAdminToken->first()->email){
            return response()->json(['msg'=>"Invalid Token"],401);
        }
        if($infoDevice->first()->ip_address != $request->ip()){
            return response()->json(['msg'=>"Invalid IP Address"],401);
        }
        


        return $next($request);
    }
    
}
