<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreMealDaysRequest;
use App\Http\Requests\UpdateMealDaysRequest;
use App\Models\MealDays;

class MealDaysController extends Controller
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
    public function store(StoreMealDaysRequest $request)
    {
        MealDays::create($request->all());
        return json_encode([
            "msg" => "Created successfully",
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(MealDays $mealDays)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(MealDays $mealDays)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateMealDaysRequest $request, MealDays $mealDays)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(MealDays $mealDays)
    {
        //
    }
}
