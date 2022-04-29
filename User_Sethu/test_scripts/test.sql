
-- not listed registrations
select cr.car_register_id from car_registration cr
left join car_listing cl
on cr.car_register_id = cl.car_register_id
where cl.listing_id is null;


-- empty parkng spots
select pr.parking_id, cl.listing_id from parking pr
left join car_listing cl
on cl.parking_id = pr.parking_id
where cl.listing_id is null;

-- 
set SERVEROUT on;
EXECUTE PCKG_CAR_LISTING.INSERT_CAR_LISTING('TRUE',30,'ARTYHBNJU193FTHYA2','PARKING_2');

