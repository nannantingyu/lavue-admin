<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Kuaixun extends Model
{
    protected $table = 'kuaixun';


    protected $fillable = ['title', 'description', 'keywords', 'body',
        'source_id', 'publish_time', 'importance', 'more_link',
        'image', 'type', 'former_value', 'predicted_value',
        'published_value', 'country', 'influnce', 'star','status'
    ];


    /**
     * 根据页码查询数据
     * @param string $type 查询那种类型的快讯
     * @param int $page 第几页
     * @param int $pageSize 每页显示数量
     * @param string $order 排序方式
     * @param bool $isDesc 是否正序 还是倒叙
     * @return array
     */
    public function getPageList($type = 'kuaixun', $page = 0, $pageSize = 10, $order = 'publish_time', $isDesc = true)
    {
        $qTable = " FROM jujin8_$type ";
        $orderBy = ' ORDER BY ' . $order . ' ' . ($isDesc ? 'DESC' : 'ASC') . ' ';
        $columns = " id,title,description,body,image,source_id,publish_time,type,importance,created_at,`status` as state,updated_at,'$type' AS source_site ";

        $limit = ' limit ' . ($page * $pageSize) . ' , ' . $pageSize;
        $sql = "select $columns $qTable $orderBy $limit";
        $ret = DB::connection()->select($sql);

        $count = DB::connection()->selectOne("select count(id) AS count $qTable");

        return [
            'value' => $ret,
            'count' => $count->count,
            'page' => $page,
            'pageSize' => $pageSize
        ];
        return $ret;
    }


    /**根据时间查询数据
     * @param string $type 查询那种快讯表
     * @param null $startTime 开始时间
     * @param null $endTime 结束时间
     * @param string $order 排序方式
     * @param bool $isDesc 是否正序
     * @return array
     */
    public function getList($type = 'kuaixun', $startTime = null, $endTime = null, $order = 'publish_time', $isDesc = true)
    {
        //如果结束时间不是空的，那;么就往后面加一天 就是包含当前天
        if (!is_null($endTime)) {
            $endTime = date('Y-m-d 00:00:00', strtotime('+1 day', strtotime($endTime)));
        } else {
            //如果结束时间是空的，那么结束时间往后一天
            $endTime = date("Y-m-d 00:00:00", strtotime("1 day"));
        }

        //如果开始时间是空的，那么往前取一周的数据
        if (is_null($startTime)) {
            $startTime = date('Y-m-d 00:00:00', strtotime('-8 day', strtotime($endTime)));
        }

        $qTable = " FROM jujin8_$type ";
        $orderBy = ' ORDER BY ' . $order . ' ' . ($isDesc ? 'DESC' : 'ASC') . ' ';
        $columns = " id,title,description,body,image,source_id,publish_time,type,importance,created_at,`status` as state,updated_at,'$type' AS source_site ";
        $where = " WHERE publish_time BETWEEN '$startTime' AND '$endTime' ";
        $sql = "select $columns $qTable $where $orderBy";
        $ret = DB::connection()->select($sql);
        return $ret;
    }


    /**
     * 获取财经快讯的结合
     * @param int $page 页码
     * @param int $num 数量
     * @param null $start_date 开始时间
     * @param null $end_date 结束时间
     * @return array
     */
    public function getKuaixun($page = 1, $num = 20, $start_date = null, $end_date = null)
    {

        if (is_null($start_date)) {
            $start_date = date("Y-m-d 00:00:00", strtotime("-1 day"));
        }

        $where_date = " publish_time > '" . $start_date . "' ";
        if (!is_null($end_date)) {
            $where_date .= " and publish_time < '" . $end_date . "' ";
        }

        $columns = ' id, publish_time, importance, body, created_at ';
        $limit = ' order by publish_time desc limit ' . $page * $num;

        $sql = 'select * from (';
        $sql .= '(select ' . $columns . ' ,"jin10" as source_site from jujin8_kuaixun where ' . $where_date . $limit . ") ";
        $sql .= 'union ';
        $sql .= '(select ' . $columns . ', "fx678" as source_site from jujin8_fx678_kuaixun where ' . $where_date . $limit . ") ";
        $sql .= 'union ';
        $sql .= '(select ' . $columns . ', "wallstreetcn" as source_site from jujin8_wallstreetcn_kuaixun where' . $where_date . $limit . ')';
        $sql .= ')all_tb order by publish_time desc limit ' . ($page - 1) * $num . ',' . $num . ';';

        $sqlcount = 'select ';
        $sqlcount .= '(select count(*) from jujin8_kuaixun where ' . $where_date . ") ";
        $sqlcount .= '+ ';
        $sqlcount .= '(select count(*) from jujin8_fx678_kuaixun where ' . $where_date . ") ";
        $sqlcount .= '+ ';
        $sqlcount .= '(select count(*) from jujin8_wallstreetcn_kuaixun where' . $where_date . ')';
        $sqlcount .= ' as cou';

        $ret = DB::connection()->select($sql);
        $retcount = DB::connection()->select($sqlcount);

        return [
            "ret" => $ret,
            "count" => min($retcount[0]->cou, $num)
        ];
    }
}