<?php

namespace App\Http\Controllers\V1;

use App\Models\Students;
use App\Http\Controllers\Controller;
use App\Http\Resources\StudentsResource;
use App\Http\Requests\StoreStudentsRequest;
use App\Http\Requests\UpdateStudentsRequest;
use DB;
class StudentsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
