<?php

namespace Database\Seeders;

use DB;
use Illuminate\Database\Seeder;
use Database\Seeders;
use Illuminate\Support\LazyCollection;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class StudentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::disableQueryLog();

        LazyCollection::make(function(){
            $importfilecsv = new ImportFileCsv('csv/a.csv');
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
                    $id = $result[$i][0];
                    $name = $result[$i][1];
                    $birth = $result[$i][2];
                    $ethnic = $result[$i][3];
                    $address = $result[$i][4];
                    $phone  = $result[$i][5];
                    $my_array = array($id,$name,$birth, $ethnic, $address, $phone);
                }

        
                return [
                    'student_id' => $my_array[0],
                    'name' => $my_array[1],
                    'birth' => $my_array[2],
                    'ethnic' => $my_array[3],
                    'address' => $my_array[4],
                    'phone' => $my_array[5],  
                ];
                
                    
            })->toArray();

            DB::table('students')->insert($records);
        });
    }
}
