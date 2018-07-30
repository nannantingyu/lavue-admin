<?php
/**
 * 财经日历
 * User: yangji
 * Date: 2018/7/30
 * Time: 上午11:11
 */

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Calendar extends Model
{
    protected $table = 'economic_calendar';

    protected $fillable = ['country', 'quota_name', 'publish_time', 'importance',
        'former_value', 'predicted_value', 'published_value', 'influence',
        'source_id', 'dataname', 'datename', 'dataname_id', 'unit',
    ];
}