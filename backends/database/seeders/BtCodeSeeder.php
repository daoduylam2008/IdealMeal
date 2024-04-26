<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\LazyCollection;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class BtCodeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();

        LazyCollection::make(function(){
            $importfilecsv = new ImportFileCsv('csv/bt_code.csv');
            $splitColumns = $importfilecsv->importFile();
            $result = [];

            foreach($splitColumns as $splitColumn){
                $result[] = $splitColumn;
                yield $result;
            }
            
        })
        ->chunk(5000)
        ->each(function(LazyCollection $chunk){
            $records = $chunk->map(function($result){
                for ($i = 0; $i < count($result); $i++) {
                    $bt_code= $result[$i][0];
                    $name_bt = $result[$i][1];
                    $teacher_bt  = $result[$i][2];
                    $my_array = array($bt_code,$name_bt,$teacher_bt);
                }
                return [
                    'bt_code' => $my_array[0],
                    'name_bt' => $my_array[1],
                    'teacher_bt' => $my_array[2],
                    
                ];       
            })->toArray();

            DB::table('bt_codes')->insert($records);
        });
    }
}
