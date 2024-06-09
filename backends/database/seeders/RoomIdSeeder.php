<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\SimpleExcel\SimpleExcelReader;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use DB;
class RoomIdSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();
        SimpleExcelReader::create("data/room_id.xlsx")
        ->getRows()
        ->each(function(array $rowProperties){
            DB::table("room_ids")->insert($rowProperties);
        });
    }
}
