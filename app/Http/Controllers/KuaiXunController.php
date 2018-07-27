<?php
/**
 * Created by PhpStorm.
 * User: jujin8
 * Date: 2018/7/24
 * Time: 下午4:53
 */

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Auth;
use App\Models\Module;
use App\Models\Kuaixun;

class KuaiXunController extends Controller
{


    public function getKx(Request $request)
    {
        return ['success' => 1, 'value' => '成功'];
    }

    /**
     */
    protected function validator(array $data)
    {
        $messages = [
            'title.required' => '请输入快讯标题',
            'body.required' => '请输入快讯内容',
        ];

        $rules = [
            'title' => 'required',
            'body' => 'required',
        ];

        return Validator::make($data, $rules, $messages);
    }


    /**
     * 添加或者修改快讯
     * @param Request $request
     * @return array
     */
    public function addKuaiXun(Request $request)
    {
        if(1==1){
            return ['success' => 1, 'value' => '1212121'];
        }

        $form = [
            'title' => $request->input('title'),
            'description' => $request->input('description'),
            'keywords' => $request->input('keywords'),
            'body' => $request->input('body'),
            'source_id' => $request->input('source_id'),
            'publish_time' => $request->input('publish_time'),
            'importance' => $request->input('importance'),
            'more_link' => $request->input('more_link'),
            'image' => $request->input('image'),
            'type' => $request->input('type'),
            'former_value' => $request->input('former_value'),
            'predicted_value' => $request->input('predicted_value'),
            'published_value' => $request->input('published_value'),
            'country' => $request->input('country'),
            'influnce' => $request->input('influnce'),
            'star' => $request->input('star'),
        ];

        $this->validator($form);

        $id = $request->input('id');
        if (!is_null($id)) {
            Kuaixun::where('id', $id)->update($form);
        } else {
            $kuaiXun = new Kuaixun($form);
            $kuaiXun->save();
            $id = $kuaiXun->id;
        }

        return ['success' => 1, 'data' => ['id' => $id]];
    }


}