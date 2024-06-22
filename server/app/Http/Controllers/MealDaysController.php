<?php

namespace App\Http\Controllers;

use DB;
use App\Models\MealDays;
use App\Http\Resources\MealDayResources;
use App\Http\Requests\StoreMealDaysRequest;
use App\Http\Requests\UpdateMealDaysRequest;
use PHPOpenSourceSaver\JWTAuth\JWT ;
use Illuminate\Support\Facades\Auth;


class MealDaysController extends Controller
{
    


    /**
     * Display the specified resource.
     */
    public function show()
    {
        $student_id = (auth()->user())["student_id"];
        $result = DB::table("meal_days")->where("student_id",'=',$student_id)->first();
        return response()->json([
            "dex" => $result->dex,
        ]);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateMealDaysRequest $request, MealDays $mealDays)
    {
        
        $student_id = (auth()->user())["student_id"];
        DB::table("meal_days")->where("student_id",'=',$student_id)->update(['dex'=>$request->safe()->only(['dex'])['dex']]);

        return response()->json([
            "msg" => "Updated successfully",
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(MealDays $mealDays)
    {
        //
    }
}
