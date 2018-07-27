<?php
/**
 * Created by PhpStorm.
 * User: jujin8
 * Date: 2018/7/24
 * Time: 下午4:53
 */

namespace App\Http\Controllers\Api;

use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Models\Feedback;

class FeedbackController extends Controller
{
    protected function validator(array $data)
    {
        $messages = [
            'content.required' => '请输入您的意见',
            'phone.required' => '请输入您的联系方式',
        ];

        $rules = [
            'content' => 'required',
            'phone' => 'required',
        ];

        return Validator::make($data, $rules, $messages);
    }


    /**
     * 添加意见反馈，如果传入id 就是更新方法
     * @param Request $request
     * @return array
     */
    public function addFeedback(Request $request)
    {

        $ip = $this->getIp();
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return ['success' => 0, 'msg' => $validator->errors()];
        }

        $id = $request->input('id');

        $form = [
            'content' => $request->input('content'),
            'phone' => $request->input('phone'),
            'is_handling' => is_null($id) ? 0 : $request->input('is_handling'),
            'ip' => $ip,
        ];

        if (!is_null($id)) {
            Feedback::where('id', $id)->update($form);
        } else {
            $feedback = new Feedback($form);
            $feedback->save();
            $id = $feedback->id;
        }

        return ['success' => 1, 'data' => ['id' => $id]];
    }

    //获取用户IP地址
    public function getIp()
    {
        if (!empty($_SERVER["HTTP_CLIENT_IP"])) {
            $cip = $_SERVER["HTTP_CLIENT_IP"];
        } else if (!empty($_SERVER["HTTP_X_FORWARDED_FOR"])) {
            $cip = $_SERVER["HTTP_X_FORWARDED_FOR"];
        } else if (!empty($_SERVER["REMOTE_ADDR"])) {
            $cip = $_SERVER["REMOTE_ADDR"];
        } else {
            $cip = '';
        }
        preg_match("/[\d\.]{7,15}/", $cip, $cips);
        $cip = isset($cips[0]) ? $cips[0] : 'unknown';
        unset($cips);
        return $cip;
    }

}