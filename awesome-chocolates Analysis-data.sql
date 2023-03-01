select * from geo;
select * from people;
select * from products;
select * from sales;

show tables;
desc sales;

select SaleDate,
		Amount,
		Customers
from sales;


-- Calculations

select SaleDate,
		Amount,
        Boxes,
        Amount/boxes as 'Amount per box'
from sales;

-- impose conditions

select * from sales
where amount > 10000;

select * from sales
where amount > 10000
order by Amount desc;

select * from sales
where GeoID = 'g1'
order by pid, Amount desc;

select *
from sales
where Amount>10000 and SaleDate >= '2022-01-01';

select saleDate, Amount
from sales
where amount > 10000 and year(saleDate) = '2022'
order by amount desc;

select * from sales
where boxes > 0 and Boxes <= 50;

select * from sales
where Boxes between 0 and 50;

select SaleDate, Amount, Boxes, weekday(saleDate) as 'Day of week'
from sales
where weekday(saleDate) = 4;

select * from people;
select * from people
where team = 'Delish' or team = 'jucies';

select * from people
where team in ('Delish', 'Jucies');

select * from people
where Salesperson like 'b%';

select * from people
where Salesperson like '%b%';

-- Case Operator

select * from sales;
/** Amount category as column and Amount 1000 having level of under 1000 and Amount between 1000 to 5000 having level of under 5000 and Amount having 5000 to 10000 having level under 10000 and anything above level above 10000 **/

select SaleDate,
		Amount,
        Case when Amount < 1000 then 'under 1k'
			when Amount > 5000 then 'under 5k'
            when Amount < 10000 then 'under 10k'
		else '10k or more'
        end as 'Amount Category'
        from sales;
        
