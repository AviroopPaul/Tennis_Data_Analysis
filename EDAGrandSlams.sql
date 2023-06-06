SELECT * FROM tennis.mens_tennis_grand_slam_winner;

select count(*) as totalMatches from mens_tennis_grand_slam_winner;

#total no of grandslam winners 
select count( distinct(WINNER)) as totalWinners from mens_tennis_grand_slam_winner;

#total no of wins per player
select WINNER, count(WINNER) as totalWins 
from mens_tennis_grand_slam_winner 
group by WINNER order by totalWins desc;

#each type of surface
select distinct(TOURNAMENT_SURFACE) from mens_tennis_grand_slam_winner;

#most used surface
select TOURNAMENT_SURFACE, COUNT(TOURNAMENT_SURFACE) as MostUsedSurface 
from mens_tennis_grand_slam_winner 
group by TOURNAMENT_SURFACE order by MostUsedSurface desc;

#total tournament money grouped by year INTERESTING DATA
select YEAR, SUM(WINNER_PRIZE) as TotalPrizeMoney from mens_tennis_grand_slam_winner 
group by YEAR order by TotalPrizeMoney desc;

#most wins by player on each surface type
select WINNER, TOURNAMENT_SURFACE, count(WINNER) as Wins from mens_tennis_grand_slam_winner 
group by WINNER,TOURNAMENT_SURFACE 
order by Wins desc;

#most wins by player on each tournament and tournament surface
select WINNER, TOURNAMENT, TOURNAMENT_SURFACE, count(WINNER) as Wins from mens_tennis_grand_slam_winner 
group by WINNER,TOURNAMENT, TOURNAMENT_SURFACE 
order by Wins desc LIMIT 10;

#most prize money by winner

select WINNER, SUM(WINNER_PRIZE) as lifetimePrizeMoney from mens_tennis_grand_slam_winner 
group by WINNER order by lifetimePrizeMoney desc;

#most Runner-UPs

select `RUNNER-UP`, count(*) AS finals from mens_tennis_grand_slam_winner group by `RUNNER-UP`
order by finals DESC;

#winners and opponents 
select `RUNNER-UP`, WINNER, count(*) as headtohead from mens_tennis_grand_slam_winner 
group by `RUNNER-UP`, WINNER order by headtohead desc;

#total final appearances of all players using subquery

select playerName, count(*) as totalAppearances from
(
select WINNER as playerName from mens_tennis_grand_slam_winner
union all #merges both the names from winner and runner up into playerName
select `RUNNER-UP` as playerName from mens_tennis_grand_slam_winner
) as subquery  
group by playerName order by totalAppearances desc;

#top tennis player before the year 1990-2000

select WINNER as PlayerName, count(*) as wins, TOURNAMENT  from mens_tennis_grand_slam_winner 
where YEAR<2010 and year>2000 group by PlayerName, TOURNAMENT order by wins desc;

#players for particulur Tournament wins

select WINNER, count(*) as wins from mens_tennis_grand_slam_winner
where
TOURNAMENT='U.S. Open' 
group by WINNER
order by wins desc;

#most wins by handedness

select WINNER, count(*)as wins, WINNER_LEFT_OR_RIGHT_HANDED from mens_tennis_grand_slam_winner 
where WINNER_LEFT_OR_RIGHT_HANDED='right'
group by WINNER, WINNER_LEFT_OR_RIGHT_HANDED order by wins desc;

#most wins by country

select WINNER_NATIONALITY, count(*) as wins from mens_tennis_grand_slam_winner
group by WINNER_NATIONALITY order by wins desc;

#most wins by players of each country

select WINNER, WINNER_NATIONALITY, count(*) as wins
from mens_tennis_grand_slam_winner
group by WINNER_NATIONALITY, WINNER
having wins=
(
	select max(winCount) from (

		select WINNER_NATIONALITY as country, WINNER, count(*) as winCount from mens_tennis_grand_slam_winner
		group by country, WINNER
	
    )as subquery

	where country=WINNER_NATIONALITY
)
order by WINNER_NATIONALITY;

#most played surface based on year range

select TOURNAMENT_SURFACE, count(*) as matches 
from
mens_tennis_grand_slam_winner
where year>2010
group by TOURNAMENT_SURFACE
order by matches desc;










