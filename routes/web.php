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
Route::get('/articleListsByCategory', 'ArticleController@articleListsByCategory');


// 系统配置
Route::get('/configLists', 'ConfigController@lists');
Route::get('/configInfo', 'ConfigController@info');
Route::post('/setConfigState', 'ConfigController@setConfigState');
Route::post('/addConfig', 'ConfigController@addConfig');

// 机构
Route::get('/companyLists', 'CompanyController@lists');
Route::get('/companyInfo', 'CompanyController@info');
Route::post('/setCompanyState', 'CompanyController@setCompanyState');
Route::post('/addCompany', 'CompanyController@addCompany');

// 分类
Route::get('/categoryLists', 'CategoryController@lists');
Route::get('/categoryInfo', 'CategoryController@info');
Route::post('/setCategoryState', 'CategoryController@setCategoryState');
Route::post('/addCategory', 'CategoryController@addCategory');

// 热门图片
Route::get('/hotBannerLists', 'HotBannerController@lists');
Route::get('/hotBannerInfo', 'HotBannerController@info');
Route::post('/setHotBannerState', 'HotBannerController@setHotBannerState');
Route::post('/addHotBanner', 'HotBannerController@addHotBanner');

Route::any('mail', 'TestController@mail');

// 用户
Route::post('/login', 'UserController@login');
Route::post('/logout', 'UserController@adlogout');
Route::post('/regist', 'RegisterController@regist');
Route::post('/addRole', 'UserController@addRole');
Route::post('/assignRoleForUser', 'UserController@assignRoleForUser');
Route::post('/retractRoleFromUser', 'UserController@retractRoleFromUser');
Route::get('/getRoles', 'UserController@getRoles');
Route::get('/getUsers', 'UserController@getUsers');
Route::get('/getRoleUsers', 'UserController@getRoleUsers');

// 上传
Route::post('/uploads_image', 'UploadsController@image');

// 模块
Route::get('/getModule', 'ModuleController@getModule');
Route::post('/addOrUpdateModule', 'ModuleController@addOrUpdateModule');
Route::get('/getModuleTreeSelect', 'ModuleController@getModuleTreeSelect');
Route::get('/getModulePermission', 'ModuleController@getModulePermission');
Route::post('/addModulePermission', 'ModuleController@addModulePermission');
Route::get('/getRoleMoudlePermission', 'ModuleController@getRoleMoudlePermission');
Route::get('/getUserModulePermission', 'ModuleController@getUserModulePermission');
