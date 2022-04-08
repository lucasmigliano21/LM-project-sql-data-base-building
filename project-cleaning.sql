create database project;

## Quiero conocer la cantidad de títulos por idioma:

select count(distinct a.title), b.name from film a
join language b on a.language_id=b.language_id
group by b.name;

## Quiero saber que tiempo de duración promedio tiene cada película por rating y cuántas películas hay por rating:

select rating, avg(length) as avg_len, count(distinct title) as titles from film 
group by rating
order by titles, avg_len desc;

# Creo una tabla temporal que me traiga título y id de categoría:

create temporary table  title_cat(
select title, category_id from actorfilms);


## Uso la tabla temporal creada antes junto a un subquery para contar cantidad de títulos por categoría de película

select count(distinct title) as num_titles, name as category_name 
	from 
	(select a.*, b.name from title_cat a
join category b on a.category_id = b.category_id) as h
group by category_name
order by num_titles desc;

## Quiero saber el ránking de participaciones por actriz/actor: 

select count(distinct title) as titles, Full_Name from actorfilms
group by Full_Name
order by titles desc;

## Quiero averiguar la cantidad de días que demoran las devoluciones por título:

SELECT round((TIMESTAMPDIFF(HOUR, a.rental_date, a.return_date)/24),0) AS dias_transcurridos, c.title  from rental a
join inventory b using (inventory_id)
join  film c using (film_id);

## hago el promedio de días por título:

select round(avg(dias_transcurridos),0) as promedio_dias, title
from
(
SELECT round((TIMESTAMPDIFF(HOUR, a.rental_date, a.return_date)/24),0) AS dias_transcurridos, c.title  from rental a
join inventory b using (inventory_id)
join  film c using (film_id)) as i
group by title
order by promedio_dias desc;

## agrego una columna para ver si tardan más o menos de una semana por título:

select title, 
case
	when dias_transcurridos  < 7 then 'menos de una semana'
	else 'más de una semana'
end as semana
from
(
SELECT round((TIMESTAMPDIFF(HOUR, a.rental_date, a.return_date)/24),0) AS dias_transcurridos, c.title  from rental a
join inventory b using (inventory_id)
join  film c using (film_id)) as i
group by title, semana
order by title asc;


## quiero comparar cuántos títulos se devuelven menos de una semana y más de una semana:

select count(semana), semana
from 
(
select title, 
case
	when dias_transcurridos  < 7 then 'menos de una semana'
	else 'más de una semana'
end as semana
from
(
SELECT round((TIMESTAMPDIFF(HOUR, a.rental_date, a.return_date)/24),0) AS dias_transcurridos, c.title  from rental a
join inventory b using (inventory_id)
join  film c using (film_id)) as i
group by title, semana) as j
group by semana;

## cuántos son los usuarios que más películas alquilaron? top 10

select count(customer_id) as cantidad_veces, customer_id from rental
group by customer_id
order by cantidad_veces desc
limit 10;

select count(title) from film
where special_features like '%deleted%';


## Nueva tabla:

select actor.Full_Name, actorfilms.title,  category.name, film.rental_rate, (SUBSTRING_INDEX(special_features, ',', 1)) as special_feature1,
		(SUBSTRING_INDEX(special_features, ',', -1)) as special_feature2, 
        round((TIMESTAMPDIFF(HOUR, rental.rental_date, rental.return_date)/24),0) AS dias_transcurridos
from actor
join actorfilms using (FUll_Name)
join category using (category_id)
join film using (title)
join inventory using (film_id)
join rental using (inventory_id);