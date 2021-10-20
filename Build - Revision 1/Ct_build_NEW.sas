

***** CT BUILD ;

data super_shead5 ;
	set super_shead ;
		where '11jan2021'd <= PrDate_index <= '07feb2021'd
		and Age_index_5 <90
		and house_members >1
		and female_index ne .
		and house_members ne .
		and patient_index = 0 
		and 0 < test_pos_day 
		;

		CT_value = CT_value_index ;
		CT_value_exist = 1 ;  
		if CT_value = . then CT_value_exist = 0 ;  

		if CT_value < 28 then CT_value_median_above = 0 ;
		if CT_value >= 28 then CT_value_median_above = 1 ;

		if CT_value < 25 then CT_value_Q = 1 ; 
		if 25 <= CT_value < 28 then CT_value_Q = 2 ; 
		if 28 <= CT_value < 32 then CT_value_Q = 3 ; 
		if 32 <= CT_value <= 38 then CT_value_Q = 4 ; 
		if CT_value < 18 then CT_value_Q = . ;
		if CT_value > 38 then CT_value_Q = . ;

		if CT_value_Q = 1 then CT_value_Q2 = (25+18)/2 ;
		if CT_value_Q = 2 then CT_value_Q2 = (28+25)/2 ;
		if CT_value_Q = 3 then CT_value_Q2 = (32+28)/2 ;
		if CT_value_Q = 4 then CT_value_Q2 = (38+32)/2 ;

		CT_value_1 = round(CT_value) ;
		CT_value_2 = (int((CT_value_1 - 1) / 2) + 1 ) * 2 - 1;

		if B117_index = . then Lineage = "No Genome" ;
		if B117_index = 1 then Lineage = "B.1.1.7" ;
		if B117_index = 0 then Lineage = "Other" ;

		if B117 = . and ever_test_pos = 1 then Lineage_sec = "No Genome" ;
		if B117 = 1 and ever_test_pos = 1 then Lineage_sec = "B.1.1.7" ;
		if B117 = 0 and ever_test_pos = 1 then Lineage_sec = "Other" ;



		weight = 1 / (house_members-1) ;

		*if CT_value > 38 then delete;
run;

data super_shead_CO_prim_homes_1 ;
	set super_shead ;
		where '11jan2021'd <= PrDate_index <= '07feb2021'd
		and Age_index_5 <90
		and house_members >1
		and female_index ne .
		and house_members ne .
		and patient_index = 0 
		/* and 0 < test_pos_day  */
		;

			keep
				test_pos_day
				house_number
				co_primary_dayZERO_home
				;

		co_primary_dayZERO_home = 0 ;
		if test_pos_day = 0 then co_primary_dayZERO_home = 1 ;

run;


proc sql;
	create table	Co_primary_homes

	as select distinct 	
						house_number,
						max(co_primary_dayZERO_home) as co_primary_dayZERO_home

	from super_shead_CO_prim_homes_1

	group by house_number
;quit;

/*
proc means data =Co_primary_homes N mean sum maxdec=2;
	var co_primary_dayZERO_home ;
run;

proc means data =super_shead_CO_prim_homes_1 N mean sum maxdec=2;
	var co_primary_dayZERO_home ;
run;
*/


%macro qq() ;
	proc sql;
		create table Any_transmission_d&ii.

		as select distinct
					house_number,
					house_members,
					min( sum(ever_test_pos_1), 1)*100 as transmission_d&ii.,
					count(pnr) as count_pot_sec_cases_d&ii.,
					 1/count(pnr) as weight_d&ii.

		from super_shead5

		where &ii. <= test_pos_day

		group by house_number
	;quit;
%mend;

%let ii = 1 ;
%qq() ;
%let ii = 2 ;
%qq() ;
%let ii = 3 ;
%qq() ;
%let ii = 4 ;
%qq() ;

proc sql;
	create table Any_transmission

	as select
				D1.house_number,
				D1.transmission_d1,
				D1.weight_d1,
				D2.transmission_d2,
				D2.weight_d2,
				D3.transmission_d3,
				D3.weight_d3,
				D4.transmission_d4,
				D4.weight_d4

	from 		Any_transmission_d1		D1

	left join 	Any_transmission_d2		D2
		on D1.house_number = D2.house_number

	left join 	Any_transmission_d3		D3
		on D1.house_number = D3.house_number

	left join 	Any_transmission_d4		D4
		on D1.house_number = D4.house_number
;quit;

proc sql;
	create table super_shead6

	as select
				S.*,
				T.*,
				C.co_primary_dayZERO_home


	from 		super_shead5		S

	left join 	Any_transmission	T	
		on S.house_number = T.house_number

	left join 	Co_primary_homes	C
		on S.house_number = C.house_number
;quit;


/*
data super_shead6 ;
	set super_shead5 ;
		where CT_value_exist = 1 
		
		;

		CT_value_2 = round(CT_value) ;
		CT_value_4 = CT_value_2 ;
		if CT_value_4 < 18 then CT_value_4 = 17 ;

		if Age_index_5 < 20 then age_below_20 = 1 ;
		if Age_index_5 >= 20 then age_below_20 = 0 ;
		if Age_index_5 < 20 then age_above_20 = 0 ;
		if Age_index_5 >= 20 then age_above_20 = 1 ;

		CT_value_3 = (int((CT_value_2 - 1) / 2) + 1 ) * 2 - 1;
run;
*/

proc sql;
	create table Primary_cases_stat

	as select distinct
						PNR_index,
						TCD_index,
						CT_value_exist,
						WGS_Selection_index,
						WGS_genome_index,
						Lineage,
						Age_index_5,
						Age_index_10,
						female_index,
						count,
						house_members,
						co_primary_dayZERO_home

	from super_shead6
;quit;

proc means data = Primary_cases_stat n mean sum maxdec=2;
	var co_primary_dayZERO_home ;
run;

