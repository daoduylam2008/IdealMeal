<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\LazyCollection;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class MealCodeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();

        LazyCollection::make(function(){
            $importfilecsv = new ImportFileCsv('csv/meal_code.csv');
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
                for ($i  = 0; $i < count($result); $i++){
                    $code = $result[$i][0];
                    $name = $result[$i][1];
                    $my_array = array($code, $name);
                }
                return [
                    'code' => $my_array[0],
                    'name' => $my_array[1],
                ];
            })->toArray();
        
    

            DB::table('meal_codes')->insert($records);


        });
        
    
    }
}
