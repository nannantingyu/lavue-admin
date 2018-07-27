<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Feedback extends Model
{

    protected $table = 'feedback';

    protected $fillable = ['content', 'phone', 'is_handling', 'ip'];

    public function lists($page = 0, $pageSize = 20, $order = 'id', $isDesc = true)
    {
        $qTable = ' jujin8_feedback';
        $orderBy = ' ORDER BY ' . $order . ' ' . ($isDesc ? 'DESC' : 'ASC');
        $start = $page * $pageSize;
        $limit = ' limit ' . $start . ' , ' . $pageSize;
        $sql = "select * from $qTable  $orderBy $limit";
        $ret = DB::connection()->select($sql);

        $countSql = 'select count(id) AS count from ' . $qTable;

        $count = DB::connection()->select($countSql);

        return [
            "list" => $ret,
            'count' => $count[0]->count,
            'page' => $page,
            'pageSize' => $pageSize
        ];
    }


}