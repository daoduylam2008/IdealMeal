<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\SimpleExcel\SimpleExcelReader;
use DB;

class MealCodeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // DB::disableQueryLog();
        // SimpleExcelReader::create("data/meal_code.xlsx")
        // ->getRows()
        // ->each(function(array $rowProperties){
        //     DB::table("meal_codes")->insert($rowProperties);
        // });
    }
}
