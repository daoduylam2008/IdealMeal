<?php

namespace App\Http\Controllers;

use DB;
use App\Models\Students;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\StudentsResource;
use App\Http\Requests\StoreStudentsRequest;
use App\Http\Requests\UpdateStudentsRequest;

class StudentsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $id = $request->query("student_id","nothing given");
        $name = $request->query("name","nothing given");
        $class = $request->query("class","nothing given");
        
        if ($name == "nothing given" && $id == "nothing given" && $class == "nothing given") {
            return StudentsResource::collection(DB::table("students")->paginate(15));

        }else{
            $data = DB::table("students")->select("name","student_id","ethnic","class")
            ->where("student_id","LIKE","$id%")
            ->orWhere("name","LIKE","%$name%")
            ->orWhere("class","LIKE","%$class%")
            ->get();
            
            return response()->json([
                "data"=>$data,
            ]);
        }
    }
    public function info(Request $request){
        $id = $request->query("student_id","nothing given");

        $studentsData = DB::table('students')->select("student_id","birth","phone")?->where("student_id","=",$id);
        $roomId = DB::table('room_ids')->select("room_id")?->where("student_id","=",$id);
        $usersData = DB::table("users")->select("email","name")?->where("student_id","=",$id);

        return response()->json([
            "data"=>[
                "student_id"=>$studentsData->exists() ? $studentsData->first()->student_id : "",
                "birth"=> $studentsData->exists() ? $studentsData->first()->birth : "",
                "phone"=> $studentsData->exists() ? $studentsData->first()->phone : "",
                "room_id"=>$roomId->exists() ?  $roomId->first()->room_id : "",
                "email"=>$usersData->exists() ? $usersData->first()->email : "",
                "user_name"=>$usersData->exists() ? $usersData->first()->name : "",
            ]
        ]);
        
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreStudentsRequest $request)
    {
        // return new StudentsResource(Students::create($request->all()));
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {   
        $result = DB::table("students")
                    ->where("student_id","=",$id)
                    ->first();
        return new StudentsResource($result);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Students $students)
    {
        $info = request(["student_id",'name','ethnic','birth','class','phone','email','room_id']);


        if (DB::table("room_ids")?->where("student_id","=",$info['student_id'])->exists() == false){
            return response()->json([
                'msg' => "Invalid student id"
            ]);
        }

        foreach($info as $i => $j){
           if ($j != null && $i != "email" && $i != "room_id"){
            $arr[$i] = $j;
           }
        }


        DB::table('students')->where('student_id','=',$info['student_id'])->update($arr);

        if ($info['email'] != null){
            DB::table("users")?->where("student_id","=",$info['student_id'])->update(['email' => $info['email']]);
        }
        if ($info['room_id'] != null){
            DB::table("room_ids")?->where("student_id","=",$info['student_id'])->update(['room_id' => $info['room_id']]);
        }

        return response()->json([
            "msg" => "Updated successfully",
        ]);

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateStudentsRequest $request, Students $students)
    {
        // Got some error because the table is not linked correctly to Model Students so it make complicated to fix that
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Students $students, Request $request)
    {
        $student_id = request(["student_id"]);
        $arr = explode(",",$student_id['student_id']);
        DB::table("students")->whereIn("student_id",$arr)->delete();
        return response()->json([
            "msg" => "Deleted successfully",
        ]);
    }
}
