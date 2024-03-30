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
            $handle = fopen('bt_code.csv', 'r');

            $data ='';
            while (!feof($handle)) {
                $data .= fgets($handle, 5000);
            }
            // convert encoding
            $data = mb_convert_encoding($data, "UTF-8", "auto");

            $splitLines = explode("\n", $data);
            
            $splitColumns = [];
            foreach($splitLines as $line){
                $splitColumns[] = explode(";", $line);
                yield $splitColumns;
            }
            
            
            
            fclose($handle);
        })
        ->chunk(5000)
        ->each(function(LazyCollection $chunk){
            $records = $chunk->map(function($splitColumns){
                for ($i = 0; $i < count($splitColumns); $i++) {
                    $bt_code= $splitColumns[$i][0];
                    $name_bt = $splitColumns[$i][1];
                    $teacher_bt  = $splitColumns[$i][2];
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
