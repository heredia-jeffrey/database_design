/**************************
Jeffrey Heredia
CS 325 - Fall 2017
last modified 2017.11.11
**************************/


/*=========
	this table holds all the possible ranks in league
========*/


drop table rank cascade constraints;

create table rank
(rank_name	varchar2(10) check(rank_name in ('bronze' , 'silver',
 		'gold','plat', 'diamond', 'master', 'challenger'))
		not null,
 primary key (rank_name)
);


/*=========
	this table holds a list of possible positions
=========*/

drop table position cascade constraints;

create table position
(position_name	varchar2(10)	check(position_name in ('top',
			'mid', 'jungle', 'bot', 'sup')),
 primary key (position_name)
);

/*=========
	this table hold a list of players and their rank
=========*/

drop table player cascade constraints;

create table player
(user_name	varchar2(16)	not null,
 region		varchar2(10)	not null,
 rank		varchar2(10),
 primary key (user_name, region),
 foreign key (rank) references rank (rank_name)
);

/*==========
	this table holds the emails of players
	players can have multiple emails
==========*/

drop table player_email cascade constraints;

create table player_email
(user_name	varchar2(16)	not null,
 region		varchar2(10)	not null,
 email		varchar2(30)	not null,
 primary key (user_name,region,email),
 foreign key (user_name,region) references player (user_name,region)
);

/*========
	this table provides a list of all the champions 
	currently in the game
=======*/

drop table champion cascade constraints;

create table champion
(champ_name	varchar2(15)	not null,
 primary key (champ_name)
);


/*=======
	this table is an index of every ranked game played
=======*/

drop table game cascade constraints;

create table game
(game_id	integer 	not null,
 region		varchar2(10)	not null,
 elo		varchar2(10),
 winner		varchar2(5)	check(winner in ('blue', 'red', 'draw')),
 game_length	integer,
 primary key (game_id, region,elo),
 foreign key (elo) references rank (rank_name) 
);

/*=======
	this table is where game, and player meet are 
	assigned roles for their game. There is a blue 
	team "b" and a red team "r". There are positions
	top, mid, jungle, bot, support. Everything labeled
	player is the username of the person, where the others
	are the champion name, game id and server.
=======*/

drop table team_comp cascade constraints;

create table team_comp
(game_id		integer		not null,
 region			varchar2(10)	not null,
 elo			varchar2(10)	not null,
 b_top_player		varchar2(16)	not null,
 b_mid_player		varchar2(16)	not null,
 b_jungle_player	varchar2(16)	not null,
 b_bot_player		varchar2(16)	not null,
 b_sup_player		varchar2(16)	not null,
 b_top			varchar2(15)	not null,
 b_mid			varchar2(15)	not null,
 b_jungle		varchar2(15)	not null,
 b_bot			varchar2(15)	not null,
 b_sup			varchar2(15)	not null,
 r_top_player		varchar2(15)	not null,
 r_mid_player		varchar2(16)	not null,
 r_jungle_player	varchar2(16)	not null,
 r_bot_player		varchar2(16)	not null,
 r_sup_player		varchar2(16)	not null,
 r_top			varchar2(15)	not null,
 r_mid			varchar2(15)	not null,
 r_jungle		varchar2(15)	not null,
 r_bot			varchar2(15)	not null,
 r_sup			varchar2(15)	not null,
 primary key (game_id, region,elo),
 foreign key (game_id,region,elo) references game (game_id,region,elo),
 foreign key (b_top_player,region) references player (user_name,region),
 foreign key (b_mid_player,region) references player (user_name,region),
 foreign key (b_jungle_player,region) references player (user_name,region),
 foreign key (b_bot_player,region) references player (user_name,region),
 foreign key (b_sup_player,region) references player (user_name,region),
 foreign key (B_top) references champion (champ_name),
 foreign key (b_mid) references champion (champ_name),
 foreign key (b_jungle) references champion (champ_name),
 foreign key (b_bot) references champion (champ_name),
 foreign key (b_sup) references champion (champ_name),
 foreign key (r_top_player,region) references player (user_name,region),
 foreign key (r_mid_player,region) references player (user_name,region),
 foreign key (r_jungle_player,region) references player (user_name,region),
 foreign key (r_bot_player,region) references player (user_name,region),
 foreign key (r_sup_player,region) references player (user_name,region),
 foreign key (r_top) references champion (champ_name),
 foreign key (r_mid) references champion (champ_name),
 foreign key (r_jungle) references champion (champ_name),
 foreign key (r_bot) references champion (champ_name),
 foreign key (r_sup) references champion (champ_name)
);


/*==========
	this table contains informatin about the individual
	match ups for this game (e.g. the two mid laners) and
	how they performed in this match up.
==========*/

drop table match_up cascade constraints;

create table match_up
(game_id		integer		not null,
 region			varchar2(10)	not null,
 elo			varchar2(10)	not null,
 champ_name		varchar2(15) 	not null,
 position_name		varchar2(10)	not null,
 banned_champ		varchar2(15),
 cs_total		integer,
 gold_diff_at_15	integer,
 kills			integer,
 deaths			integer,
 assists		integer,
 primary key (game_id, region, champ_name,position_name,elo),
 foreign key (game_id,region,elo) references game (game_id,region,elo),
 foreign key (champ_name) references champion (champ_name),
 foreign key (position_name) references position (position_name)
);


/*========
	this table contains information on individual
	item builds for a specific match. item1-6 references 
	completed items built by player.
=========*/

drop table item cascade constraints;

create table item
(game_id	integer		not null,
 region		varchar2(10)	not null,
 champ_name	varchar2(15)	not null,
 elo		varchar2(10)	not null,
 position_name	varchar2(10)	not null,
 item1		varchar2(20),
 item2		varchar2(20),
 item3		varchar2(20),
 item4		varchar2(20),
 item5		varchar2(20),
 item6		varchar2(20),
 primary key (game_id, region, champ_name, elo,position_name),
 foreign key (game_id, region,elo) references game (game_id, region, elo),
 foreign key (champ_name) references champion (champ_name),
 foreign key (position_name) references position (position_name)
);


/*===========
	this table contains information on trends
	of each champion across all games. It is has
	running averages of iformation in both match_up
	and item tables. When each new patch is released 
	the averages are stopped and then started over. kda 
	a league stat that is (kill+assists)/deaths. Core
	is the name of the 2 most built items.
===========*/

drop table patch cascade constraints;

create table patch
(patch_num	decimal(3,2)	not null,
 champ_name	varchar2(15)	not null,
 rank_name	varchar2(10) 	not null,
 position_name	varchar2(10)	not null,
 win_rate	integer,
 play_rate	decimal(4,2),
 ban_rate	decimal(4,2),
 avg_cs		integer,
 avg_kda	decimal(4,2),
 core		varchar2(30),
 primary key (patch_num, champ_name, rank_name, position_name),
 foreign key (champ_name) references champion (champ_name),
 foreign key (rank_name) references rank (rank_name),
 foreign key (position_name) references position (position_name)
);


