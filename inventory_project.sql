create database inventory_project;
use inventory_project;
drop table inventory;
select *from inventory limit 10;
select Count(*) from inventory;

# total inventory value 
select round(sum(stock_quantity * unit_cost),2) as total_invetory_value from inventory ;

# total units in stock
select sum(stock_quantity) as total_unit from inventory;

# LOW STOCK CHECk 
select product_name,stock_quantity, reorder_level from inventory where stock_quantity<reorder_level;

#overstock product
select product_name,stock_quantity, monthly_demand from inventory where stock_quantity<monthly_demand*2;

#inventory turnover indicator
select product_name,sum(sales_quantity)/sum(stock_quantity) as turnover_ratio from inventory group by product_name;

select product_name, case 
when monthly_demand = 0 then null
else round(stock_quantity/(monthly_demand/30),2)
end as day_of_stock from inventory ;

select product_name ,days_of_stock, case 
when days_of_stock <15 then 'Understock'
when days_of_stock between 15 and 45 then 'Optimal'
else 'Overstock'
end as stock_status from (select product_name,round(stock_quantity/(monthly_demand/30),2) as days_of_stock  from inventory ) as temp;

