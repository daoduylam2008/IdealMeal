<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\LazyCollection;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Spatie\SimpleExcel\SimpleExcelReader;


class MealCodeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();

        SimpleExcelReader::create("public/csv/meal_code.xlsx")
        ->getRows()
        ->each(function(array $rowProperties) {
            DB::table('meal_codes')->insert($rowProperties);
        });
        
        
    
    }
}
