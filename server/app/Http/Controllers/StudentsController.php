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
        
        if ($name == "nothing given" && $id == "nothing given") {
            return StudentsResource::collection(DB::table("students")->paginate(15));

        }else{
            $data = DB::table("students")->select("name","student_id","ethnic")
            ->where("student_id","LIKE","$id%")
            ->orWhere("name","LIKE","%$name%")
            ->get();
            
            return response()->json([
                "data"=>$data,
            ]);
        }
    }
    public function info(Request $request){
        $id = $request->query("student_id","nothing given");
        $data = DB::table("students")->join("users","students.student_id","=","users.student_id")->select("students.student_id","students.birth","phone","users.email")->get();
        return response()->json([
            "data"=>$data,
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
        //
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
    public function destroy(Students $students)
    {
        //
    }
}
