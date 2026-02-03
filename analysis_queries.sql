--SQL Advance Case Study


--Q1--BEGIN 
	
--	1. List all the states in which we have customers who have bought cellphones
--from 2005 till today. 

select distinct l.state from fact_transactions as f join dim_location as l on f.idlocation = l.idlocation
where f.[date] >= '2005-01-01'  and f.[date]<=(select max(date) from fact_transactions)

--Q1--END

--Q2--BEGIN
	
--What state in the US is buying the most 'Samsung' cell phones? 

select Top 1 l.[state] from dim_location as l join fact_transactions as t on l.idlocation = t.idlocation
join dim_model as m on t.idmodel = m.idmodel join dim_manufacturer as f on
f.idmanufacturer = m.idmanufacturer where f.manufacturer_name = 'Samsung' and l.country = 'US'
group by l.[state] order by count(f.manufacturer_name) desc

--Q2--END

--Q3--BEGIN      
	

--3. Show the number of transactions for each model per zip code per state. 

select m.model_name as [Model],l.state,l.zipcode,count(t.idmodel) as [No. of Transactions per Model] from 
dim_location as l join fact_transactions as t on l.idlocation = t.idlocation
join dim_model as m on m.idmodel = t.idmodel group  by m.model_name,l.state,l.zipcode

--Q3--END

--Q4--BEGIN

--4. Show the cheapest cellphone (Output should contain the price also)

select Model_name,Unit_price from dim_model where unit_price = (select min(unit_price) from dim_model)

--Q4--END

--Q5--BEGIN

--5. Find out the average price for each model in the top5 manufacturers in
--terms of sales quantity and order by average price

select m.model_name,avg(unit_price) [Average Unit Price]  from dim_model as m join dim_manufacturer as f on 
m.idmanufacturer = f.idmanufacturer
where  f.manufacturer_name in (select top 5 f.manufacturer_name from fact_transactions as t join dim_model as m on 
t.idmodel = m.idmodel join dim_manufacturer as f on m.idmanufacturer = f.idmanufacturer group by 
f.manufacturer_name order by sum(t.quantity) desc ) group by f.idmanufacturer,m.model_name order by avg(unit_price)

--Q5--END

--Q6--BEGIN


--6. List the names of the customers and the average amount spent in 2009,
--where the average is higher than 500

select c.customer_name,avg(totalprice) as [Amount Spent] from dim_customer as c join fact_transactions as t on  
c.idcustomer = t.idcustomer where t.[date]>='2009-01-01' and t.[date]<='2009-12-31'  
group by c.idcustomer,c.customer_name having avg(totalprice)>500

--Q6--END
	
--Q7--BEGIN  
	
	
--7. List if there is any model that was in the top 5 in terms of quantity,
--simultaneously in 2008, 2009 and 2010 

select model_name from (select Top 5 m.model_name from dim_model as m join fact_transactions as t on m.idmodel = t.idmodel 
join dim_date as d on d.[date] = t.[date] where d.year = 2008
group by m.model_name order by sum(t.quantity) desc) a
Intersect
select model_name from (select Top 5 m.model_name from dim_model as m join fact_transactions as t on m.idmodel = t.idmodel 
join dim_date as d on d.[date] = t.[date] where d.year = 2009
group by m.model_name order by sum(t.quantity) desc) b
Intersect
select model_name from (select Top 5 m.model_name from dim_model as m join fact_transactions as t on m.idmodel = t.idmodel 
join dim_date as d on d.[date] = t.[date] where d.year = 2010
group by m.model_name order by sum(t.quantity) desc) c

--Q7--END	
--Q8--BEGIN


--8. Show the manufacturer with the 2nd top sales in the year of 2009 and the
--manufacturer with the 2nd top sales in the year of 2010. 

select Manufacturer_Name, [Year] from (select f.manufacturer_name,sum(TotalPrice) [price], DENSE_RANK() 
over(partition by d.year order by sum(TotalPrice) desc ) [Rank],d.year 
from dim_date as d join fact_transactions as t on d.date = t.date
join dim_model as m on t.idmodel = m.idmodel join dim_manufacturer as f on f.idmanufacturer = m.idmanufacturer
where d.year in (2009,2010) group by f.idmanufacturer,f.manufacturer_name,d.year) a where [rank] = 2

--Q8--END
--Q9--BEGIN
	
--9. Show the manufacturers that sold cellphones in 2010 but did not in 2009. 

select distinct f.Manufacturer_Name from DIM_DATE as d join FACT_TRANSACTIONS as t on d.[date] = t.[date] join DIM_MODEL as m on
t.IDModel = m.IDModel join DIM_MANUFACTURER as f on m.IDManufacturer = f.IDManufacturer where d.YEAR = 2010
Except
select distinct f.Manufacturer_Name from DIM_DATE as d join FACT_TRANSACTIONS as t on d.[date] = t.[date] join DIM_MODEL as m on
t.IDModel = m.IDModel join DIM_MANUFACTURER as f on m.IDManufacturer = f.IDManufacturer where d.YEAR = 2009

--Q9--END

--Q10--BEGIN
	

--10. Find top 100 customers and their average spend, average quantity by each
--year. Also find the percentage of change in their spend. 

with cte1 as (select c.IDCustomer as [IDCustomer],c.Customer_Name,avg(TotalPrice) as [Average Spend],avg(Quantity) as [Average Quantity],d.year
from DIM_CUSTOMER as c join FACT_TRANSACTIONS as t on c.IDCustomer = t.IDCustomer
join DIM_DATE as d on t.date = d.date where c.IDCustomer in (select Top 100 c.idcustomer from DIM_CUSTOMER as c join FACT_TRANSACTIONS as t on
c.IDCustomer = t.IDCustomer
join DIM_DATE as d on t.date = d.date group by c.IDCustomer order by sum(TotalPrice) desc) group by c.IDCustomer,c.Customer_Name,d.year)

select Customer_Name, [Average Spend], [Average Quantity],[year],
case when (lag([Average Spend]) over(partition by [IDCustomer] order by [year])) is null then 0
else ([Average Spend] - lag([Average Spend]) over(partition by [IDCustomer] order by [year]))*100/lag([Average Spend]) 
over(partition by [IDCustomer] order by [year])
end as [% Change]
from cte1


--Q10--END
	