<?php

namespace App\Http\Controllers;

use DB;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use PHPOpenSourceSaver\JWTAuth\JWT ;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
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


    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {

        $credentials = request(['email', 'password']);
        // $token = auth()->attempt($credentials);
        if (! $token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    public function profile(Request $request){
        $student_id = (auth()->user())["student_id"];
        $info = DB::table("students")?->whereNotNull("student_id")?->where("student_id","=",$student_id)?->first();

        
        $room_id = DB::table("room_ids")?->whereNotNull("student_id")?->where("student_id","=",$student_id)?->first();


        if(empty($info)){
            return response()->json(
                [
                    "student_id" => $student_id,
                    "name" => "",
                    "birth"=> "",
                    "phone" => "",
                    "room_id" => "",
                ]
            );
        }

        else{
            return response()->json(
                [
                    "student_id" => $student_id,
                    "name" => $info->name,
                    "birth"=> $info->birth,
                    "phone" => $info->phone,
                    "room_id" => $room_id->room_id,
                ]
            );
    
        }
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh(false,true));
    }

    /**
     * Update password for a user.
     *
     * 
     **/

    public function updatePassword(){
        $student_id = (auth()->user())["student_id"];
        $pass = request(['password']);
        DB::table("users")->where("student_id","=",$student_id)->update(["password"=>Hash::make($pass["password"])]);
        return response()->json([
            "msg" => "Updated successfully",
        ]);
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => strtotime("first day of +1 month"),
        ]);
    }
    
}
