<?php

namespace Database\Seeders;

use DB;
use App\Models\Students;
use Illuminate\Database\Seeder;
use Spatie\SimpleExcel\SimpleExcelReader;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class StudentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // DB::disableQueryLog();
        // SimpleExcelReader::create("data/student.xlsx")
        // ->getRows()
        // ->each(function(array $rowProperties){
        //     DB::table("students")->insert($rowProperties);
        // });
        Students::factory()->count(5000)->create();
    }
}
