<?php

namespace App\Http\Controllers;

use DB;
use App\Models\MealDays;
use App\Http\Resources\MealDayResources;
use App\Http\Requests\StoreMealDaysRequest;
use App\Http\Requests\UpdateMealDaysRequest;

class MealDaysController extends Controller
{
    

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreMealDaysRequest $request)
    {
        // print_r(($request->all())['dex']);
        $dexs = "";
        foreach ($request->all()['dex'] as $dex => $value){
            $dexs .=$dex . ":" .$value." ";
        }
        $meal_day["student_id"] = $request->safe()->only(['student_id'])["student_id"];
        $meal_day["dex"] = trim($dexs);

        // return json_encode($meal_day);
        
        DB::table("meal_days")->insert($meal_day);
        return json_encode([
            "msg" => "Created successfully",
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $result[0] = DB::table("meal_days")->where("student_id",'=',$id)->first();
    
        return new MealDayResources($result[0]);
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
