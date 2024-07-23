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
        $token= $request->bearerToken();
        

        $adminToken = DB::table("admin_token")?->where("token","=",$token);

        if ($adminToken->exists() == false){
            return response()->json(['msg'=>"Unauthenticated"],403);
        }
        if ($adminToken->first()->expired_at < strtotime("now")){
            return response()->json(['msg'=>"Token expired"],403);
        }        
        if($adminToken->first()->ip_address != $request->ip()){
            return response()->json(['msg'=>"Invalid IP Address"],401);
        }
        

        return $next($request);
    }
    
}
