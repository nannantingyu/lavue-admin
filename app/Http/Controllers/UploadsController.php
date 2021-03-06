<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UploadsController extends Controller
{
    /**
     * @param Request $request
     * @return array
     */
    public function image(Request $request) {
        $path = $request->file('fileDataFileName')
            ->store('cms/'.date("Y".'/'.date("m").'/'.date("d")));

        return [
            "success"=> true,
            "msg"=> "upload_success",
            "file_path"=> "/".str_replace('uploads', 'cms', $path)
        ];
    }
}