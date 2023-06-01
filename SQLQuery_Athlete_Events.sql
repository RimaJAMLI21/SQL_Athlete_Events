--Create database athlete_events;
use athlete_events;

/*
Downloading Data from Kaggle
https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results
Loading dataset to SQL Server /PostgreSQL /....Database:
         
*/

select * from athlete_events;
select * from noc_regions;
                        

						--Queries--

---- How many olympics games have been held?

select count(distinct Games) as total_olympic_games
from athlete_events;

----List down all Olympics games held so far.

select distinct Year, Season, city
from athlete_events 
order by Year;

----Mention the total no of nations who participated in each olympics game
with all_countries as
			(select Games, nr.region
			 from athlete_events ae
			 join noc_regions nr on ae.NOC = nr.NOC
			 group by Games, nr.region)

select Games, 
       count(1) as Total_countries
from all_countries
group by Games
order by Games;

----Which year saw the highest and lowest no of countries participating in olympics:

with all_countries as
			(select Games, nr.region
			from athlete_events ae
			join noc_regions nr on nr.NOC = ae.NOC
			group by Games, nr.region),
	tot_countries as
	        (select Games, count(1) as total_countries
			 from all_countries
			 group by Games)


select distinct 
concat(first_value(Games) over (order by total_countries),
'-',
first_value(total_countries) over (order by total_countries)) as Lowest_Countries,

concat(first_value(Games) over (order by total_countries desc),
'-',
first_value(total_countries) over (order by total_countries desc)) as Highest_Countries

from tot_countries

order by 1;

----Which nation has participated in all of the olympic games

with tot_games as 
              (select count(distinct Games) as Total_games
			   from athlete_events),

	 countries as
	          (select Games,
			          nr.region as Country
			   from athlete_events ae
			   join noc_regions nr on nr.NOC = ae.NOC
			   group by Games, nr.region),

	countries_participated as
				(select Country, 
				count(1) as total_part_games
				from countries
				group by Country)

select cp.*
from countries_participated cp
join tot_games tg on tg.Total_games = cp.total_part_games
order by 1;










----Identify the sport which was played in all summer olympics.


----Which Sports were just played only once in the olympics?


----Fetch the total no of sports played in each olympic games.


----Fetch details of the oldest athletes to win a gold medal.


----Find the Ratio of male and female athletes participated in all olympic games.


----Fetch the top 5 athletes who have won the most gold medals.


----Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).


----Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.


----List down total gold, silver and broze medals won by each country.


----List down total gold, silver and broze medals won by each country corresponding to each olympic games.


----Identify which country won the most gold, most silver and most bronze medals in each olympic games.


----Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.


----Which countries have never won gold medal but have won silver/bronze medals?


----In which Sport/event, India has won highest medals.


----Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.
