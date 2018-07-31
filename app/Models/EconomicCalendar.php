<?php
/**
 * 财经日历
 * User: yangji
 * Date: 2018/7/30
 * Time: 上午11:11
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class EconomicCalendar extends Model
{
    protected $table = 'economic_calendar';

    protected $fillable = ['country', 'quota_name', 'publish_time', 'importance',
        'former_value', 'predicted_value', 'published_value', 'influence',
        'source_id', 'dataname', 'datename', 'dataname_id', 'unit',
    ];

    /** 查询财经日历
     * @param int $page 页码
     * @param int $pageSize 每页数量
     * @param string $order 排序方式
     * @param bool $isDesc 是否正序 倒叙
     * @return array
     */
    public function lists($page = 0, $pageSize = 20, $order = 'id', $isDesc = true)
    {
        $qTable = ' jujin8_economic_calendar';

        $where = '  ';

        $orderBy = ' ORDER BY ' . $order . ' ' . ($isDesc ? 'DESC' : 'ASC');
        $start = $page * $pageSize;
        $limit = ' limit ' . $start . ' , ' . $pageSize;

        $sql = "select * from $qTable $where $orderBy $limit";
        $ret = DB::connection()->select($sql);

        $countSql = 'select count(id) AS count from ' . $qTable . $where;

        $count = DB::connection()->select($countSql);

        return [
            "list" => $ret,
            'count' => $count[0]->count,
            'page' => $page,
            'pageSize' => $pageSize
        ];
    }

}