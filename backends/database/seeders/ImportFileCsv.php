<?php
namespace Database\Seeders;


class ImportFileCsv
{
    public string $filename;

    public function __construct(string $filename){
        $this->name =  $filename;
    }
    public function importFile(): array{

        $handle = fopen(public_path($this->name), 'r');

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
        }
        
        return $splitColumns;
        fclose($handle);
    }
    

}




?>