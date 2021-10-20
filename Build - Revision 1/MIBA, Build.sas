********************************
	MIBA - START
********************************;


/*
%let Update = 210210 ; %put &Update. ;
proc import
	datafile 	= "F:\Projekter\FSEID00004942\InputData\MIBA_Sample\basis_samples_&Update..csv" 
	out 		= miba
	dbms		= csv
	replace ;
	delimiter 	= ";" ;
	getnames 	= yes ;
run; 
*/
/*
data CT_Data.miba ;
	set miba ;
run;
*/


data miba_final_1 ;
	set WGS_Data.miba ;
		if resultat = 2 then test_pos = 0 ;
		if resultat = 1 then test_pos = 1 ;
		Test = 1 ;
		if iTESTCENTER = 1 then Test_TCD = 1 ; else Test_TCD = 0 ;
		if iTESTCENTER = 1 then Test_Sund = 0 ; else Test_Sund = 1 ;
		if iTESTCENTER = 1 then TCD = 1 ; else TCD = 0 ;

		if year(prdate_adjusted)=2020 then PrWeek = week(prdate_adjusted, 'w')+1 ;
		if year(prdate_adjusted)=2021 then PrWeek = week(prdate_adjusted, 'w') ;
		if '28dec2020'd <= prdate_adjusted <= '03jan2021'd then PrWeek = 53 ;

		rename CPRNR_ENCRYPTED = pnr ;
		rename PrDate = PrDateTime ;
		rename prdate_adjusted = PrDate ;
		rename utdate= utdatetime  ;

			drop
				inDate
				RunDate
				Cprnr_FRO
				Cprnr_GRL2
				Extid
				rejse_lastupdatedate
				rejse_resultat
				Qtnr
				;

run;

data miba_final_1 ;
	set miba_final_1 ;
		utdate = datepart(utdatetime) ;
			format utdate date9. ;

		* Workaround for TCDK-UtDates ;
		if iTESTCENTER = 1 and PrDate in (
											'08MAY2020'd,
											'29MAY2020'd,
											'30MAY2020'd,
											'31MAY2020'd,
											'01JUN2020'd,
											'02JUN2020'd,
											'03JUN2020'd,
											'04JUN2020'd,
											'05JUN2020'd,
											'06JUN2020'd,
											'07JUN2020'd,
											'08JUN2020'd,
											'09JUN2020'd,
											'10JUN2020'd
										)
			then UtDate  = intnx('day', prdate, 1) ;
run;


proc sort data = miba_final_1 ;
	by 
		pnr
		prdate
		descending test_pos 
		;
run;

data miba_final ;
	set miba_final_1 ;
		by pnr prdate ;
			if first.prdate then output ;
run;

proc sort data = miba_final ;
	by 
		pnr
		prdate
		;
run;


data First_positive ;
	set miba_final ;
		where test_pos = 1 ;
			keep 
				pnr
				utdate
				prdate
				PrWeek
				CT_value
				TCD
				;
			by pnr ;
				if first.pnr then output ;
run;

proc sql;
	create table First_positive_2

	as select 
				F.*,
				W.*

	from 		First_positive		F

	left join 	WGS					W
		on F.pnr = W.pnr
;quit;

data First_positive_2 ;
	set First_positive_2 ;
		if WGS_selection = . then WGS_Selection = 0 ;
		if SEQUENCE_STATUS = "genome" then WGS_genome = 1 ; else WGS_genome = 0 ;

		B117 = 0 ;
		if LINEAGE = "B.1.1.7" then B117 = 1 ;
		if LINEAGE = "" then B117 = . ;

		if B117 = . then Lineage_2 = "No Genome" ;
		if B117 = 1 then Lineage_2 = "B.1.1.7" ;
		if B117 = 0 then Lineage_2 = "Other" ;
		if Lineage_2 = "B.1.1.7" then lineage_order=1;
		if Lineage_2 = "Other" then lineage_order=2;
		if Lineage_2 = "No Genome" then lineage_order=3;




		CT_value_exist = 1 ;  
		if CT_value = . then CT_value_exist = 0 ;  

		CT_value_1 = round(CT_value,1.0);
		CT_value_2 = (int((CT_value_1 - 1) / 2) + 1 ) * 2 - 1;

		if CT_value < 25 then CT_value_Q = 1 ; 
		if 25 <= CT_value < 28 then CT_value_Q = 2 ; 
		if 28 <= CT_value < 32 then CT_value_Q = 3 ; 
		if 32 <= CT_value <= 38 then CT_value_Q = 4 ; 
		count = 1 ;


		if PrWeek = 52 then PrWeek_name = "Week 52" ;
		if PrWeek = 53 then PrWeek_name = "Week 53" ;
		if PrWeek = 1  then PrWeek_name = "Week 1" ;
		if PrWeek = 2  then PrWeek_name = "Week 2" ;
		if PrWeek = 3  then PrWeek_name = "Week 3" ;
		if PrWeek = 4  then PrWeek_name = "Week 4" ;
		if PrWeek = 5  then PrWeek_name = "Week 5" ;
		if PrWeek = 6  then PrWeek_name = "Week 6" ;
		if PrWeek = 7  then PrWeek_name = "Week 7" ;
run;

proc sql;
	create table MIBA_week_person

	as select
			pnr,
			PrWeek,
			max(test) as test,
			max(test_pos) as test_pos

	from 	miba_final

	group by
			pnr,
			PrWeek
;quit;



*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	MIBA - END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
