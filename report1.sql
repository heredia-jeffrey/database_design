/**************************
Jeffrey Heredia
CS 325 - Fall 2017
last modified 2017.12.7
************************/

spool 325report1-results.txt

set linesize 1000
prompt
prompt This query will let the user see the details from match_up
prompt but also include the length of the game in question 

ttitle "detailed match up"

select		game.game_id "Game ID", game.region "Region", 
		game.elo "Rank", game.game_length "Length of Game",
		match_up.champ_name "Champion", 
		match_up.position_name "Position", 
		match_up.banned_champ "Champion Banned",
		match_up.cs_total "CS", 
		match_up.gold_diff_at_15 "Early Gold Difference",
		match_up.kills "Kills", match_up.deaths "Deaths",
		match_up.assists "assists"
from		game, match_up
where		game.game_id = match_up.game_id
order by	game.game_id, match_up.position_name;

set linesize 80

spool off
