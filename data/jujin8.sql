/*
Navicat MySQL Data Transfer

Source Server         : jujin8admin
Source Server Version : 50722
Source Host           : 192.168.99.110:3306
Source Database       : jujin8

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-07-18 17:41:43
*/

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `jujin8_admin_module`;
CREATE TABLE `jujin8_admin_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '父模块',
  `name` varchar(32) NOT NULL COMMENT '名称',
  `path` varchar(32) NOT NULL COMMENT '路径',
  `sequence` int(11) NOT NULL COMMENT '排序',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `display` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

INSERT INTO `jujin8_admin_module` VALUES ('1', '0', '用户管理', 'user', '1', '1', '1', '2018-07-16 14:36:50', '2018-07-16 14:36:52');
INSERT INTO `jujin8_admin_module` VALUES ('2', '1', '添加角色', 'add-role', '1', '1', '1', '2018-07-16 14:54:49', '2018-07-16 14:54:52');
INSERT INTO `jujin8_admin_module` VALUES ('3', '1', '角色管理', 'role-user', '2', '1', '1', '2018-07-16 14:55:51', '2018-07-16 14:55:54');
INSERT INTO `jujin8_admin_module` VALUES ('4', '1', '权限管理', 'permission', '3', '1', '1', '2018-07-16 14:56:13', '2018-07-16 14:56:17');
INSERT INTO `jujin8_admin_module` VALUES ('5', '0', '模块管理', 'module', '2', '1', '1', '2018-07-16 15:29:30', '2018-07-16 15:29:33');
INSERT INTO `jujin8_admin_module` VALUES ('6', '1', '添加用户', 'add-user', '1', '1', '1', '2018-07-16 07:36:46', '2018-07-16 07:36:46');
INSERT INTO `jujin8_admin_module` VALUES ('7', '0', '文章管理', 'article', '1', '1', '1', '2018-07-16 08:07:03', '2018-07-16 08:07:03');
INSERT INTO `jujin8_admin_module` VALUES ('8', '7', '添加文章', 'article-edit', '1', '1', '1', '2018-07-16 08:07:29', '2018-07-16 12:04:38');
INSERT INTO `jujin8_admin_module` VALUES ('9', '0', '系统配置', 'config', '1', '1', '1', '2018-07-17 09:42:51', '2018-07-17 09:42:51');

DROP TABLE IF EXISTS `jujin8_admin_module_permission`;
CREATE TABLE `jujin8_admin_module_permission` (
  `module_id` smallint(6) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `entity_type` enum('role','user') NOT NULL DEFAULT 'role' COMMENT '实体类型',
  `permission` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jujin8_admin_module_permission` VALUES ('4', '1', 'role', '7');
INSERT INTO `jujin8_admin_module_permission` VALUES ('7', '1', 'role', '1');
INSERT INTO `jujin8_admin_module_permission` VALUES ('8', '1', 'role', '7');
INSERT INTO `jujin8_admin_module_permission` VALUES ('9', '1', 'role', '7');
INSERT INTO `jujin8_admin_module_permission` VALUES ('5', '1', 'role', '3');
INSERT INTO `jujin8_admin_module_permission` VALUES ('7', '2', 'role', '7');

DROP TABLE IF EXISTS `jujin8_admin_role`;
CREATE TABLE `jujin8_admin_role` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
  `state` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO `jujin8_admin_role` VALUES ('1', '超级管理员', '1', '2018-06-25 13:17:51', '2018-06-25 13:17:54');
INSERT INTO `jujin8_admin_role` VALUES ('2', '文章管理员', '1', '2018-07-17 11:31:16', '2018-07-17 11:31:16');

