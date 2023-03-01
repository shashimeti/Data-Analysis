use instagram;
show tables;

select * from likes;
select * from comments;
select * from follows;
select * from photos;
select * from photo_tags;
select * from users;
select * from tags;

/*Ques.1 The first 10 users on the platform*/

select * 
from users
order by created_at asc
limit 10;

/*Ques.2 Total number of registrations*/

select count(*) as 'Total Registration'
from users;

/*Ques.3 The day of the week most users register on*/
create view Vw_Total_registrations 
As
select
	date_format(created_at, '%w') as 'Day of the week',
    count(*) as 'The total number of registration'
    from users
    group by 1
    order by 2 desc;
    
select
		*
from Vw_Total_registrations;


select 
		dayname(created_at) as 'Day of the week',
		count(*) as 'Total Registration'
from users
group by 1
order by 2 desc;

/*Ques.4 The users who have never posted a photo*/

select * from users;
select * from photos;

select
		u.username
from users u 
left join photos p
on u.id = p.user_id
where p.id is null;

/*Ques.5 The most likes on a single photo*/

select * from users;
select * from photos;
select * from likes;

select
	u.id,
	u.username,
	p.image_url,
	count(*) as 'Total'
from photos p
	inner join 
		likes l on l.photo_id = p.id
	inner join 
		users u on p.user_id = u.id
group by p.id
order by Total desc
limit 5;

/*Version 2*/

select 
		round((select 
			count(*)
		from photos)/ (select
							count(*)
						from users),2)as 'Average post by Users'; 
                        

/*Ques.6 The number of photos posted by most active users*/

select 
	u.username as 'User Name',
    count(p.image_url) as 'No of posts'
from users u 
	join
    photos p on u.id = p.user_id
group by 1
order by 2 desc
limit 5;

/*Ques.7 The total number of posts*/

select * from photos;

select 
	sum(user_posts.total_post_per_user) as 'Total post by Users'
from 
	(select 
		u.username, 
        count(p.image_url) as Total_post_per_user
	from 
			users u
	join photos p on u.id = p.user_id
	group by u.id) as User_posts;
	
/*Ques.8 The total number of users with posts*/

SELECT 
	COUNT(distinct (u.id)) as 'Total no of users with photos'
FROM 
	users u
JOIN 
	Photos p ON u.id = p.user_id;
    
/*Ques.9 The usernames with numbers as ending*/

SELECT 
	id,
    username
FROM 
	users
WHERE 
username REGEXP '[$0-9]';

/*Ques.10 The usernames with charachter as ending*/

SELECT 
	id,
    username
FROM 
	users
WHERE username NOT REGEXP '[$0-9]';

/*Ques.11 The number of usernames that start with A*/

SELECT 
	id,
    username
FROM
	users
WHERE username REGEXP '^[A]';

/*Ques.12 The most popular tag names by usage*/

select * from tags;
select * from photo_tags;

SELECT
	t.tag_name,
    COUNT(tag_name) as seen_used
FROM
	tags t
JOIN
	photo_tags pt
    ON pt.tag_id = t.id
GROUP BY t.id
ORDER BY seen_used DESC
LIMIT 10;

/*Ques.13 The most popular tag names by likes*/
SELECT 
	t.tag_name as 'Tag Name',
    COUNT(l.photo_id) as 'No of Likes'
FROM 
	photo_tags pt
JOIN
	likes l
    ON l.photo_id = pt.photo_id
JOIN 
	tags t
    ON pt.tag_id = t.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

/*Ques.14 The users who have liked every single photo on the site*/


