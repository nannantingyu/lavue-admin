<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * 日历假日
 * @package App\Models
 */
class EconomicHoliday extends Model
{
    protected $table = 'economic_holiday';
    protected $fillable = ['country', 'time', 'market', 'holiday_name', 'detail', 'date', 'source_id',];
}