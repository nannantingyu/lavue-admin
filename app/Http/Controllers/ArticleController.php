<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Article;

class ArticleController extends Controller {
    /**
     * 获取文章列表
     * @return array
     */
    public function lists () {
        return ['success'=>1, 'data'=>Article::all()];
    }

    /**
     * 获取单个文章详情
     */
    public function info(Request $request) {
        $id = $request->input('id');
        if(!is_null($id)) {
            $article = Article::with('body')->find($id);
        }

        return ['success'=>1, 'data'=>$article];
    }
}