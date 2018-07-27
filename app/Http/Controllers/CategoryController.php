<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\Config;

class CategoryController extends Controller {
    /**
     * 获取分类列表
     * @return array
     */
    public function lists () {
        return ['success'=>1, 'data'=>Category::orderBy('updated_at', 'desc')->get()];
    }

    /**
     * 获取具体的分类
     * @param $id int 根据id获取
     * @param $key string 根据key获取
     * @return array
     */
    public function info (Request $request) {
        $id = $request->input('id');

        if(!is_null($id) && \numcheck::is_int($id))
            return ['success'=>1, 'data'=>Category::find($id)];

        return ['success'=>0];
    }

    /**
     * 添加或者更新分类
     * @param $id int 根据id获取
     * @param $key string 根据key获取
     * @param $form array 表单数据
     */
    public function addCategory(Request $request) {
        //验证表单
        $validate = $this->validateForm($request);
        if(!$validate['success']) {
            return response()->json(['success'=>0, "errors"=>$validate['msg']]);
        }

        $ename = $request->input('ename');
        //添加或者更新数据
        $form = [
            'name' => $request->input('name'),
            'ename' => $ename,
            'pid' => $request->input('pid'),
            'target' => $request->input('target'),
            'state' => $request->input('state'),
            'sequence' => $request->input('sequence'),
        ];

        $id = $request->input('id');
        if(!is_null($id)) {
            Category::where('id', $id)->update($form);
        }
        else {
            $category = new Category($form);
            $category->save();
            $id = $category->id;
        }

        return ['success'=>1, 'data'=>['id'=>$id]];
    }

    /**
     * 更新文章静态页
     */
    private function updateCategoryTemplate() {
        $except_categories_config = Config::where('key', 'articleFilter')
            ->find();

        $all_categories = Category::orderBy('sequence', 'asc');

        if(!is_null($except_categories_config)) {
            $except_categories = explode(",", $except_categories_config->value);
            $all_categories = $all_categories->whereNotIn('ename', $except_categories);
        }

        $all_categories = $all_categories->pluck('ename');

        $this->kafka->produce($this->static_topic, 'news');
        if(!is_null($all_categories)) {
            foreach ($all_categories as $category) {
                $this->kafka->produce($this->static_topic, 'news/'.$category);
            }
        }
    }

    /**
     * 表单验证
     * @param Request $request
     * @return array
     */
    private function validateForm(Request $request) {
        $messages = [
            'name.required' => '请输入分类名称',
            'name.max' => '分类名称长度不能超过20个字符',
            'name.min' => '分类名称长度不能少于2个字符',
            'ename.required' => '请输入分类英文名称',
            'ename.max' => '分类英文名称长度不能超过20个字符',
            'ename.min' => '分类英文名称长度不能少于2个字符',
            'pid.integer' => '父分类不正确',
            'pid.required' => '父分类不能为空',
            'target.required' => 'Target不能为空',
            'state.integer' => '状态不正确',
            'sequence.integer' => '排序不正确',
        ];

        $rules = [
            'name' => 'required|max:20|min:2',
            'ename' => 'required|max:20|min:2',
            'pid' => 'required|integer',
            'target' => 'required',
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
     * 根据id设置分类状态
     * @param Request $request
     */
    public function setCategoryState(Request $request) {
        $id = $request->input('id');
        if(!is_null($id) and \numcheck::is_int($id)) {
            $state = $request->input('state');
            $state = $state === 1?$state:0;

            Category::where('id', $id)->update(['state'=>$state]);
            return ['success'=>1];
        }

        return ['success'=>0];
    }
}