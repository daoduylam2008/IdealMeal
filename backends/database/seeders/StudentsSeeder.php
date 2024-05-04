<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\SimpleExcel\SimpleExcelReader;
use DB;

class StudentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();
        SimpleExcelReader::create("data/student.xlsx")
        ->getRows()
        ->each(function(array $rowProperties){
            DB::table("students")->insert($rowProperties);
        });

    }
}
