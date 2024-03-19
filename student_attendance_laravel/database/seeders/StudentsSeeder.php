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
                    $name = $splitColumns[$i][0];
                    $birth = $splitColumns[$i][1];
                    $ethnic = $splitColumns[$i][2];
                    $address = $splitColumns[$i][3];
                    $phone  = $splitColumns[$i][4];
                    $my_array = array($name,$birth, $ethnic, $address, $phone);
                }
                return [
                    'name' => $my_array[0],
                    'birth' => $my_array[1],
                    'ethnic' => $my_array[2],
                    'address' => $my_array[3],
                    'phone' => $my_array[4],
                    
                ];
                
                    
            })->toArray();

            DB::table('students')->insert($records);
        });
    }
}
