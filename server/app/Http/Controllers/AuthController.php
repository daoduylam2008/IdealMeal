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
            "student_id"=> "required|max:6|min:6|unique:users",
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

        if (!empty($user = (auth()->user()))) {
            $student_id = $user["student_id"];
            
        
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
        else{
            return response()->json([
                "msg"=>'Unknown user'
            ]);
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
        return $this->checkValidToken("password","users",true);
    }

    /**
     * 
     * Update email
     *
     *  
     * */

    public function updateEmail(){
        return $this->checkValidToken("email","users");

    }
    /**
     * 
     * Update phone number
     *
     *  
     * */

    public function updatePhone(){
        return $this->checkValidToken("phone","students");
    }


    private function checkValidToken($nameTable,$nameDB,$hashed = false){

        if(!empty($user = auth()->user())){
            $student_id = $user['student_id'];
            

            $objectRequest = request(["$nameTable"]);
            
            if($this->checkIfDuplicateValue($nameTable,$nameDB,$objectRequest["$nameTable"])){
                return response()->json([
                    "msg" => "Duplicate value",
                ]);
            }else{

                DB::table("$nameDB")?->where("student_id","=",$student_id)?->update(["$nameTable"=> $hashed ? Hash::make($objectRequest['password']) : $objectRequest["$nameTable"]]);
            
            
                return response()->json([
                    "msg" => "Updated successfully",
                ]);
            }
           
            
        }else{
            return response()->json([
                "msg"=>'Unknown user'
            ]);
        }
    }

    private function checkIfDuplicateValue($nameTable, $nameDB,$value){
        $data = DB::table("$nameDB")->where("$nameTable","=",$value)->first();
        if(!empty($data)){
            return true;
        }
        else{
            return false;
        }
        
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
            'expires_in' => strtotime('first day of +1 month'),
        ]);
    }

    /**
     * 
     * @param $request
     * @return json
     * 
     */


    public function admin(Request $request){

        $validated = request(['email',"password"]);
        

        try{
            if(empty($validated['email']) || empty($validated['password'])){
                return response()->json("");
            }
            else if(Auth::guard("admin")?->attempt(['email'=>$validated['email'], 'password'=>$validated['password']])){
                return response()->json("successfull");
            }else{
                return response()->json("");
            }
        }catch (Exception $e){
            return response()->json("");
        }
        
    }
    
}
