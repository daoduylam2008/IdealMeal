<?php

namespace App\Http\Controllers;


use DB;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\JwtToken;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Http\Requests\UpdateAccountsRequest;

class AuthJwtController extends Controller
{
    
    public function register(Request $request){
        $request->validate([
            "name"=> "required|max:40",
            "email"=> "required|email|unique:users",
            "password"=> "required|min:8|max:20|",
            "student_id"=> "required|max:6|min:6|unique:users"
        ]);

        DB::table("users")->insert(
            ["name"=>$request->name,"email"=>$request->email, "password"=>Hash::make($request->password),"student_id"=>$request->student_id]
        );
        return json_encode([
            "msg" => "Created successfully",
        ]);
    }

    
    public function login(Request $request){
        

        $credentials = $request->validate([
            "email"=>"sometimes|required",
            "password"=>"sometimes|required|min:8|max:20",
        ]);
        if(empty($credentials["email"])  || empty($credentials["password"])){
            abort(422);
        }
        else if(Auth::attempt($credentials)){
            $associative_array = json_decode(Auth::user(),true);
            $user["email"] = $associative_array["email"];
            $user["name"] = $associative_array["name"];
            $user["student_id"] = $associative_array["student_id"];
           
            $token = JwtToken::createToken($user,"2025-10-10");
            return $token;
        }
        else{
            abort(401);
        }
    }
    public function profile(Request $request){
        $student_id = JwtToken::check($request->bearerToken());

        $info = DB::table("students")->where("student_id","=",$student_id)->first();
        $room_id = DB::table("room_ids")->where("student_id","=",$student_id)->first();

        return json_encode([
            "student_id" => $student_id,
            "name" => $info->name,
            "birth"=> $info->birth,
            "phone" => $info->phone,
            "room_id" => $room_id->room_id,
        ]);
        
    }
    

    public function account(Request $request){
        $student_id = JwtToken::check($request->bearerToken());

        $info = DB::table("users")->where("student_id","=" ,$student_id)->first();

        return json_encode([
            "name" => $info->name,
            "email" => $info->email,
        ]);
    }

    public function updatePassword(Request $request, UpdateAccountsRequest $update){
        $student_id = JwtToken::check($request->bearerToken());

        $pass = $update->safe()->only(['password']);

        DB::table("users")->where("student_id","=",$student_id)->update(["password"=>Hash::make($pass["password"])]);
        return json_encode([
            "msg" => "Updated successfully",
        ]);
           
    }
}
