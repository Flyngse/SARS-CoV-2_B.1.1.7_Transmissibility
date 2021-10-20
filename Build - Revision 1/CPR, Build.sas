********************************
	CPR - START
********************************;

data Cpr_final ;
	set WGS_Data.Cpr_final ;
run;

* Fix CPR register on 11-02-2021 ;

/*
proc sql;
	create table CPR

	as select distinct
						V_PNR_ENCRYPTED as pnr,
						C_KON,
						C_STATUS,
						D_FODDATO

	from CT_Data.CPR3_T_PERSON

	where C_STATUS = "01"

;quit;
*/

/*

data CPR_final ;
	set CPR ;

		* Aldersgrupper ;
		age = 2020-year(D_FODDATO) ;

		/*
		if 		age <= 10 then agegroup_1 = 1 ;
		if 10 <	age <= 20 then agegroup_1 = 2 ;
		if 20 <	age <= 30 then agegroup_1 = 3 ;
		if 30 <	age <= 40 then agegroup_1 = 4 ;
		if 40 <	age <= 50 then agegroup_1 = 5 ;
		if 50 <	age <= 60 then agegroup_1 = 6 ;
		if 60 <	age <= 70 then agegroup_1 = 7 ;
		if 70 <	age 	  then agegroup_1 = 8 ;
		*/

		/*

		length agegroup_2 $ 8 ;
		if 			age < 15 then agegroup_2 = "0 to 14" ;
		if 15 <=	age < 20 then agegroup_2 = "15 to 19" ;
		if 20 <=	age < 40 then agegroup_2 = "20 to 39" ;
		if 40 <=	age < 60 then agegroup_2 = "40 to 59" ;
		if 60 <=	age < 80 then agegroup_2 = "60 to 79" ;
		if 80 <=	age 	 then agegroup_2 = "80+" ;

		Age_20 = (int((age - 1) / 20) + 1 ) * 20 - 10 ;

		Age_10 = (int((age - 1) / 10) + 1 ) * 10 - 5 ;

		Age_5 = (int((age - 1) / 5) + 1 ) * 5 - 2.5;

		* Køn ;
		if C_KON = "K" then Female = 1 ;
		if C_KON = "M" then Female = 0 ;

		count = 1 ;
run;
*/


*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	CPR - END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;


/*
proc sql;
	select 
			agegroup,
			count(distinct pnr) as count

	from cpr

	group by agegroup
;quit;
*/
