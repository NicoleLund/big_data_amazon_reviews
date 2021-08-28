-----------------------
-- Verify Table Sizes
-----------------------

-- 0a - review_id_table
select count(review_id)
  from review_id_table;
  
-- 0b - products
select count(product_id)
  from products;

-- 0c - customers
select count(customer_id)
  from customers;
  
-- 0d - vine_table
select count(review_id)
  from vine_table;
  
-----------------------
-- Review vine stats
-----------------------

-- 1a - Star Rating
select v.vine, 
	   min(v.star_rating) as min_star_rating,
	   avg(v.star_rating) as avg_star_rating,
	   max(v.star_rating) as max_star_rating
  from vine_table as v
 where v.vine is not NULL
 group by v.vine;

-- 1b
select v.vine, 
	   min(v.helpful_votes) as min_helpful_votes,
	   avg(v.helpful_votes) as avg_helpful_votes,
	   max(v.helpful_votes) as max_helpful_votes
  from vine_table as v
 where v.vine is not NULL
 group by v.vine;

-- 1c
select v.vine, 
	   min(v.total_votes) as min_total_votes,
	   avg(v.total_votes) as avg_total_votes,
	   max(v.total_votes) as max_total_votes
  from vine_table as v
 where v.vine is not NULL
 group by v.vine;
 
-----------------------
-- Investigate large vote counts
-----------------------

 -- 2a Review stats by max_helpful_votes
 select r.customer_id,
	   v.vine,
	   count(r.customer_id) as review_count,
	   min(v.helpful_votes) as min_helpful_votes,
	   avg(v.helpful_votes) as avg_helpful_votes,
	   max(v.helpful_votes) as max_helpful_votes,
	   min(v.total_votes) as min_total_votes,
	   avg(v.total_votes) as avg_total_votes,
	   max(v.total_votes) as max_total_votes
  from vine_table as v
  	   inner join review_id_table as r
	   on v.review_id = r.review_id
where v.vine is not NULL
group by r.customer_id, v.vine
order by max_helpful_votes desc
 limit 10;
 