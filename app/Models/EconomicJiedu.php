<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * 解读
 * @package App\Models
 */
class EconomicJiedu extends Model
{
    protected $table = 'economic_jiedu';
    protected $fillable = [
        'dataname_id',
        'next_pub_time',
        'pub_agent',
        'pub_frequency',
        'count_way',
        'data_influence',
        'data_define',
        'funny_read',
    ];
}