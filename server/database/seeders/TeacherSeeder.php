<?php

namespace Database\Seeders;

use DB;
use App\Models\Teachers;
use Illuminate\Database\Seeder;
use Spatie\SimpleExcel\SimpleExcelReader;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class TeacherSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // DB::disableQueryLog();
        // SimpleExcelReader::create("data/teachers.xlsx")
        // ->getRows()
        // ->each(function(array $rowProperties){
        //     DB::table("teachers")->insert($rowProperties);
        // });

        Teachers::factory()->count(25)->create();
    }
}
