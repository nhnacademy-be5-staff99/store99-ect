insert into orders
(order_id,order_type,order_transit_at,order_receiver_name,order_receiver_number,
 order_address,order_address_detail,order_address_code,order_total_cost,consumer_id)
    values
    (1,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",10000,1),
    (2,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",11000,1),
    (3,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",12000,1),
    (4,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",13000,1),
    (5,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",14000,1),
    (6,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",15000,1),
    (7,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",16000,1),
    (8,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",17000,1),
    (9,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",18000,1),
    (10,"USER", CURRENT_TIMESTAMP, "tester","01012345678","there", "here", "12345",19000,1);
