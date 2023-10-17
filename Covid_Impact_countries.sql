                                                   
												   
												                      -- ANALYSIS OF COVID IMPACT ON COUNTRIES IN 2020 ( Total cases and deaths )


SELECT *
  FROM [COVID_impact].[dbo].[COVID_impact_coutries]
----------------------------------------------------------------------------------------------------------


                                                                      -- OVERVIEW  

select sum(total_cases)
from COVID_impact_coutries -- total cases  3133760956

select sum(total_deaths)
from COVID_impact_coutries -- total deaths 116851104

select sum(cast(population as decimal(18,2)))
from COVID_impact_coutries -- total population across 210 coutries  - 2143572206036
----------------------------------------------------------------------------------------------------------


                                                                          --  DETAILED LOOK INTO STRINGENCY INDEX  --  



-- looking at avg stringency index by year, % of total cases by country, % of total death by country ( to see the affect of cases ans deaths on stringrency index across countries )
select  location,
avg (stringency_index) as avg_stringency_index_by_year,
sum(total_cases) as total_cases_by_countries,
sum(total_deaths) as total_deaths_by_countries
into dbo.stringency_index -- adding new table stringency index
from COVID_impact_coutries
group by location
order by avg_stringency_index_by_year desc


select *
from stringency_index


-- Creating BINS by stringency index( Histogram Distribution ) to see if stringrency index relevant to total cases and total deaths 
select 
'stringency index  93 - 69' as index_, count(location) as count_of_coutries ,
sum (total_cases_by_countries) as total_cases, sum(total_deaths_by_countries) as total_deaths
from stringency_index
where avg_stringency_index_by_year >= 69.6531675701888 and  avg_stringency_index_by_year < 93.4554900368979

union all

select 
'stringency index  69 - 56' as index_, count(location)  as count_of_coutries ,
sum (total_cases_by_countries) as total_cases, sum(total_deaths_by_countries) as total_deaths
from stringency_index
where avg_stringency_index_by_year >= 56.8452917685305 and  avg_stringency_index_by_year < 69.6531675701888

union all

select 
'stringency index  56 - 48' as index_, count(location) as count_of_coutries ,
sum (total_cases_by_countries) as total_cases, sum(total_deaths_by_countries) as total_deaths
from stringency_index
where avg_stringency_index_by_year >= 48.0718905278498 and  avg_stringency_index_by_year < 56.8452917685305

union all

select 
'stringency index  48 - 9' as index_, count(location) as count_of_coutries ,
sum (total_cases_by_countries) as total_cases, sum(total_deaths_by_countries) as total_deaths
from stringency_index
where avg_stringency_index_by_year >= 9.22911347057802 and  avg_stringency_index_by_year < 48.0718905278498
-- change of stringency index has certain affect on total cases and total deaths ( the lowest group of stringency index btw 48 - 9 has the lowest number of cases and deaths which is not 
-- fall into outcomes with others groups of index 



-- STDEV of total cases using previous stringency index groups ( STDEV will show variation of total cases during given period of time and given index group ) 
-- Relatively HIGH STDEV indicates on high variaity between number of total cases between given dates
-- Relatively LOW STDEV indicates opposite to HIGH 
select
(
select stdev(total_cases) as stdev_of_total_cases_9__48_index
from COVID_impact_coutries
where stringency_index  between 9.22911347057802 and 48.0718905278498
) as stdev_of_total_cases_9__48_index,
(
select  stdev(total_cases) as stdev_of_total_cases_48__56_index
from COVID_impact_coutries
where stringency_index  between 48.0718905278498 and 56.8452917685305
) as stdev_of_total_cases_48__56_index,
(
select  stdev(total_cases) as stdev_of_total_cases_56__69_index
from COVID_impact_coutries
where stringency_index  between 56.8452917685305 and 69.6531675701888
) as stdev_of_total_cases_56__69_index,
(
select  stdev(total_cases) as stdev_of_total_cases_69__93_index
from COVID_impact_coutries
where stringency_index  between 69.6531675701888 and 93.4554900368979
) as stdev_of_total_cases_69__93_index

--   689091.9    stdev_of_total_cases_56__69_index
--   426191.4    stdev_of_total_cases_69__93_index
--   102068.4    stdev_of_total_cases_48__56_index
--    94029.6    stdev_of_total_cases_9__48_index


-- Stringency Index group 56 - 48 has show the highest value based on  calculation :
      --  Creating BINS by stringency index( Histogram Distribution ) to see if stringrency index relevant to total cases and total deaths 
	  --  STDEV of total cases using previous stringency index groups ( STDEV will show variation of total cases during given period of time and given index group ) 
 



 -----------------------------------------------------------------------------------------------------------------------------------------
 select sum(total_cases) as tot_cases, sum(total_deaths) as tot_deaths 
 from COVID_impact_coutries
 

 -- % of total cases and deaths by quarter
  select quarter, sum(total_cases) / 3133760956.0000000000 * 100 as percent_of_total_cases,
  sum(total_deaths) / 116851104.0000000000 * 100 as percent_of_total_deaths
  from COVID_impact_coutries
  group by quarter


   -- % of total cases and deaths by month
   select month, sum(total_cases) / 3133760956.0000000000 * 100 as percent_of_total_cases,
  sum(total_deaths) / 116851104.0000000000 * 100 as percent_of_total_deaths
  from COVID_impact_coutries
  group by month


  




