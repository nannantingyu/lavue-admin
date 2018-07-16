<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class Category extends Model {
    protected $table = 'category';

    public function articles() {
        return $this->belongsToMany("App\Models\Article", 'article_category', 'cid', 'aid');
    }
}