<?php

namespace App\Http\Middleware;

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
        if ($request->bearerToken() == null){
            abort(401);
        }
        
        else if(JwtToken::check($request->bearerToken())){
            return $next($request);
        } 
        else{
            abort(401);
        }
        
        
        
    }
}
