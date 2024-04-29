<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use DB;
use Spatie\SimpleExcel\SimpleExcelReader;


class MealDaysSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // DB::disableQueryLog();

        // $rows = SimpleExcelReader::create("public/csv/ab.xlsx")
        // ->getRows()
        // ->each(function(array $rowProperties){
        //     DB::table('meal_days')->insert($rowProperties);
        // });

    }
}
