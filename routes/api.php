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
//意见反馈
Route::post('/addFeedback', 'Api\FeedbackController@addFeedback');
Route::get('feedback/getList', 'Api\FeedbackController@getList');
//快讯
Route::post('kuaixun/addKuaiXun', 'KuaiXunController@addKuaiXun');
Route::get('kuaixun/getList', 'KuaiXunController@getList');
Route::get('kuaixun/pagelist', 'KuaiXunController@getPageList');
//菜单
Route::post('menu/add', 'MenuController@add');
Route::get('menu/list', 'MenuController@getList');
//投资工具
Route::post('tool/add', 'ToolController@add');
Route::get('tool/list', 'ToolController@getList');

//财经日历
Route::post('calendar/add', 'CalendarController@add');
Route::get('calendar/list', 'CalendarController@getList');
//财经事件
Route::post('event/add', 'CalendarEventController@add');
Route::get('event/list', 'CalendarEventController@getList');
//财经假期
Route::post('holiday/add', 'CalendarHolidayController@add');
Route::get('holiday/list', 'CalendarHolidayController@getList');
//Banner活动
Route::post('banner/add', 'BannerController@add');
Route::post('banner/setState', 'BannerController@setState');
Route::get('banner/list', 'BannerController@getList');
//Banner活动
Route::post('banner/addCategory', 'BannerCategoryController@add');
Route::post('banner/setCategoryState', 'BannerCategoryController@setState');
Route::get('banner/listCategory', 'BannerCategoryController@getList');
