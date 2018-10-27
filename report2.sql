/********************
Jeffrey Heredia
CS 325 - Fall 2017
last modified 2017.12.7
**********************/

spool 325report2-result.txt

prompt
prompt This will let the user see champions 
prompt that have a hgih win rate in higher elo
prompt as well as a reasonably low combination of 
prompt play rate and win rate. This will allow the
prompt user to pick a champion that doesnt have a ceiling 
prompt as well as can be played regularly as a main

ttitle "possible champions to main"

select		champ_name champion, position_name position,
		win_rate "win rate",
		ban_rate + play_rate "% of games unavailable"
from		patch
where		rank_name in ('diamond', 'master', 'challenger')
		and win_rate >= 55
		and ban_rate + play_rate <= 5
order by	position_name, ban_rate + play_rate;

ttitle off

spool off
