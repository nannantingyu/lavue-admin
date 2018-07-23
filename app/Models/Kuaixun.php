<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Kuaixun extends Model {
    protected $table = 'kuaixun';

    /**
     * 获取财经快讯的结合
     * @param int $page 页码
     * @param int $num 数量
     * @param null $start_date 开始时间
     * @param null $end_date 结束时间
     * @return array
     */
    public function getKuaixun($page=1, $num=20, $start_date=null, $end_date=null) {

        if(is_null($start_date)) {
            $start_date = date("Y-m-d 00:00:00", strtotime("-1 day"));
        }

        $where_date = " publish_time > '".$start_date."' ";
        if(!is_null($end_date)) {
            $where_date .= " and publish_time < '" . $end_date . "' ";
        }

        $columns = ' id, publish_time, importance, body, created_at ';
        $limit = ' order by publish_time desc limit '.$page*$num;

        $sql = 'select * from (';
        $sql .= '(select '.$columns.' ,"jin10" as source_site from jujin8_kuaixun where '.$where_date.$limit.") ";
        $sql .= 'union ';
        $sql .= '(select '.$columns.', "fx678" as source_site from jujin8_fx678_kuaixun where '.$where_date.$limit.") ";
        $sql .= 'union ';
        $sql .= '(select '.$columns.', "wallstreetcn" as source_site from jujin8_wallstreetcn_kuaixun where'.$where_date.$limit.')';
        $sql .= ')all_tb order by publish_time desc limit '.($page-1)*$num .',' . $num . ';';

        $sqlcount = 'select ';
        $sqlcount .= '(select count(*) from jujin8_kuaixun where '.$where_date.") ";
        $sqlcount .= '+ ';
        $sqlcount .= '(select count(*) from jujin8_fx678_kuaixun where '.$where_date.") ";
        $sqlcount .= '+ ';
        $sqlcount .= '(select count(*) from jujin8_wallstreetcn_kuaixun where'.$where_date.')';
        $sqlcount .= ' as cou';

        $ret = DB::connection()->select($sql);
        $retcount = DB::connection()->select($sqlcount);

        return [
            "ret" => $ret,
            "count" => min($retcount[0]->cou, $num)
        ];
    }
}