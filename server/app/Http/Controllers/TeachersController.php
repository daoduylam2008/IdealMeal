<?php

namespace App\Http\Controllers;

use App\Models\Teachers;
use Illuminate\Http\Request;
use App\Http\Resources\TeachersResource;

class TeachersController extends Controller
{
    public function show(Request $request){
        
        return  TeachersResource::collection(Teachers::all());
        
    }
   

}
