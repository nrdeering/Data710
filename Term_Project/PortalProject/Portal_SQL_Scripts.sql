-- create table species (
-- species_id VARCHAR(2) PRIMARY KEY,
-- genus VARCHAR(255),
-- species	VARCHAR(255),
-- taxa VARCHAR(255)
-- );
-- 
-- create table surveys (
-- record_id INT PRIMARY KEY,
-- month INT,
-- day	INT,
-- year INT,
-- plot_id	INT,
-- species_id INT,
-- sex	VARCHAR(1),
-- hindfoot_length INT,
-- weight INT
-- );
-- 
-- create table plots (
-- plot_id INT PRIMARY KEY,
-- plot_type VARCHAR(255)
-- );

-- 1.	Find all genus and species of the rodent taxa.
select distinct 
	species, 
	genus 
from species 
where taxa = 'Rodent';

-- 2.	Find all species (genus, species, and taxa) that were found by survey in 1987.
select distinct 
	species, 
	genus,
	taxa
from species sp
inner join surveys su
	on su.species_id = sp.species_id
where year = 1987;

-- 3.	Print hindfoot length and weight of all species found in “Long-term Krat Exclosure.”
select 
	hindfoot_length,
	weight,
	count(*) as survey_cnt
from surveys su
inner join plots p
	on p.plot_id = su.plot_id
where plot_type = 'Long-term Krat Exclosure'
group by 1,2
order by 3 desc
limit 5;

-- 4.	Find the dominant species in “Spectab exclosure.” What if you restrict to only 1998?
select  
	species, 
	count(distinct(record_id)) as species_cnt
from species sp
inner join surveys su
	on su.species_id = sp.species_id
-- 		and year = 1998
inner join plots p
	on p.plot_id = su.plot_id
		and plot_type = 'Spectab exclosure'
group by 1
order by 2 DESC
limit 5;