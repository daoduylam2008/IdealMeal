<?php

namespace App\Http\Controllers\V1;

use App\Models\MealDays;
use Illuminate\Routing\Controller;
use App\Http\Resources\V1\MealDayResource;
use App\Http\Requests\V1\StoreMealDaysRequest;
use App\Http\Requests\UpdateMealDaysRequest;

class MealDaysController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return MealDays::all();
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
        return new MealDayResource(MealDays::create($request->all()));
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
