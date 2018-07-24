<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class CategoryCompany extends Model {
    protected $table = 'category_company';

    public function company() {
        return $this->belongsToMany("App\Models\Company", 'company_category', 'ccid', 'cid');
    }
}