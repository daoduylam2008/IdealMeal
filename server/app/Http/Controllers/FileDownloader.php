<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class FileDownloader extends Controller
{
    public function download(){
        // $path = Storage::path("/data/student.xlsx");

        // return response()->download($path);
    }
}
