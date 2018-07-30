<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Article;
use App\Models\ArticleBody;
use App\Models\ArticleCategory;
use App\Models\Category;
use Illuminate\Support\Facades\DB;

class ArticleController extends Controller {
    /**
     * 获取文章列表
     * @return array
     */
    public function lists () {
        return ['success'=>1, 'data'=>Article::orderBy('publish_time', 'desc')->get()];
    }

    /**
     * 根据分类获取文章列表
     */
    public function articleListsByCategory(Request $request) {
        $categories = $request->input('categories');
        if(!is_null($categories)) {
            $articles = DB::table('article_category')
                ->join('article', 'article_category.aid', '=', 'article.id')
                ->whereIn('article_category.cid', explode(',', $categories))
                ->select('article.*')
                ->orderBy('article.publish_time', 'desc')
                ->get();

            return ['success'=>1, 'data'=>$articles];
        }

        return ['success'=>0];
    }

    /**
     * 获取单个文章详情
     */
    public function info(Request $request) {
        $id = $request->input('id');
        if(!is_null($id)) {
            $article = Article::with('body')->with('categories')->find($id);
            return ['success'=>1, 'data'=>$article];
        }

        return ['success'=>0];
    }

    /**
     * 删除文章
     * @param id 文章id
     */
    public function deleteArticle(Request $request) {
        $id = $request->input('id');
        if(!is_null($id) and \numcheck::is_int($id)) {
            Article::where('id', $id)->delete();

            $this->updateArticleTemplate($id, 'delete');
            return ['success'=>1];
        }

        return ['success'=>0];
    }

    /**
     * 搜索文章
     * @param keyword 关键词
     */
    public function searchArticle(Request $request) {
        $keywords = $request->input('keywords');
        if(!is_null($keywords)) {

            $articles = Article::where('state', 1);
            if(\numcheck::is_int($keywords)) {
                $articles = $articles->where('id', 'like', $keywords);
            }
            else {
                $articles = $articles->where('title', 'like', '%'.$keywords.'%');
            }

            $articles = $articles->select('id', 'title', 'image', 'url')
                ->orderBy('publish_time', 'desc')
                ->get();

            return ['success'=>1, 'data'=>$articles];
        }
    }

    /**
     * 设置文章发布状态
     * @param Request $request
     */
    public function setArticleState(Request $request) {
        $id = $request->input('id');
        if(!is_null($id) and \numcheck::is_int($id)) {
            $state = $request->input('state');
            $state = $state == 1?1:0;

            $this->updateArticleTemplate($id, $state==1?'update':'delete');
            Article::where('id', $id)->update([
                'state'=>$state
            ]);

            return ['success'=>1];
        }

        return ['success'=>0];
    }

    /**
     * 添加或者更新文章
     * @param Request $request
     */
    public function addArticle(Request $request) {
        //验证表单
        $validate = $this->validateForm($request);
        if(!$validate['success']) {
            return response()->json(['success'=>0, "errors"=>$validate['msg']]);
        }

        $form = [
            'title' => $request->input('title'),
            'image' => $request->input('image'),
            'description' => $request->input('description'),
            'keywords' => $request->input('keywords'),
            'author' => $request->input('author'),
            'publish_time' => $request->input('publish_time'),
            'type' => $request->input('type'),
            'hits' => $request->input('hits'),
            'state' => $request->input('state'),
            'recommend' => $request->input('recommend'),
            'favor' => $request->input('favor'),
            'source_type' => $request->input('source_type')
        ];

        $id = $request->input('id');
        if(is_null($id)) {
            $article = new Article($form);
            $article->save();
            $article->url = '/article_'.$article->id;
            $article->save();
        }
        else {
            $article = Article::find($id);
            $article->update($form);
        }

        $body = $request->input('body');
        $articleBody = ArticleBody::where('aid', $article->id)->first();
        if(is_null($articleBody)) {
            $articleBody = new ArticleBody([
                'aid'=> $article->id,
                'body'=> $body
            ]);

            $articleBody->save();
        }
        else {
            ArticleBody::where('aid', $article->id)->update([
               'body' => $body
            ]);
        }

        //更新分类
        $categories = $request->input('categories', []);
        if(is_array($categories) and count($categories) > 0) {
            ArticleCategory::where('aid', $article->id)->delete();
            $all_cats = [];
            foreach ($categories as $val) {
                array_push($all_cats, ['aid'=> $article->id, 'cid'=>$val]);
            }

            ArticleCategory::insert($all_cats);
        }

        $this->updateArticleTemplate($article->id);

        return ['success'=>1];
    }

    /**
     * 更新相关静态页
     * @param $id
     */
    private function updateArticleTemplate($id, $type='update') {
        if(!\numcheck::is_int($id)) {
            return;
        }

        // 生成静态页
        if($type == 'update') {
            $this->template_updater->delete_page('read/'.$id);
        }
        elseif($type == 'delete') {
            $this->template_updater->update_page('read/'.$id);
        }

        $article = Article::with('categories')
            ->find($id);

        // 生成列表页
        if(!is_null($article->categories)) {
            foreach ($article->categories as $category) {
                $this->template_updater->update_page('news/'.$category->ename);
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
            'title.required' => '请输入标题',
            'title.max' => '标题长度不能超过32个字符',
            'title.min' => '标题长度不能少于2个字符',
            'description.required' => '描述不能为空',
            'description.max' => '描述长度不能超过512个字符',
            'description.min' => '描述长度不能少于2个字符',
            'keywords.max' => '关键词长度最多64个字符',
            'author.max' => '作者长度最多16个字符',
            'image.required' => '图片不能为空',
            'type.required' => '类型不能为空',
            'type.max' => '类型长度不能超过32字符',
            'type.min' => '类型长度不能少于2字符',
            'recommend.integer' => '推荐状态不正确',
            'state.integer' => '状态不正确',
            'favor.integer' => '收藏数不正确',
            'hits.integer' => '点击量不正确',
            'source_type.required' => '原创类型不能为空',
            'publish_time.require' => '发布日期不能为空',
            'publish_time.data' => '发布时间不正确'
        ];
        $rules = [
            'title' => 'required|max:32|min:2',
            'description' => 'required|max:512|min:2',
            'keywords' => 'max:64',
            'author' => 'max:16',
            'image' => 'required',
            'type' => 'required|max:32|min:2',
            'recommend' => 'required|integer',
            'hits' => 'required|integer',
            'favor' => 'required|integer',
            'state' => 'required|integer',
            'publish_time' => 'required|date',
            'source_type' => 'required'
        ];
        $validator = \Validator::make($request->all(), $rules, $messages);
        if($validator->fails()) {
            return ['success'=>0, 'msg'=>$validator->errors()];
        }

        return ['success'=>1];
    }
}