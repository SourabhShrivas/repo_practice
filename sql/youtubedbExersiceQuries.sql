USE youtube_db;
select * from Calendar_lookup
select * from [dbo].[acct_lookup]
select * from [dbo].[Marketing]
select * from [dbo].[Opportunities]
select * from [dbo].[Revenue_data]
select * from [dbo].[Target_data]

-- Video 1
-- 1 - What is the total Revenue of the company this year?
select 
		cal.Year_No as yr
	,	sum(cast(rev.Revenue as bigint)) as total_revenue
from 
	Calendar_lookup cal join Revenue_data rev on cal.Month_ID=rev.Month_ID
--where cal.Year_No = (select datepart(yy,cast(getdate() as date)))
group by cal.Year_No
order by cal.Year_No


SELECT CAST( GETDATE() AS Date )

select 
	sum(Revenue) as total_revenue
from Revenue_data
where Month_ID in 
(select 
	distinct Month_ID 
from [Calendar_lookup] 
where Fiscal_Year = 'FY21')

-- 2 - What is the total Revenue Performance YoY?
select * from [dbo].[Revenue_data]
with cte (yr,mnth,revenue)
as
(
select 
		cal.Year_No
	,	cal.Month_No
	,	sum(cast(rev.Revenue as bigint))
from Calendar_lookup cal join Revenue_data rev on cal.Month_ID = rev.Month_ID
group by cal.Year_no,cal.Month_No
)
--select * from cte order by mnth
select 
		cal.Year_No as yr
	,	cal.Month_No as month_num
	,	sum(cast(rev.Revenue as bigint)) as CurrenYearRevenue
	,	cte.revenue as previousYearRveune 
	,   cast((sum(cast(rev.Revenue as bigint)) - cte.revenue)/cte.revenue  as float) as YoY_performance
from Calendar_lookup cal 
join Revenue_data rev on cal.Month_ID = rev.Month_ID
join cte on 
	cal.Year_No - 1 = cte.yr and
	cal.Month_ID = cte.mnth
group by 
	cal.Year_No,
	cal.Month_No,
	cte.revenue
order by 
	cal.Year_No,
	cal.Month_No

select 
	c.fiscal_year,
	sum(cast(r.revenue as bigint)) as total_reveune
from revenue_data r join
(select 
	distinct fiscal_year,
	month_id 
from calendar_lookup) c on c.month_id = r.month_id
group by c.fiscal_year

-- 3 - What is the MoM Revenue Performance?
with cte (yr,mnth,sales) as
(
select 
		cal.Year_No
	,	cal.Month_No
	,	sum(rev.Revenue)
from Calendar_lookup cal 
join Revenue_data rev on cal.Month_ID = rev.Month_ID
group by cal.Year_No, cal.Month_No
)
-- select * from cte
select 
	cal.Year_No,
	cal.Month_no,
	sum(rev.revenue) as CurrentMonthSales,
	cte.sales as PreviousMonthSales,
	(sum(rev.revenue)- cte.sales)/cte.sales as MoMPerformance
from Calendar_lookup cal 
join Revenue_data rev on cal.Month_ID = rev.Month_ID
join cte on 
	cal.Month_no - 1 = cte.mnth AND
	cal.Year_No = cte.yr
group by cal.Year_No,cal.Month_No,cte.sales
order by cal.Year_No,cal.Month_No

--------------------
use [youtube_db]
select 
	a.month_id,
	a.total_reveune, 
	LAG(a.total_reveune) over (order by a.month_id) as previous_month_Sales,
	a.total_reveune - LAG(a.total_reveune) over (order by a.month_id) as "MoM_$_diff",
	(a.total_reveune / LAG(a.total_reveune) over (order by a.month_id) - 1)*100 as "MoM_%_diff"
from 
(select r.month_id as month_id, sum(cast(r.revenue as bigint)) as total_reveune
from revenue_data r join
(select distinct month_id from calendar_lookup) c on c.month_id = r.month_id
group by r.month_id) a order by a.month_id

-- 4 - What is the Total Revenue Vs Target performance for the Year?
use [youtube_db]
select * from Target_data

select * from Calendar_lookup

select a.yr,a.mnth, cast(sum(rev.revenue) as bigint) as totalRevenue
from Revenue_data as rev join 
(select distinct  tar.Month_ID, cal.Year_No as yr
	,	cal.Month_No as mnth
	,   tar.Target as TotalTarget
from Calendar_lookup cal 
join Target_data tar on cal.Month_ID = tar.Month_ID) a
on rev.month_id = a.month_id
group by a.yr,a.mnth

select distinct 
	c.fiscal_year as fiscal_year,
	--a.month_id,
	sum(cast(a.total_revenue as bigint)),
	sum(cast(a.total_target as bigint))
from 
(select distinct 
	r.month_id as month_id,
	sum(r.revenue) as total_revenue,
	sum(t.target) as total_target
from
	(select distinct account_no,target,month_id from target_data) t 
	join 
	(select distinct account_no,revenue,month_id from revenue_data) r
	on r.account_no=t.account_no and t.month_id = r.month_id
group by 
	r.month_id
	)a
