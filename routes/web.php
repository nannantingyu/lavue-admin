<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'IndexController@index');
Route::get('/test', 'TestController@index');

// 文章
Route::get('/articleLists', 'ArticleController@lists');
Route::get('/articleInfo', 'ArticleController@info');
Route::post('/setArticleState', 'ArticleController@setArticleState');
Route::post('/addArticle', 'ArticleController@addArticle');
Route::post('/deleteArticle', 'ArticleController@deleteArticle');
Route::post('/searchArticle', 'ArticleController@searchArticle');


// 系统配置
Route::get('/configLists', 'ConfigController@lists');
Route::get('/configInfo', 'ConfigController@info');
Route::post('/setConfigState', 'ConfigController@setConfigState');
Route::post('/addConfig', 'ConfigController@addConfig');

// 热门图片
Route::get('/hotBannerLists', 'HotBannerController@lists');
Route::get('/hotBannerInfo', 'HotBannerController@info');
Route::post('/setHotBannerState', 'HotBannerController@setHotBannerState');
Route::post('/addHotBanner', 'HotBannerController@addHotBanner');

Route::any('mail', 'TestController@mail');

Route::post('/regist', 'RegisterController@regist');
Route::post('/uploads_image', 'UploadsController@image');
Route::post('/login', 'UserController@login');
Route::post('/logout', 'UserController@adlogout');
Route::get('/getModule', 'ModuleController@getModule');
Route::post('/addOrUpdateModule', 'ModuleController@addOrUpdateModule');
Route::post('/addRole', 'UserController@addRole');
Route::post('/assignRoleForUser', 'UserController@assignRoleForUser');
Route::post('/retractRoleFromUser', 'UserController@retractRoleFromUser');
Route::get('/getRoles', 'UserController@getRoles');
Route::get('/getUsers', 'UserController@getUsers');
Route::get('/getRoleUsers', 'UserController@getRoleUsers');
Route::get('/getModuleTreeSelect', 'ModuleController@getModuleTreeSelect');
Route::get('/getModulePermission', 'ModuleController@getModulePermission');
Route::post('/addModulePermission', 'ModuleController@addModulePermission');
Route::get('/getRoleMoudlePermission', 'ModuleController@getRoleMoudlePermission');
Route::get('/getUserModulePermission', 'ModuleController@getUserModulePermission');



Route::post('/addKuaiXun', 'KuaiXunController@addKuaiXun');
Route::get('/addKuaiXun', 'KuaiXunController@addKuaiXun');