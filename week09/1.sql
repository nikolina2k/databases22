create function retrieveAddresses() returns setof character varying(50) as
$$
begin
	return query 	select address.address
 					from address 
 					where address.address like '%11%' and address.city_id >= 400 and address.city_id <= 600;  
                    end;
$$
LANGUAGE plpgsql;

alter table if exists address
    add column if not exists longitude real,
    add column if not exists latitude real;