/****************************
Jeffrey Heredia
CS 325 - Fall 2017
last modified 2017.11.28
***************************/

spool 325result-contents.txt

set linesize 1000
set pagesize 50

prompt
prompt Displaying table rank
prompt

select *
from rank;

prompt
prompt Displaying table position
prompt

select *
from position;

prompt
prompt Displaying table player
prompt

select *
from player;

prompt
prompt Displaying table player_email
prompt

select *
from player_email;

prompt
prompt Displaying table champion
prompt

select *
from champion;

prompt
prompt Displaying table game
prompt
select * 
from game;

prompt
prompt Displaying table team_comp
prompt

col b_top_player heading bt_user format a7
col b_mid_player heading bm_user format a7
col b_jungle_player heading bj_user format a7
col b_bot_player heading bb_user format a7
col b_sup_player heading bs_user format a7

col r_top_player heading rt_user format a7
col r_mid_player heading rm_user format a7
col r_jungle_player heading rj_user format a7
col r_bot_player heading rb_user format a7
col r_sup_player heading rs_user format a7

col b_top format a7
col b_mid format a7
col b_jungle format a7
col b_bot format a7
col b_sup format a7

col r_top format a7
col r_mid format a7
col r_jungle format a7
col r_bot format a7
col r_sup format a7

select *
from team_comp;

prompt
prompt Displaying table match_up
prompt

select *
from match_up;

prompt
prompt Displaying table item
prompt

select *
from item;

prompt
prompt Displaying table patch
prompt

select *
from patch;

spool off
