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

    /**
     * 获取具体的配置
     * @param $id int 根据id获取
     * @param $key string 根据key获取
     * @return array
     */
    public function info (Request $request) {
        $id = $request->input('id');
        $key = $request->input('key');

        if(!is_null($id) && \numcheck::is_int($id))
            return ['success'=>1, 'data'=>Config::find($id)];
        elseif (!is_null($key))
            return ['success'=>1, 'data'=>Config::where('key', $key)->first()];

        return ['success'=>0];
    }

    /**
     * 添加或者更新配置
     * @param $id int 根据id获取
     * @param $key string 根据key获取
     * @param $form array 表单数据
     */
    public function addConfig(Request $request) {
        //验证表单
        $validate = $this->validateForm($request);
        if(!$validate['success']) {
            return response()->json(['success'=>0, "errors"=>$validate['msg']]);
        }

        //添加或者更新数据
        $form = [
            'key' => $request->input('key'),
            'value' => $request->input('value'),
            'group' => $request->input('group'),
            'state' => $request->input('state'),
            'sequence' => $request->input('sequence'),
            'comment' => $request->input('comment'),
        ];

        $id = $request->input('id');
        if(!is_null($id)) {
            Config::where('id', $id)->update($form);
        }
        else {
            $config = new Config($form);
            $config->save();
            $id = $config->id;
        }

        return ['success'=>1, 'data'=>['id'=>$id]];
    }

    /**
     * 表单验证
     * @param Request $request
     * @return array
     */
    private function validateForm(Request $request) {
        $messages = [
            'key.required' => '请输入键',
            'key.max' => '键长度不能超过32个字符',
            'key.min' => '键长度不能少于2个字符',
            'value.required' => '值不能为空',
            'group.required' => '分组不能为空',
            'group.max' => '分组长度最多32个字符',
            'state.integer' => '状态不正确',
            'sequence.integer' => '排序不正确',
        ];

        $rules = [
            'key' => 'required|max:32|min:2',
            'value' => 'required',
            'group' => 'required|min:2|max:32',
            'sequence' => 'required|integer',
            'state' => 'required|integer',
        ];

        $validator = \Validator::make($request->all(), $rules, $messages);
        if($validator->fails()) {
            return ['success'=>0, 'msg'=>$validator->errors()];
        }

        return ['success'=>1];
    }

    /**
     * 根据id设置config状态
     * @param Request $request
     */
    public function setConfigState(Request $request) {
        $id = $request->input('id');
        if(!is_null($id) and \numcheck::is_int($id)) {
            $state = $request->input('state');
            $state = $state === 1?$state:0;

            Config::where('id', $id)->update(['state'=>$state]);
            return ['success'=>1];
        }

        return ['success'=>0];
    }
}