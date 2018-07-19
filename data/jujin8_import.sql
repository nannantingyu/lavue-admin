insert into jujin8.jujin8_economic_calendar (country,quota_name,publish_time,importance,former_value,predicted_value,published_value,influence,source_id,dataname,datename,dataname_id,unit,created_at,updated_at)
select country,quota_name,pub_time,importance,former_value,predicted_value,published_value,influence,source_id,dataname,datename,dataname_id,unit,created_time,updated_time
from crawl.crawl_economic_calendar;

insert into jujin8.jujin8_economic_event (country,time,city,importance,event,date,source_id,created_at,updated_at)
select country,time,city, importance,event,date,source_id,created_time,updated_time
from crawl.crawl_economic_event;

insert into jujin8.jujin8_economic_holiday (country,time,market,holiday_name,detail,date,source_id,created_at,updated_at)
select country,time,market,holiday_name,detail,date,source_id,created_time,updated_time
from crawl.crawl_economic_holiday;

insert into jujin8.jujin8_economic_jiedu (dataname_id,next_pub_time,pub_agent,pub_frequency,count_way,data_influence,data_define,funny_read,created_at,updated_at)
select dataname_id,next_pub_time,pub_agent,pub_frequency,count_way,data_influence,data_define,funny_read,created_time,updated_time
from crawl.crawl_economic_jiedu;

insert into jujin8.jujin8_cftc (cftc_name,net_long,net_short,publish_time,created_at,updated_at)
select cftc_name,net_long,net_short,publish_time,created_at,updated_at
from crawl.crawl_cftc;

insert into jujin8.jujin8_stock (publish_time,position,iod,type,created_at,updated_at)
select publish_time,position,iod,type,created_at,updated_at
from crawl.crawl_stock;

insert into jujin8.jujin8_fxssi (broker,pair,day,val,created_at,updated_at)
select broker,pair,day,val,created_at,updated_at
from crawl.crawl_fxssi;

insert into jujin8.jujin8_kuaixun (title,description,keywords,body,source_id,publish_time,importance,more_link,image,type,former_value,predicted_value,published_value,country,influnce,star,created_at,updated_at)
select '','','',body,dateid,publish_time,importance,more_link,image,type,former_value,predicted_value,published_value,country,influnce,star,created_time,updated_time
from crawl.crawl_jin10_kuaixun;

insert into jujin8.jujin8_kuaixun_block (source_id,title,description,keywords,body,source_site,publish_time,source_url,type,status,importance,image,link_name,link,created_at,updated_at)
select live_id,'','','',content,source,publish_time,source_url,type,status,grade,image,link_name,link,created_time,updated_time
from crawl.crawl_jinse_kuaixun;

insert into jujin8.jujin8_article(id,title,description,keywords,author,image,type,hits,url,recommend,state,favor,source_type,source_url,source_site,source_id,publish_time,created_at,updated_at)
select id,title,description,keywords,author,image,type,0,concat('read/', id, '.html'),0,1,0,'crawl',source_url,source_site,source_id,publish_time,created_time,updated_time
from crawl.crawl_article;

insert into jujin8.jujin8_article_body(aid,body,created_at,updated_at)
select id,body,created_time,updated_time
from crawl.crawl_article_body;