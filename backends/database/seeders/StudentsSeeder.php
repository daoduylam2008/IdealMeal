<?php

namespace Database\Seeders;

use DB;
use Illuminate\Database\Seeder;
use Database\Seeders;
use Illuminate\Support\LazyCollection;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Spatie\SimpleExcel\SimpleExcelReader;

class StudentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();

        SimpleExcelReader::create('public/csv/student.xlsx')
        ->getRows()
        ->each(function(array $rowProperties){
            DB::table('students')->insert($rowProperties);
        });

        
    }
}
