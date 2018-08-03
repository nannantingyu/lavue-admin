<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EconomicEvent extends Model
{
    protected $table = 'economic_event';
    protected $fillable = ['country', 'time', 'city', 'importance','event', 'date', 'source_id',
    ];



}