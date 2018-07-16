<?php
namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Models\Article;
use App\Models\Category;

class TestController extends Controller {
    public function index() {
//        dd(Article::find(1)->body);
//        DB::enableQueryLog();
        $articles = Category::find(1)->articles;
        dump($articles);
        $article = Article::find(1);
        dump($article->categories);
        dump($article->comments);

//        dd(DB::getQueryLog());
//        dd(12345);
    }
}
