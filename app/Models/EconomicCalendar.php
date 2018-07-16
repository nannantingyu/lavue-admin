<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;

class EconomicCalendar extends Model {
    protected $table = 'economic_calendar';

    public function jeidu() {
        return $this->hasOne('App\Models\EconomicJiedu', 'dataname_id', 'dataname_id');
    }
}