DROP TABLE IF EXISTS `jujin8_admin_role_user`;
CREATE TABLE `jujin8_admin_role_user` (
  `role_id` smallint(6) NOT NULL,
  `user_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jujin8_admin_role_user` VALUES ('1', '1');
INSERT INTO `jujin8_admin_role_user` VALUES ('2', '1');
INSERT INTO `jujin8_admin_role_user` VALUES ('3', '1');
INSERT INTO `jujin8_admin_role_user` VALUES ('4', '1');
INSERT INTO `jujin8_admin_role_user` VALUES ('1', '2');
INSERT INTO `jujin8_admin_role_user` VALUES ('2', '2');

DROP TABLE IF EXISTS `jujin8_article`;
CREATE TABLE `jujin8_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL COMMENT '文章标题',
  `description` varchar(512) DEFAULT NULL COMMENT '简介',
  `keywords` varchar(64) DEFAULT NULL COMMENT '关键词',
  `author` varchar(16) DEFAULT NULL COMMENT '作者',
  `image` varchar(512) DEFAULT NULL COMMENT '封面图',
  `type` varchar(32) DEFAULT NULL COMMENT '类型',
  `hits` int(11) NOT NULL DEFAULT '0' COMMENT '点击量',
  `url` varchar(256) DEFAULT NULL COMMENT '文章生成的链接',
  `recommend` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：1发布 0未发布',
  `favor` int(11) NOT NULL DEFAULT '0' COMMENT '点赞',
  `source_type` char(8) NOT NULL DEFAULT 'crawl' COMMENT '来源类型：crawl(爬虫), original(原创)',
  `source_url` varchar(256) DEFAULT NULL,
  `source_site` varchar(32) DEFAULT NULL COMMENT '来源网站',
  `source_id` char(32) DEFAULT NULL COMMENT '来源id',
  `publish_time` datetime NOT NULL COMMENT '发布时间',
  `created_at` datetime NOT NULL COMMENT '入库时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `jujin8_economic_event`;
CREATE TABLE `jujin8_economic_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '国家',
  `time` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '发布时间',
  `city` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '城市',
  `importance` tinyint(24) DEFAULT NULL COMMENT '重要性',
  `event` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '事件',
  `date` date DEFAULT NULL COMMENT '事件日期',
  `source_id` int(11) DEFAULT NULL COMMENT '源id',
  `created_at` datetime DEFAULT NULL COMMENT '入库时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_date` (`date`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_economic_holiday`;
CREATE TABLE `jujin8_economic_holiday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '国家',
  `time` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '公布时间',
  `market` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '市场',
  `holiday_name` varchar(24) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '假期名称',
  `detail` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '假期详情',
  `date` date DEFAULT NULL COMMENT '假期时间',
  `source_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL COMMENT '入库时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_date` (`date`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_economic_jiedu`;
CREATE TABLE `jujin8_economic_jiedu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataname_id` int(11) DEFAULT NULL,
  `next_pub_time` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '下次公布时间',
  `pub_agent` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '公布机构',
  `pub_frequency` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '公布频率',
  `count_way` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '统计方式',
  `data_influence` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '数据影响',
  `data_define` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '数据释义',
  `funny_read` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '趣味解读',
  `created_at` datetime DEFAULT NULL COMMENT '入库时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_dataname_id` (`dataname_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_forex_exchange`;
CREATE TABLE `jujin8_forex_exchange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abstractInfo` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '简介',
  `applyId` int(11) DEFAULT NULL COMMENT '-----',
  `applyTime` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `ascribe` char(2) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '名称首字母',
  `biggestLeverage` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '最大杠杆',
  `cName` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '中文名称',
  `checkOrNot` enum('NO','YES') CHARACTER SET utf8mb4 DEFAULT 'NO' COMMENT '-----',
  `checkedPass` varchar(8) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `checkedStatus` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '----',
  `companyName` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '公司名称（中英文）',
  `condition` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `createTime` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '创建时间',
  `degreeOfPraise` varchar(32) DEFAULT NULL COMMENT '-----',
  `depositMethod` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '出金方式',
  `eName` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '公司名称（英文）',
  `eaDeal` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'EA交易',
  `forexExchangeCommission` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `establishTime` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '成立时间',
  `gold` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `hedge` tinyint(4) DEFAULT NULL,
  `homeCountry` varchar(128) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL COMMENT '源id',
  `ids` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `intro` text CHARACTER SET utf8mb4 COMMENT '简介(html)',
  `licenseNo` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '监管机构No',
  `likeCount` int(11) DEFAULT NULL COMMENT '点赞数',
  `mainSpread` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '主要点差',
  `maxSpread` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '最大点差',
  `minSpread` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '最小点差',
  `officialBankAddress` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '官网bank地址',
  `officialWebsite` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '官网',
  `orgLicense` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `platformLogo` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '平台logo',
  `platStatus` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `platformIcon` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '平台icon',
  `platName` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '----',
  `platformStatus` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '----',
  `platformType` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '平台类型',
  `recommendOrNot` enum('YES','NO') CHARACTER SET utf8mb4 DEFAULT 'NO' COMMENT '是否推荐',
  `relevancy` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `scalp` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '剥头皮',
  `show` tinyint(4) DEFAULT NULL COMMENT '-----',
  `showPlatform` tinyint(4) DEFAULT NULL COMMENT '-----',
  `softwareInfo` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `sortNo` int(11) DEFAULT NULL COMMENT '排序',
  `source` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `spreadInfo` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `supervisionOrg` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '监管机构名称',
  `supervisionOrgName` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `surveyType` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '点差类型',
  `swap` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `synthesisScore` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '-----',
  `tradeVariety` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '交易品种',
  `tradingModel` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '交易模型',
  `trailingStop` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '移动止损',
  `withdrawMethod` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '入金方式',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2199 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `jujin8_forex_exchange_account`;
CREATE TABLE `jujin8_forex_exchange_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL COMMENT 'foreign_exchange的id',
  `trade_species` varchar(64) CHARACTER SET utf8mb4 NOT NULL COMMENT '交易品种',
  `main_spread` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '主要点差',
  `biggest_leverage` smallint(16) DEFAULT NULL COMMENT '最大杠杆',
  `explosion` tinyint(4) DEFAULT NULL COMMENT '爆仓比例',
  `lock_position` tinyint(4) DEFAULT NULL COMMENT '锁仓',
  `scalp` tinyint(4) DEFAULT NULL COMMENT '剥头皮',
  `min_withdraw` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '入金要求',
  `min_lots` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '最少手数',
  `spread_type` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL,
  `min_position` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '最小头寸',
  `ea` tinyint(4) DEFAULT NULL,
  `commission` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL,
  `account_type` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `jujin8_forex_exchange_interest`;
CREATE TABLE `jujin8_forex_exchange_interest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL COMMENT '外键 foreign_exchange-id',
  `symble` varchar(16) CHARACTER SET utf8mb4 NOT NULL COMMENT '符号',
  `currency` varchar(32) CHARACTER SET utf8mb4 NOT NULL COMMENT '交易对',
  `buy_interest` decimal(6,3) DEFAULT NULL COMMENT '买单利息',
  `sell_interest` decimal(6,3) DEFAULT NULL COMMENT '卖单利息',
  `buy_sell_diff` decimal(6,3) DEFAULT NULL COMMENT '买卖差额',
  `trade_time` datetime DEFAULT NULL COMMENT '交易时间',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_forex_exchange_soft`;
CREATE TABLE `jujin8_forex_exchange_soft` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL COMMENT '外键foreign_exchange-id',
  `soft_type` varchar(32) CHARACTER SET utf8mb4 NOT NULL COMMENT '软件类型',
  `soft_addr` varchar(256) CHARACTER SET utf8mb4 NOT NULL COMMENT '软件地址',
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `jujin8_forex_exchange_spread`;
CREATE TABLE `jujin8_forex_exchange_spread` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL COMMENT '外键foreign_exchange-id',
  `symble` varchar(16) CHARACTER SET utf8mb4 NOT NULL COMMENT '符号',
  `currency` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '货币对',
  `daily_spread` decimal(10,5) DEFAULT NULL COMMENT '日点差',
  `week_spread` decimal(10,5) DEFAULT NULL COMMENT '周均点差',
  `month_spread` decimal(10,5) DEFAULT NULL COMMENT '月均点差',
  `fee` decimal(10,5) DEFAULT NULL COMMENT '手续费',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_forex_exchange_withdraw`;
CREATE TABLE `jujin8_forex_exchange_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL COMMENT '外键foreign_exchage-id',
  `withdraw_way` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '入金方式',
  `deposit_way` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '出金方式',
  `withdraw_time` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '入金到账时间',
  `deposit_time` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '出金到账时间',
  `withdraw_fee` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '入金手续费',
  `deposit_fee` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '出金手续费',
  `withdraw_rate` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '入金费率',
  `deposit_rate` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '出金费率',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_fxssi`;
CREATE TABLE `jujin8_fxssi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `broker` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '交易商',
  `pair` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '交易对',
  `day` date DEFAULT NULL COMMENT '时间',
  `val` float DEFAULT NULL COMMENT '值',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_hot_banner`;
CREATE TABLE `jujin8_hot_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(256) DEFAULT NULL COMMENT '图片',
  `title` varchar(64) DEFAULT NULL COMMENT '标题',
  `link` varchar(256) DEFAULT NULL COMMENT '链接',
  `sequence` int(11) NOT NULL DEFAULT '0' COMMENT '顺序',
  `state` tinyint(4) NOT NULL COMMENT '状态',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_kuaixun`;
CREATE TABLE `jujin8_kuaixun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '标题',
  `description` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '描述',
  `keywords` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '关键词',
  `body` text CHARACTER SET utf8mb4 COMMENT '内容',
  `source_id` char(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '源id',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `importance` tinyint(6) DEFAULT NULL COMMENT '重要性',
  `more_link` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '更多链接',
  `image` varchar(256) DEFAULT NULL COMMENT '图片',
  `type` smallint(6) DEFAULT NULL COMMENT '类型',
  `former_value` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '前值',
  `predicted_value` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '预期值',
  `published_value` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL,
  `country` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '国家',
  `influnce` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '影响',
  `star` tinyint(6) DEFAULT NULL COMMENT '日历星级',
  `created_at` datetime DEFAULT NULL COMMENT '入库时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_publish_time` (`publish_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_kuaixun_block`;
CREATE TABLE `jujin8_kuaixun_block` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_id` int(11) DEFAULT NULL COMMENT '来源ID',
  `title` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL,
  `description` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '描述',
  `keywords` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '关键词',
  `body` text CHARACTER SET utf8mb4 COMMENT '内容',
  `source_site` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '来源网站',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `source_url` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '来源地址',
  `type` smallint(6) DEFAULT NULL COMMENT '类型',
  `status` smallint(6) DEFAULT NULL COMMENT '状态',
  `importance` smallint(6) DEFAULT NULL COMMENT '重要性',
  `image` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '图片',
  `link_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '链接名称',
  `link` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '链接地址',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_publish_time` (`publish_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_menu`;
CREATE TABLE `jujin8_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '菜单名称',
  `url` varchar(256) DEFAULT NULL COMMENT '链接',
  `target` enum('_blank','_self') DEFAULT NULL COMMENT '是否新页面打开 (_self|_blank)',
  `area` char(10) DEFAULT NULL COMMENT '区域',
  `sequence` smallint(6) DEFAULT NULL COMMENT '顺序',
  `state` tinyint(4) DEFAULT NULL COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

INSERT INTO `jujin8_menu` VALUES ('1', '首页', '/index', null, 'main', '10', '1', '2018-07-13 15:46:38', null);
INSERT INTO `jujin8_menu` VALUES ('2', '新闻', '/news', null, 'main', '9', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('3', '日历', '/calendar', null, 'main', '8', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('4', '下载中心', '/down', null, 'main', '7', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('5', '行情', '/quotes', null, 'main', '6', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('6', '关于我们', '/about', null, 'bottom', '10', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('7', '联系我们', '/contact', null, 'bottom', '9', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('8', '隐私声明', '/privacy', null, 'bottom', '8', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('9', '意见反馈', '/feedback', null, 'bottom', '7', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('10', '版权声明', '/copyright', null, 'bottom', '6', '1', null, null);
INSERT INTO `jujin8_menu` VALUES ('11', '快讯', '/live', null, 'main', '10', '1', '2018-07-17 15:49:33', '2018-07-17 15:49:36');
INSERT INTO `jujin8_menu` VALUES ('12', '机构', '/company', null, 'main', '8', '1', '2018-07-17 15:51:46', '2018-07-17 15:51:50');

DROP TABLE IF EXISTS `jujin8_migrations`;
CREATE TABLE `jujin8_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `jujin8_password_resets`;
CREATE TABLE `jujin8_password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `jujin8_stock`;
CREATE TABLE `jujin8_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_time` varchar(22) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '发布时间',
  `position` varchar(48) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '净持仓量',
  `iod` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '增减',
  `type` smallint(6) DEFAULT NULL COMMENT '类型 1：ETF黄金， 2：COMEX黄金，3：央行黄金储备， 4：ETF白银， 5：COMEX白银',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pubish_time_type` (`type`,`publish_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `jujin8_users`;
CREATE TABLE `jujin8_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `jujin8_users` VALUES ('1', 'admin', 'admin@jujin8.com', '$2y$10$jIZOESbMegpLttrHh6GVfempFi5ihmoTvB4jrp0a5eenGj6vagfXq', '管理员', '18551652502', 'fHkxXSLLi270sONKgYK9sb8JTvUu571GIGe2FATsYtrdoZ9GLf7KspJCERuF', '2018-07-16 06:07:01', '2018-07-16 06:07:01');
INSERT INTO `jujin8_users` VALUES ('2', 'user', 'user@jujin8.com', '$2y$10$su85BsSef5bWq2D2ravYbeX0nHj2t9.GRuM.zx0EHDowQOkAvXega', '用户', '18551652503', 'mYqkwioxT1Bcz0Vdr6gusLMlOIXPw9fdx5wzF7TnyxiblZIrdjcheDoLKT7f', '2018-07-16 07:48:18', '2018-07-16 07:48:18');


-- ----------------------------
-- Table structure for `jujin8_article_body`
-- ----------------------------
DROP TABLE IF EXISTS `jujin8_article_body`;
CREATE TABLE `jujin8_article_body` (
  `aid` int(11) NOT NULL COMMENT '关联article表的文章id',
  `body` text COMMENT '文章内容',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_cftc`;
CREATE TABLE `jujin8_cftc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cftc_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '名称',
  `net_long` int(11) DEFAULT NULL COMMENT '多头',
  `net_short` int(11) DEFAULT NULL COMMENT '空头',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `publish_time_end`  datetime DEFAULT NULL COMMENT '发布结束时间',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_publish_time_name` (`cftc_name`,`publish_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `jujin8_economic_calendar`;


CREATE TABLE `jujin8_economic_calendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '国家',
  `quota_name` varchar(512) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '指标名称',
  `publish_time` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '发布时间',
  `importance` tinyint(24) DEFAULT NULL COMMENT '重要性',
  `former_value` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '前值',
  `predicted_value` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '预期值',
  `published_value` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '公布值',
  `influence` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '影响',
  `source_id` int(11) DEFAULT NULL COMMENT '源id',
  `dataname` varchar(256) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '指标名称',
  `datename` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '指标时间',
  `dataname_id` int(11) DEFAULT NULL COMMENT '指标id, 关联jiedu表',
  `unit` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '单位',
  `created_at` datetime DEFAULT NULL COMMENT '入库时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_publish_time` (`publish_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `jujin8_category`;
CREATE TABLE `jujin8_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '分类名称',
  `ename` varchar(20) DEFAULT NULL COMMENT 'seo用，用于url显示',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sequence` int(11) NOT NULL DEFAULT '1' COMMENT '顺序',
  `target` enum('_self','_blank') DEFAULT '_self',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

INSERT INTO `jujin8_category` VALUES ('1', '最新', null, '0', '0', '_self', '1', '2018-07-16 10:17:12', '2018-07-16 10:17:12');
INSERT INTO `jujin8_category` VALUES ('2', '原油', 'yuanyou', '0', '1', '_blank', '1', '2018-07-16 10:14:32', '2018-07-16 10:14:37');
INSERT INTO `jujin8_category` VALUES ('3', '现货', 'xianhuo', '0', '2', '_blank', '1', '2018-07-16 10:16:49', '2018-07-16 10:16:53');
INSERT INTO `jujin8_category` VALUES ('4', '外汇', 'waihui', '0', '3', '_blank', '1', '2018-07-16 10:17:12', '2018-07-16 10:17:12');
INSERT INTO `jujin8_category` VALUES ('5', '贵金属', 'guijinshu', '0', '4', '_blank', '1', '2018-07-16 10:17:12', '2018-07-16 10:17:12');
INSERT INTO `jujin8_category` VALUES ('6', '股市', 'gushi', '0', '5', '_blank', '1', '2018-07-16 10:17:12', '2018-07-16 10:17:12');
INSERT INTO `jujin8_category` VALUES ('7', '行情', 'hangqing', '0', '6', '_blank', '1', '2018-07-16 10:17:12', '2018-07-16 10:17:12');
INSERT INTO `jujin8_category` VALUES ('8', '交易', 'trade', '0', '7', '_blank', '1', '2018-07-16 10:17:12', '2018-07-16 10:17:12');
INSERT INTO `jujin8_category` VALUES ('9', '关于我们', 'about', '0', '10', '_blank', '1', '2018-07-16 10:17:12', '2018-07-16 10:17:12');
INSERT INTO `jujin8_category` VALUES ('10', '联系我们', 'contact', '0', '1', '_blank', '1', '2018-07-17 13:35:06', '2018-07-17 13:35:10');
INSERT INTO `jujin8_category` VALUES ('11', '隐私声明', 'privacy', '0', '1', '_blank', '1', '2018-07-17 13:35:44', '2018-07-17 13:35:48');
INSERT INTO `jujin8_category` VALUES ('12', '版权声明', 'copyright', '0', '1', '_blank', '1', '2018-07-17 13:36:25', '2018-07-17 13:36:30');

DROP TABLE IF EXISTS `jujin8_category_banner`;
CREATE TABLE `jujin8_category_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '分类名称',
  `pid` int(11) NOT NULL COMMENT '父分类',
  `sequence` int(11) NOT NULL,
  `state` tinyint(4) NOT NULL COMMENT '状态',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_category_company`;
CREATE TABLE `jujin8_category_company` (
  `id` smallint(6) NOT NULL,
  `name` varchar(32) NOT NULL COMMENT '分类名称',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `sequence` smallint(6) NOT NULL DEFAULT '1' COMMENT '顺序',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jujin8_category_company` VALUES ('1', '贵金属', '1', '1', '2018-07-16 17:31:10', '2018-07-16 17:31:10');
INSERT INTO `jujin8_category_company` VALUES ('2', '原油', '1', '2', '2018-07-16 17:31:10', '2018-07-16 17:31:10');
INSERT INTO `jujin8_category_company` VALUES ('3', '现货', '1', '3', '2018-07-16 17:31:10', '2018-07-16 17:31:10');
INSERT INTO `jujin8_category_company` VALUES ('4', '区块链', '1', '4', '2018-07-16 17:31:10', '2018-07-16 17:31:10');


DROP TABLE IF EXISTS `jujin8_article_access_log`;
CREATE TABLE `jujin8_article_access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `aid` int(11) NOT NULL COMMENT '文章id',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `ip` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_article_category`;
CREATE TABLE `jujin8_article_category` (
  `aid` int(11) NOT NULL COMMENT '文章id',
  `cid` int(11) NOT NULL COMMENT '分类id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of jujin8_article_category
-- ----------------------------
INSERT INTO `jujin8_article_category` VALUES ('1', '4');
INSERT INTO `jujin8_article_category` VALUES ('1', '2');
INSERT INTO `jujin8_article_category` VALUES ('1', '3');
INSERT INTO `jujin8_article_category` VALUES ('2', '4');
INSERT INTO `jujin8_article_category` VALUES ('2', '5');
INSERT INTO `jujin8_article_category` VALUES ('3', '2');
INSERT INTO `jujin8_article_category` VALUES ('3', '4');
INSERT INTO `jujin8_article_category` VALUES ('4', '1');
INSERT INTO `jujin8_article_category` VALUES ('4', '3');
INSERT INTO `jujin8_article_category` VALUES ('5', '1');
INSERT INTO `jujin8_article_category` VALUES ('6', '1');
INSERT INTO `jujin8_article_category` VALUES ('6', '4');
INSERT INTO `jujin8_article_category` VALUES ('8', '2');
INSERT INTO `jujin8_article_category` VALUES ('9', '3');
INSERT INTO `jujin8_article_category` VALUES ('9', '4');
INSERT INTO `jujin8_article_category` VALUES ('10', '1');
INSERT INTO `jujin8_article_category` VALUES ('461', '9');
INSERT INTO `jujin8_article_category` VALUES ('462', '10');
INSERT INTO `jujin8_article_category` VALUES ('463', '11');
INSERT INTO `jujin8_article_category` VALUES ('464', '12');

DROP TABLE IF EXISTS `jujin8_banner`;
CREATE TABLE `jujin8_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 NOT NULL COMMENT '广告标题',
  `page` varchar(32) NOT NULL,
  `image` varchar(256) CHARACTER SET utf8mb4 NOT NULL COMMENT '图片',
  `link` varchar(256) CHARACTER SET utf8mb4 NOT NULL COMMENT '链接',
  `cid` int(4) NOT NULL COMMENT '分类',
  `hits` int(11) NOT NULL COMMENT '点击次数',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `sequence` tinyint(4) NOT NULL COMMENT '顺序',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_page` (`page`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `jujin8_comment`;
CREATE TABLE `jujin8_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL COMMENT '文章id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `ip` bigint(20) DEFAULT NULL,
  `comment` text COMMENT '评论',
  `state` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_company`;
CREATE TABLE `jujin8_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '公司名称',
  `shortname` varchar(16) DEFAULT NULL COMMENT '简称',
  `link` varchar(256) NOT NULL COMMENT '公司网址',
  `tag` varchar(64) DEFAULT NULL COMMENT '标签',
  `logo` varchar(256) DEFAULT NULL COMMENT '公司logo',
  `state` tinyint(4) DEFAULT NULL,
  `sequence` int(11) DEFAULT 1 COMMENT '顺序',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_company_category`;
CREATE TABLE `jujin8_company_category` (
  `cid` int(11) NOT NULL COMMENT '公司id',
  `ccid` smallint(6) NOT NULL COMMENT '公司分类id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `jujin8_config`;
CREATE TABLE `jujin8_config` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `key` char(32) NOT NULL COMMENT '键',
  `value` text NOT NULL,
  `sequence` smallint(6) NOT NULL DEFAULT '0' COMMENT '顺序',
  `group` varchar(32) DEFAULT '分组',
  `state` tinyint(4) NOT NULL COMMENT '状态',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of jujin8_config
-- ----------------------------
INSERT INTO `jujin8_config` VALUES ('1', 'name', '聚金数据', '10', 'jujin8', '1', '2018-07-16 11:25:00', '2018-07-18 03:42:06');
INSERT INTO `jujin8_config` VALUES ('2', 'icp', '京ICP备17055516号-3', '0', 'jujin8', '1', '2018-07-16 11:27:08', '2018-07-18 05:56:03');
INSERT INTO `jujin8_config` VALUES ('3', 'copyRight', 'Copyright © 2017 - 2018 All Rights Reserved', '0', 'jujin8', '1', '2018-07-16 11:28:24', '2018-07-18 05:56:04');
INSERT INTO `jujin8_config` VALUES ('4', 'imgServer', 'http://images.jujin8.com/', '0', 'jujin8', '1', '2018-07-16 11:30:05', '2018-07-18 05:55:05');
INSERT INTO `jujin8_config` VALUES ('5', 'logo', '/jujin8/images/logo.png', '0', 'jujin8', '1', '2018-07-16 11:33:04', '2018-07-18 05:04:59');
INSERT INTO `jujin8_config` VALUES ('6', 'allowLogin', '0', '0', 'jujin8', '1', '2018-07-16 11:33:48', '2018-07-18 03:53:08');
INSERT INTO `jujin8_config` VALUES ('7', 'articleFilter', 'about,contact,privacy,feedback,copyright', '0', 'other', '1', '2018-07-17 15:58:44', '2018-07-17 15:58:48');
INSERT INTO `jujin8_config` VALUES ('8', 'jiaoyisuo', '[{\"name\":\"上海黄金价格\",\"excode\":\"SGE\"},{\"name\":\"国际现货\",\"excode\":\"MT4\"},{\"name\":\"外汇\",\"excode\":\"FOREX\"}]', '0', 'jujin8', '1', '2018-07-18 15:27:32', '2018-07-18 15:27:37');
INSERT INTO `jujin8_config` VALUES ('9', 'marketKind', '[{\"name\":\"伦敦金\",\"code\":\"LLG\"},{\"name\":\"伦敦银\",\"code\":\"LLS\"},{\"name\":\"黄金延期\",\"code\":\"Au(T+D)\"},{\"name\":\"白银延期\",\"code\":\"Ag(T+D)\"},{\"name\":\"美元指数\",\"code\":\"USDX\"},{\"name\":\"欧元兑美元\",\"code\":\"EURUSD\"},{\"name\":\"美元兑日本\",\"code\":\"USDJPY\"},{\"name\":\"英镑兑美元\",\"code\":\"GBPUSD\"}]', '0', 'jujin8', '1', '2018-07-18 15:28:12', '2018-07-18 15:28:16');


DROP TABLE IF EXISTS `jujin8_fx678_economic_calendar`;
CREATE TABLE `jujin8_fx678_economic_calendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(64) DEFAULT NULL,
  `quota_name` varchar(512) DEFAULT NULL,
  `pub_time` varchar(32) DEFAULT NULL,
  `importance` varchar(24) DEFAULT NULL,
  `former_value` varchar(32) DEFAULT NULL,
  `predicted_value` varchar(32) DEFAULT NULL,
  `published_value` varchar(32) DEFAULT NULL,
  `influence` varchar(64) DEFAULT NULL,
  `source_id` varchar(32) DEFAULT NULL,
  `dataname` varchar(256) DEFAULT NULL,
  `datename` varchar(64) DEFAULT NULL,
  `dataname_id` int(11) DEFAULT NULL,
  `position` varchar(64) DEFAULT NULL,
  `unit` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_fx678_economic_event`;
CREATE TABLE `jujin8_fx678_economic_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(64) DEFAULT NULL,
  `time` varchar(512) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `importance` varchar(24) DEFAULT NULL,
  `event` varchar(32) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `source_id` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `jujin8_fx678_economic_holiday`;
CREATE TABLE `jujin8_fx678_economic_holiday` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(64) DEFAULT NULL,
  `time` varchar(512) DEFAULT NULL,
  `market` varchar(32) DEFAULT NULL,
  `holiday_name` varchar(24) DEFAULT NULL,
  `detail` varchar(256) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `source_id` varchar(32) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_fx678_kuaixun`;
CREATE TABLE `jujin8_fx678_kuaixun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_time` datetime DEFAULT NULL,
  `body` text,
  `time_detail` varchar(32) DEFAULT NULL,
  `importance` smallint(6) DEFAULT NULL,
  `more_link` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `former_value` varchar(32) DEFAULT NULL,
  `predicted_value` varchar(32) DEFAULT NULL,
  `published_value` varchar(32) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `influnce` varchar(64) DEFAULT NULL,
  `star` smallint(6) DEFAULT NULL,
  `source_id` varchar(10) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `jujin8_wallstreetcn_kuaixun`;
CREATE TABLE `jujin8_wallstreetcn_kuaixun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_time` datetime DEFAULT NULL,
  `body` text,
  `source_id` varchar(20) DEFAULT NULL,
  `importance` smallint(6) DEFAULT NULL,
  `more_link` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `former_value` varchar(32) DEFAULT NULL,
  `predicted_value` varchar(32) DEFAULT NULL,
  `published_value` varchar(32) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `influnce` varchar(64) DEFAULT NULL,
  `star` smallint(6) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for jujin8_block_coin
-- ----------------------------
DROP TABLE IF EXISTS `jujin8_block_coin`;
CREATE TABLE `jujin8_block_coin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coin_id` varchar(16) NOT NULL,
  `coin_name` varchar(16) NOT NULL COMMENT '币名称',
  `symble` varchar(16) NOT NULL COMMENT '代号',
  `state` tinyint(4) NOT NULL,
  `sequemce` int(11) NOT NULL COMMENT '顺序',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_coin_id` (`coin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for jujin8_block_finance
-- ----------------------------
DROP TABLE IF EXISTS `jujin8_block_finance`;
CREATE TABLE `jujin8_block_finance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coin_id` varchar(64) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_coin` (`coin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for jujin8_block_info
-- ----------------------------
DROP TABLE IF EXISTS `jujin8_block_info`;
CREATE TABLE `jujin8_block_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coin_id` varchar(64) NOT NULL COMMENT '英文编号-行情图查询使用',
  `symbol` varchar(64) DEFAULT NULL COMMENT '标识（BTC）',
  `cn_name` varchar(64) DEFAULT NULL COMMENT '中文名称',
  `en_name` varchar(64) DEFAULT NULL COMMENT '英文名称',
  `coin_name` varchar(32) DEFAULT NULL,
  `consensus` varchar(32) DEFAULT NULL,
  `finance_buy_usd` decimal(30,15) DEFAULT NULL,
  `finance_in_usd` decimal(30,15) DEFAULT NULL,
  `finance_sell_usd` decimal(30,15) DEFAULT NULL,
  `available_supply` varchar(30) DEFAULT NULL COMMENT '流通数量\n',
  `total_supply` varchar(30) DEFAULT NULL,
  `max_supply` varchar(30) DEFAULT NULL COMMENT '最大供给量',
  `available_price` decimal(30,15) DEFAULT NULL COMMENT '流通市值',
  `market_cap_usd` decimal(30,15) DEFAULT NULL,
  `volume_usd_24h` decimal(30,15) DEFAULT NULL COMMENT '成交额',
  `image` varchar(255) DEFAULT NULL COMMENT '货币图标',
  `release_time` char(11) DEFAULT NULL,
  `total_market_cap_usd` decimal(30,15) DEFAULT NULL,
  `trend_image` varchar(255) DEFAULT NULL COMMENT '趋势图片',
  `min_price_24h` decimal(30,15) DEFAULT NULL COMMENT '24小时最低',
  `max_price_24h` decimal(30,15) DEFAULT NULL COMMENT '24小时最高',
  `percent_change_1h` decimal(30,20) DEFAULT NULL,
  `percent_change_1m` decimal(30,20) DEFAULT NULL,
  `percent_change_1y` decimal(30,20) DEFAULT NULL,
  `percent_change_24h` decimal(30,20) DEFAULT NULL,
  `percent_change_3m` decimal(30,20) DEFAULT NULL,
  `percent_change_7d` decimal(30,20) DEFAULT NULL,
  `percent_change_all` decimal(30,20) DEFAULT NULL,
  `percent_change_today` decimal(30,20) DEFAULT NULL,
  `price_btc` decimal(30,20) DEFAULT NULL,
  `price_usd` decimal(30,20) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `volume_rank` int(11) DEFAULT NULL,
  `founder` varchar(64) DEFAULT NULL COMMENT '创建者',
  `forum` varchar(512) DEFAULT NULL,
  `ico_date` varchar(32) DEFAULT NULL COMMENT 'ico时间',
  `ico_price` varchar(32) DEFAULT NULL COMMENT 'ico价格',
  `ico_price_usd` varchar(32) DEFAULT NULL COMMENT 'ico价格美元',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `repository` varchar(255) DEFAULT NULL COMMENT 'github地址',
  `mineable` tinyint(4) DEFAULT NULL COMMENT '是否可以挖矿',
  `algorithm` varchar(32) DEFAULT NULL COMMENT '算法',
  `explorer` varchar(512) DEFAULT NULL COMMENT '网址',
  `websites` varchar(512) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_coin_id` (`coin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;