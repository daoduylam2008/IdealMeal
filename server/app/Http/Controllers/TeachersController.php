<?php

namespace App\Http\Controllers;

use App\Models\Teachers;
use Illuminate\Http\Request;
use App\Http\Resources\TeachersResource;
use DB;

class TeachersController extends Controller
{
    public function show(Request $request){
        
        return  TeachersResource::collection(Teachers::all());
        
    }

    public function exchange(){
        
        DB::transaction(function (){

            $exchangeValues = request(["roomId_1","roomId_2"]);
        
            $row_1 = DB::table("teachers")->where("room_id","=",$exchangeValues["roomId_1"])->first();
            $row_2 = DB::table("teachers")->where("room_id","=",$exchangeValues["roomId_2"])->first();
            
            DB::table('teachers')?->where("room_id","=",$row_1->room_id)->update(["name"=>$row_2->name]);
            DB::table('teachers')?->where("room_id","=",$row_2->room_id)->update(["name"=>$row_1->name]);
        },2);

        
        
        return response()->json([
            "msg" => "success",
        ]);

    }   
    public function trash(){
        $teacher_id = request(["roomId"]);
        $arr = explode(",",$teacher_id['roomId']);
        DB::table("teachers")->whereIn("room_id",$arr)->delete();
        return response()->json([
            "msg" => "Deleted successfully",
        ]);
    }

    public function edit(){
        $editedValues = request(['roomId',"name"]);
        DB::table("teachers")->where("room_id","=",$editedValues["roomId"])->update(["name"=>$editedValues["name"]]);
        return response()->json([
            "msg" => "Updated successfully",
        ]);
    }


}
