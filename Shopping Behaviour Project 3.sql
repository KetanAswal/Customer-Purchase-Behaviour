-- for show all the present database
show databases;

-- here we create our own database
create database if not exists myproject3;

-- here we access our database
use myproject3;

-- here we create our table
create table if not exists shoppingBehaviour(
CustomerID int,
Age int,
Gender char(1),
ItemPurchased varchar(20),
Category varchar(20),
PurchaseAmountInUSD int,
Location varchar(50),
Size varchar(3),
Color varchar(50),
Season varchar(20),
ReviewRating decimal(3,1),
SubscriptionStatus varchar(3),
ShippingType varchar(50),
DiscountApplied varchar(50),
PromoCodeUsed varchar(3),
PreviousPurchases int,
PaymentMethod varchar(50),
FrequencyofPurchases varchar(50)
);

-- here we add the primary key in  our table customer id column
alter table shoppingBehaviour add primary key(CustomerId);

-- for describe our table
desc shoppingBehaviour;

-- after creating the table its good to import the data

-- here we can able to see our data
select * from shoppingBehaviour;

-- here we add another column name age group and update the data in it
alter table ShoppingBehaviour add AgeGroup varchar(7);
update ShoppingBehaviour set AgeGroup="18-30" where Age>=18 and Age<=30;
update ShoppingBehaviour set AgeGroup="31-45" where Age>=31 and Age<=45;
update ShoppingBehaviour set AgeGroup="46-60" where Age>=46 and Age<=60;
update ShoppingBehaviour set AgeGroup="61-75" where Age>=61 and Age<=75;
update ShoppingBehaviour set AgeGroup="76-100" where Age>=76 and Age<=100;

-- 1.What is the average purchase amount per transaction overall, and how does it vary by gender and by age group?
select avg(purchaseamountinusd) as "Average Purchase Amount" from shoppingBehaviour;
-- with gender by
select distinct gender,avg(purchaseamountinusd) as "Average Purchase Amount" from shoppingBehaviour group by gender;

-- 2.What is the average order value (AOV) (i.e., average purchase amount) in each category of items?
select distinct category,avg(purchaseamountinusd) as "Average Order Value" from shoppingBehaviour group by category;

-- 3.Which categories generate the highest total spend and which categories have the highest average spend per transaction?
select category,sum(purchaseamountinusd) as "Highest Total Spend",avg(purchaseamountinusd) as "Average Order Value" from shoppingBehaviour
group by category;

-- 4.What is the distribution of purchases by season (e.g., Spring, Summer, etc), and for each season which category is the top‐spender?
select season,count(customerid) as "Total Number of Transaction",
sum(purchaseamountinusd) as "Total Purchase Amount",
avg(purchaseamountinusd) as "Average Purchase Amount"
from shoppingBehaviour group by season;

-- 5.How does the payment type (e.g., cash, card, digital) affect the total spend and average spend per transaction?
select distinct paymentmethod as "Payment Method",
sum(purchaseamountinusd) as "Purchase Amount In Usd",
avg(purchaseamountinusd) as "AVERAGE Purchase Amount In Usd"
from shoppingBehaviour group by paymentmethod;

-- 6.Which locations (city/region) contribute the most in terms of total spend, number of transactions, and average spend per transaction?
select location,sum(purchaseamountinusd) as "Total Spend Amount",
count(customerid) as "Total Number of Transaction",
avg(purchaseamountinusd) as "Average Purchase Amount" from shoppingBehaviour group by location; 

-- 7.Among customers of different age groups, which group has the highest total spend, highest average spend and highest number of transactions?
 select agegroup,
 sum(purchaseamountinusd) as "Total Spend Amount",
avg(purchaseamountinusd) as "Average Purchase Amount",
count(customerid) as "Total Number of Transaction"
from shoppingBehaviour group by agegroup;

-- 8.What are the top colour & size combinations by number of purchases and by total spent?
select color, size,
count(customerid) as "Total Number of Purchases",
sum(purchaseamountinusd) as "Total Spend Amount"
 from ShoppingBehaviour group by color,size order by  count(customerid) desc,sum(purchaseamountinusd) desc;

-- 9.What is the repeat purchase rate / number of customers who made more than one purchase, by demographic location?
select location,sum(purchaseamountinusd)/count(customerid) as "Avg Purchase amount location wise"
from ShoppingBehaviour
group by location order by location;

-- 10.What is the category‐mix per location or demographic (i.e., for a given region or age‐group, what share of spend is in each category)?
select location,category,
sum(purchaseamountinusd) as "Total Spend Amount",
agegroup,
count(agegroup) as "Total"
from ShoppingBehaviour group by category,location,agegroup order by 
category;

-- 11.Which customers (or demographic segments) qualify as “high spenders”
select agegroup,sum(purchaseamountinusd) as "HighSpenders" from ShoppingBehaviour 
group by agegroup order by HighSpenders desc limit 1;

-- 12.What is the share of payment types used in each category?
select paymentmethod,
sum(PurchaseAmountInUSD),count(customerid),
sum(PurchaseAmountInUSD)/count(customerid)
from ShoppingBehaviour group by paymentmethod;

-- 13.How does the average purchase amount vary by size (e.g., S, M, L, XL) and/or by colour?
select size,color,avg(PurchaseAmountInUSD) as "Average Price" from ShoppingBehaviour group by size,color order by size;

-- 14.Which season shows the largest growth (or drop) in total spend?
select season,sum(PurchaseAmountInUSD) as "TotalAmount" from ShoppingBehaviour group by season order by TotalAmount desc limit 1;