join calendar_lookup c on c.month_id = a.month_id
group by Fiscal_Year

-- 5 - What is the Revenue Vs Target performance Per Month?
select distinct x.total_revenue, x.total_target,x.absolute_diff,x.percentage_diff,c.fiscal_month
from 
(select 
	a.month_id,
	a.total_revenue,
	b.total_target,
	b.total_target - a.total_revenue as absolute_diff,
	((a.total_revenue/b.total_target) - 1) *100 as percentage_diff
from 
(select month_id, sum(revenue) as total_revenue from Revenue_data group by month_id) a
join 
(select month_id, sum(target) as total_target from target_data group by month_id) b
on a.Month_ID = b.Month_ID) x
join 
Calendar_lookup c
on c.month_id = x.month_id
use [youtube_db]
-- Video 2
-- 6 - What is the best performing product in terms of revenue this year?
select * from Revenue_data
select * from Target_data
select * from Marketing
select distinct Product_Category from Revenue_data
select a.Fiscal_Year,a.Product_Category,cast(sum(a.revenue) as bigint) from (
select cal.Fiscal_Year
	, cal.Month_No
	, rev.Product_Category
	, sum(rev.Revenue) as revenue 
from Revenue_data rev
join Calendar_lookup cal on cal.Month_ID = rev.Month_ID
where cal.Fiscal_Year = 'FY21'
group by cal.Fiscal_Year
	, cal.Month_No
	, rev.Product_Category) a
group by a.Fiscal_Year,a.Product_Category


select product_category,sum(total_rev) as revenue from 
(select product_category,month_id, sum(revenue) as total_rev from Revenue_data group by Product_Category, month_id) a
join 
(select distinct month_id, fiscal_year from Calendar_lookup where Fiscal_Year = 'FY21') c
on c.Month_ID = a.Month_ID
group by product_category

select product_category,sum(revenue) as total_rev from Revenue_data 
where  month_id in (select distinct month_id from Calendar_lookup where Fiscal_Year = 'FY21')
group by Product_Category

-- 7 - What is the product performance Vs Target for the month?

select distinct cal.fiscal_month,x.product_category,x.total_rev,x.total_tar,
(x.total_rev/x.total_tar) -1
from
(select distinct a.Month_ID,a.Product_Category, a.total_rev,b.total_tar from
(select month_id,product_category, sum(revenue) as total_rev from Revenue_data group by Month_ID,product_category)a
join 
(select month_id,product_category, sum(Target) as total_tar from Target_data group by Month_ID,product_category)b
on a.month_id = b.month_id and a.product_category = b.product_category)x
join
Calendar_lookup cal
on x.month_id = cal.month_id

-- 8 - Which account is performing the best in terms of revenue?
select x.* from (
select a.total_rev,b.new_account_name,
row_number() over(order by a.total_rev desc) as rnk
from 
(select Account_No, sum(revenue) as total_rev from Revenue_data group by Account_No)a
join [dbo].[acct_lookup] b on a.Account_No = b.New_Account_No) x
where x.rnk = 1

-- 9 - Which account is performing the best in terms of revenue vs Target?
select * from (
select 
	a.account_no,
	a.rev,
	b.tar,
	al.New_Account_Name,
	(a.rev/b.tar) - 1 as performance,
	row_number() over(order by ((a.rev/b.tar) - 1) desc) as rnk
from 
(select account_no, sum(revenue) as rev from Revenue_data 
where month_id in (select distinct month_id from Calendar_lookup )
group by Account_No
)a
join 
(select account_no, sum(target) as tar from Target_data 
where month_id in (select distinct month_id from Calendar_lookup )
group by Account_No)b
on a.account_no = b.account_no
left join 
acct_lookup al
on a.Account_No = al.New_Account_No) x
where x.rnk = 1

-- 10 - Which account is performing the worst in terms of meeting targets for the year?
select distinct 
	a.account_no,
	--a.month_id,
	a.rev,
	b.tar,
	a.rev/b.tar -1 as perfomance,
	cal.fiscal_year
from 
(select distinct account_no,month_id, sum(revenue) as rev from Revenue_data 
where month_id in (select distinct month_id from Calendar_lookup )
group by Account_No,Month_ID)a
join 
(select distinct account_no,month_id, sum(target) as tar from Target_data 
where month_id in (select distinct month_id from Calendar_lookup )
group by Account_No, month_id)b
on a.account_no = b.account_no and a.month_id =b.Month_ID
left join Calendar_lookup cal
on a.month_id = cal.month_id
order by a.rev/b.tar -1,cal.fiscal_year desc 

-- 11 - Which opportunity has the highest potential and what are the details?


-- 12 - Which account generates the most revenue per marketing spend for this month?

select Product_Category, sum(revenue) as rev
from Revenue_data
group by Product_Category

select
e.id,
count(p.employee_id) as number_of_projects
from 
employees e
join
projects p
on e.id = p.employee_id
group by e.id
having count(p.employee_id) > 10

select 
	n.id,
	count(u.id) as count_of_user
from 
	neighbourhood n
join
	users u
on n.id = u.neighborhood_id
group by n.id
having count(u.id) = 0

