<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AdminController extends Controller
{


    /***
     * 
     *  void randomCharacter
     * 
     */

     private function randomCharacter(){
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!-+=/?.<>,|}]{[!@#$%^&()';
        $randomString = '';
        for ($i = 0; $i < 30; $i++) {
            $randomString.= $characters[rand(0, strlen($characters) - 1)];
        }
        return $randomString;
    }

     /**
     * Show the profile for the given user.
     */
    public function show(Request $request) 
    {
        $deviceId= $this->randomCharacter();

        $request->session()->put($deviceId,""); 

        return response()->json($deviceId);

        // $request->session()->flush();         
 
    }
    
}
