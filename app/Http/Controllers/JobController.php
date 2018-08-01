<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Support\TemplateUpdater;

/**
 * 执行任务
 * Class JobController
 * @package App\Http\Controllers
 */
class JobController extends Controller
{
    public function __construct(TemplateUpdater $updater)
    {
        $this->updater = $updater;
    }

    /**
     * @param Request $request
     * @return array
     */
    public function genetateTemplate(Request $request) {
        $url = $request->input('url');
        $type = $request->input('type');

        if(!is_null($url) && in_array($type, ['update', 'delete', 'api'])) {
            $this->updater->update($url, $type);
            return [ "success"=> 1 ];
        }

        return [ "success"=> 0 ];
    }
}