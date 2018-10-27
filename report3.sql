/*********************
Jeffrey Heredia
CS 325 - Fall 2017
last modified 2017.12.7
********************/

spool 325report3-result.sql

prompt
prompt this will show what champions low elo users percieve
prompt to be the strongest champions in the game per position
prompt as well as show what their actual win rate in that 
prompt rank actually is.

break on position skip 3
set linesize 50
set pagesize 100
ttitle "Percieved Strength in Bronze"

select		champ_name champion, position_name position,
		ban_rate "ban rate", win_rate "win rate"
from		patch
where		rank_name = 'bronze'
order by	position_name, ban_rate desc;


set linesize 80
set pagesize 14
clear break
ttitle off
spool of

