<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Http\Controllers\JwtToken;

class MealDaysMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        if ($request->bearerToken() == null) {
            abort(401);
        }
        else if ($payload = JwtToken::attempt($request->bearerToken())){
            return $next($request);  
        }
         else {
            abort(401);
         }
        
        
    }
}
