/***************************
Jeffrey Heredia
CS 325 Fall 2017
last modified 2017.12.7
***************************/

spool 325query-results.txt

prompt
prompt Jeffrey Heredia
prompt

prompt query 1 using a join
prompt This query will let the user see 
prompt the details from match_up but 
prompt still be able to view the winner 
prompt as well as the game length

select 	game.game_id, game.region, game.elo, game.winner, game.game_length,
	match_up.champ_name, match_up.position_name, match_up.banned_champ,
	match_up.cs_total, match_up.gold_diff_at_15, match_up.kills,
	match_up.deaths, match_up.assists
from 	game, match_up
where	game.game_id = match_up.game_id;

prompt
prompt query 2 using a nested loop
prompt this will show the average gold difference
prompt at the 15 minute mark
prompt for champions with the highest win rates
prompt this is useful to the user because it helps show
prompt if the trends overall game style are shifting towards
prompt early game advantage aggressive play, or if it is
prompt shifting towards late game 5v5 team fights

select	gold_diff_at_15
from	match_up
where	champ_name in 
		(select	champ_name
		 from	patch
		 where	win_rate in
			(select win_rate
			 from 	patch
			 where win_rate >53))
order by gold_diff_at_15 desc;

prompt
prompt query 3 using an aggregate function
prompt this will show the average game length
prompt slightly different purpose than query 2
prompt instead of showing what the shifting trend is
propmt this one will show if the game currently 
propmt favors aggressive early games or 5v5 team fightus

col avg_game_time format 99.9
select	avg(game_length) "avg_game_time"
from	game;

prompt
prompt query 4 using a compound where clause
prompt this query will let the user see champions
prompt that have a high win rate in higher elo
prompt as well as a reasonably low combinate of
prompt play rate + win rate
prompt This will allow the user to pick champions that
prompt both do not have a ceiling and can be played regularly
prompt as a main champion


select		champ_name champion, position_name position,
		win_rate "win rate",
		ban_rate + play_rate "% of games unavailable"
from		patch
where		rank_name in ('diamond', 'master', 'challenger')
		and win_rate >= 55
		and ban_rate + play_rate <= 5
order by	position_name, ban_rate + play_rate;

prompt
prompt query 5
prompt this will show the user the average 
prompt win rats of a champion across all ranks

set pagesize 100
break on champion skip 1
compute avg of win_rate on champion

select		champ_name champion, position_name position, win_rate
from		patch
order by 	champion;

clear break

prompt
prompt query 6 
prompt some users like to have high a high kda because
prompt it makes them feel like they are carrying
prompt this table will show users which champions 
prompt have the best kda in high elo play

select 	champ_name champion, position_name position, avg_kda kda
from	patch
where	rank_name = 'master'
order	by position_name, avg_kda desc;

prompt query 7
prompt this query will show what champions have
prompt the highest gold difference at 15 minutes in bronze
prompt this will inform the user what champions are most
prompt impactful early game in low elo

select	champ_name champion, position_name position,
	gold_diff_at_15 "gold difference"
from	match_up
where	elo = 'bronze'
order by gold_diff_at_15 desc;

prompt
prompt query 8
prompt this will show what champions low elo users percieve 
prompt to be the strongest champions in the game
prompt ordered by position

break on position skip 3

select	champ_name champion, position_name position,
	ban_rate "ban rate", win_rate "win rate"
from 	patch
where	rank_name = 'bronze'
order by position_name, ban_rate desc;

clear break


spool off
