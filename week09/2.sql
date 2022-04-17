drop function if exists retrievecustomers;

create function retrievecustomers (start_index int, end_index int)
    returns table (
        customer int,
        address smallint
	) 
as 
$$
begin
    if start_index <= 0 or end_index <= 0 or start_index >= end_index or end_index > 600 then
		raise exception 'Error';
	end if;

    return query 
    	select customer.customer_id, customer.address_id 
		from customer
	    where customer.address_id not in
		(
			select customer.address_id 
	       	from customer 
	       	order by customer.address_id 
	       	limit (start_index - 1)
	   	)
    	order by customer.address_id
    	limit (end_index - start_index + 1);
end;
$$
language plpgsql;

select retrievecustomers(10, 40);