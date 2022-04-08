-- before (name) 9.530ms
explain analyse select name from customer;
-- before (address) 10.300ms
explain analyse select address from customer;
-- before (id) 9.450ms
explain analyse select id from customer;

-- id btree
create index if not exists idx_id on customer(id);
-- name hash
create index if not exists idx_name on customer using hash (name);

-- after (name) 9.460ms
explain analyse select name from customer;
-- after (address) 10.270ms
explain analyse select address from customer;
-- after (id) 10.300ms
explain analyse select id from customer;
