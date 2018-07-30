<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});


Route::get('/jiedu', 'Api\CalendarController@getjiedu');
Route::get('/kx', 'Api\KuaixunController@getkx');
Route::get('/bkx', 'Api\KuaixunController@getBlockKx');
Route::get('/ukx', 'Api\KuaixunController@getUnionKx');
Route::post('/addFeedback', 'Api\FeedbackController@addFeedback');

Route::get('feedback/getList', 'Api\FeedbackController@getList');
Route::post('kuaixun/addKuaiXun', 'KuaiXunController@addKuaiXun');
Route::get('kuaixun/getList', 'KuaiXunController@getList');
Route::get('kuaixun/pagelist', 'KuaiXunController@getPageList');

Route::post('menu/add', 'MenuController@add');
Route::get('menu/list', 'MenuController@getList');
