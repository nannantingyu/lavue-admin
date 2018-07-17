<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Config;

class ConfigController extends Controller {
    /**
     * 获取配置列表
     * @return array
     */
    public function lists () {
        return ['success'=>1, 'data'=>config::orderBy('sequence', 'asc')->get()];
    }
}