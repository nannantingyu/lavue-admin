<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class Article extends Model {
    protected $table = 'article';

    public function body() {
        return $this->hasOne("App\Models\ArticleBody", 'aid', 'id');
    }

    public function categories() {
        return $this->belongsToMany("App\Models\Category", 'article_category', 'aid', 'cid');
    }

    public function comments() {
        return $this->hasMany('App\Models\Comment', 'aid', 'id');
    }
}