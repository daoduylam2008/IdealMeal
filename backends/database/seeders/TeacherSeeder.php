<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\SimpleExcel\SimpleExcelReader;
use DB;

class TeacherSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();
        SimpleExcelReader::create("data/teachers.xlsx")
        ->getRows()
        ->each(function(array $rowProperties){
            DB::table("teachers")->insert($rowProperties);
        });
    }
}
