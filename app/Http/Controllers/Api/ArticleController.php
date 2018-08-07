<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use function Sodium\add;

class ArticleController extends Controller
{

    public function moreList(Request $request)
    {
        $size = $request->input('size');
        if (is_null($size) and !\numcheck::is_int($size)) {
            $size = 10;
        }

        $typeId = $request->input('typeId');
        if (is_null($typeId) and !\numcheck::is_int($typeId)) {
            $typeId = null;
        }

        $time = $request->input('time');
        $where = "";

        if (is_null($typeId)) {
            $idsStr = $this->getFilter();
            $where = "where cid not in (select jujin8_category.id from jujin8_category where jujin8_category.ename in ($idsStr))";
        } else {
            $where = "where cid = $typeId";
        }

        if (!is_null($time)) {
            $where = "$where and publish_time < '$time'";
        }

        $sql = "SELECT distinct jujin8_article.id,title,publish_time AS created,keywords AS catTitle,description AS metadesc,image AS imgurl,author AS author,source_site AS sourceSite,source_url AS sourceUrl,source_type as sourceType FROM jujin8_article RIGHT JOIN jujin8_article_category ON jujin8_article.id=aid $where ORDER BY publish_time DESC LIMIT $size";
        $lists = DB::select($sql);

        for ($i = 0; $i < count($lists); $i++) {
            $lists[$i]->imgurl = str_replace('uploads/crawler', 'uploads', $lists[$i]->imgurl);//a或b或c都替换成a
        }
        return ['success' => 1, 'data' => $lists];
    }

    private function getFilter()
    {
        $filterName = DB::selectOne("SELECT `value` FROM jujin8_config WHERE `key`='articleFilter' LIMIT 1")->value;
        $filterName = explode(',', $filterName);
        $idsStr = "";
        for ($i = 0; $i < count($filterName); $i++) {
            if ($i != 0) {
                $idsStr = "$idsStr,";
            }
            $idsStr = "$idsStr '$filterName[$i]'";
        }
        return $idsStr;
    }

}
