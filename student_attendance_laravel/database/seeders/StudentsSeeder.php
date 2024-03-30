<?php

namespace Database\Seeders;

use DB;
use Illuminate\Database\Seeder;
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
            $handle = fopen('a.csv', 'r');

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
                    $id = $splitColumns[$i][0];
                    $name = $splitColumns[$i][1];
                    $birth = $splitColumns[$i][2];
                    $ethnic = $splitColumns[$i][3];
                    $address = $splitColumns[$i][4];
                    $phone  = $splitColumns[$i][5];
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
