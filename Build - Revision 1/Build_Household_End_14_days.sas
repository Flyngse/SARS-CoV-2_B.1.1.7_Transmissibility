
* Build Contact Tracing ;


******* 
	Build_Household_End_14_days 
******* ;

* Merge first positive on households ;
proc sql;
	create table	Contact_house

	as select 
				H.*,
				F.UtDate,
				F.PrDate,
				F.Ct_value,
				F.TCD,
				F.WGS_Selection,
				F.WGS_genome,
				F.B117

	from		home_full_2			H

	inner join	First_positive_2		F
		on H.pnr = F.pnr

	where house_members <= 6

	order by
			house_number,
			PrDate
;quit;

data Contact_house_first ;
	set Contact_house ;
		by house_number ;
			if first.house_number then output ; 
run;
data Contact_house_first ;
	set Contact_house_first ;
		PNR_index = pnr ;
		PrDate_index = PrDate ;
		UtDate_index = UtDate ;
		Female_index = female;
		Age_index = age;
		Age_index_5 = age_5;
		Age_index_10 = age_10;
		Age_index_20 = age_20;
		agegroup_2_index = agegroup_2 ;
		DOB_index = DOB ;
		Age_index_prdate_month = intck("month", DOB, PrDate_index) ;
		Age_index_prdate_year = intck("year", DOB , PrDate_index) ;
		Ct_value_index = Ct_value ;
		TCD_index = TCD ;
		WGS_Selection_index = WGS_Selection ;
		WGS_genome_index = WGS_genome ;
		B117_index = B117 ;

run;

proc sql;
	create table contact_1

	as select
				H.*,
				F.PNR_index,
				F.UtDate_index,
				F.PrDate_index,
				F.Female_index,
				F.Age_index,
				F.Age_index_5,
				F.Age_index_10,
				F.Age_index_20,
				F.agegroup_2_index,
				F.Age_index_prdate_month,
				F.Age_index_prdate_year,
				F.Ct_value_index,
				F.TCD_index,
				F.WGS_Selection_index,
				F.WGS_genome_index,
				F.B117_index

	from		home_full_2				H

	inner join	Contact_house_first		F
		on H.house_number = F.house_number
;quit;

data  contact_1 ;
	set contact_1 ;
		if pnr = PNR_index then patient_index = 1 ; else patient_index = 0 ;

		index_week = week(PrDate_index, 'v') ;

		format PrDate_index date9. ;
		format UtDate_index date9. ;
run;


proc sql;
	create table	contact_2

	as select distinct
				C.*,
				p.female,
				p.age,
				p.age_10,
				p.age_5,
				p.age_20,
				p.agegroup_2,
				D.*,
				M.PrDate,
				M.test_pos,
				M.Test,
				F.WGS_Selection,
				F.WGS_genome,
				F.B117

	from			contact_1			C

	right join		dates_day_final		D
		on 	C.pnr
		and	c.PrDate_index -0 <= d.date <= c.PrDate_index +14

	left join		miba_final			M
		on 	c.pnr = m.pnr
		and	d.date = m.PrDate

	left join 		cpr_final			P
		on	c.pnr = p.pnr

	left  join 		First_positive_2		F
		on c.pnr = F.pnr

	where c.pnr ^= ""

	order by
			house_number,
			pnr,
			date
;quit;


data contact_3 ;
	set contact_2 ;

		time_from_index = date - PrDate_index ;

		if test = . then test = 0 ;
		if pnr = "" then delete ;

			by house_number pnr ;
				if first.pnr then 
					do;
						test_cum 	 = 0 ;
						test_pos_cum = 0 ;
					end;
					test_cum 		+ test ;
					test_pos_cum 	+ test_pos ;

		ever_test 		= min(test_cum,1) ;
		ever_test_pos	= min(test_pos_cum,1) ;

		ever_test_1 	= min(test_cum,1) ;
		ever_test_pos_1	= min(test_pos_cum,1) ;

		ever_test_2 	= min(test_cum,2) ;
			if ever_test_2 < 2 then ever_test_2 = 0 ;
			if ever_test_2 = 2 then ever_test_2 = 1 ;
		ever_test_pos_2	= min(test_pos_cum,2) ;
			if ever_test_pos_2 < 2 then ever_test_pos_2 = 0 ;
run;

proc sql;
	create table first_day

	as select
				pnr,
				test_pos,
				test_pos_cum,
				time_from_index

	from contact_3

	where 	test_pos = 1
	and		test_pos_cum = 1
;quit;

proc sql;
	create table contact_4

	as select
				C.*,
				F.time_from_index as test_pos_day

	from		contact_3		C

	left join	first_day		F
		on C.pnr = F.pnr
;quit;

data contact_4 ;
	set contact_4 ;
		if test_pos_day = . then test_pos_day = 99 ;
run;




data prob_test_absorb ;
	set contact_4 ;
		ever_test_100 = ever_test*100 ;
		ever_test_pos_100 = ever_test_pos*100 ; 

		ever_test_1_100 	= ever_test_1*100 ;
		ever_test_pos_1_100	= ever_test_pos_1*100 ;
		ever_test_2_100 	= ever_test_2*100 ;
		ever_test_pos_2_100	= ever_test_pos_2*100 ;
run;


data contact_5 ;
	set contact_4 ;
		where 	time_from_index = 14 ;
		count = 1 ;
run;

* collapse on househould ;
proc sql ;
	create table HH

	as select
				house_number,
				house_members,
				sum(ever_test) as N_test_HH,
				sum(ever_test_pos) as N_positive_HH				

	from 	contact_5

	where 	2<= house_members <=6
	and		time_from_index = 14

	group by
			house_number,
			house_members
;quit;

proc sql;
	create table	contact_6

	as select
				c.*,
				H.N_test_HH,
				H.N_positive_HH

	from 		contact_5		C

	left join	HH				H
		on c.house_number = H.house_number
;quit;


data super_shead ;
	set contact_6 ;
		ever_test_100 = ever_test*100 ;
		ever_test_pos_100 = ever_test_pos*100 ; 
		ever_test_2_100 	= ever_test_2*100 ;
run;


*TEST ;
/*
data zz ;
	set contact_6 ;
		where N_positive_HH > house_members ;
run;
*/



proc sql ;
	create table	super_shead2

	as select
			D.*,
			P.*

	from		dates_day_final		D

	left join	super_shead		P
		on  P.PrDate_index <= D.date <= P.PrDate_index + 6

	where 	'01MAR2020'd <= D.date
	and		P.pnr ^= ""
;quit;

data super_shead3 ;
	set super_shead2 ;
		date2 = date + 0 ;
			format date2  julian. ;
run;

