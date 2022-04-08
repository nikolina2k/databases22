explain analyse select fid, title from film_list fl
    join inventory i on i.film_id = fl.fid
    where (category = 'Horror' or category = 'Sci-Fi')
        and (rating = 'R' or rating = 'PG-13')
        and inventory_in_stock(i.inventory_id)
group by title, fid
order by fid;

select * from sales_by_store;

