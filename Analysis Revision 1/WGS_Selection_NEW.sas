
proc sql;
	create table wgs_selection

	as select
			TCD,
			PrDate,
			mean(WGS_Selection)*100 as WGS_Selection,
			mean(WGS_genome)*100 as WGS_genome

	from First_positive_2

	group by TCD, PrDate
;quit;
data wgs_selection ;
	set wgs_selection ;
		if TCD = 0 then TestingPlace = "Hospital" ;
		if TCD = 1 then TestingPlace = "TCDK" ;
run;

proc sort data = First_positive_2 ;	
	by TCD PrDate ;
run;

*************************
	Prob of testing by TCDK and hospital
*************************;
ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "prob of wgs_selection by tcdk_kma" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
title 'prob of wgs_selection by tcdk_kma' ;
title;
proc sgplot data = wgs_selection ;
	where '21dec2020'd <= PrDate <= '21feb2021'd ;
		styleattrs 
				datacontrastcolors = (orange black) 
				datasymbols=( triangledownfilled asterisk ) 
				datalinepatterns=( solid dot) 
				datacolors=(orange brown) 
				;
	series 
			x = PrDate
			y = WGS_Selection
			/ markers group=TestingPlace;

	refline '11jan2021'd / axis=x lineattrs=(color=black pattern=dash) label="Study Sample, start";
	refline '07feb2021'd / axis=x lineattrs=(color=black pattern=dash) label="Study Sample, end";;

	yaxis 
		values = (0 to 100 by 10)
		label = "Proportion (%)"
		;

	xaxis display=(nolabel) ;

	keylegend  / Title="Testing Place" location=inside position=topleft across=1 noborder opaque;
run;

*************************
	Ct value and Lineages per week
*************************;
proc sort data=First_positive_2 ;
	by lineage_order PrDate ;
run; 
ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "density CT values mutations over time" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
title 'density CT values mutations - over time' ;
title ;
proc sgpanel data = First_positive_2 ;
	styleattrs 
				datacontrastcolors = (red blue gray) 
				datasymbols=( trianglefilled diamondfilled circlefilled) 
				datalinepatterns=( solid dash dot) 
				datacolors=(red blue gray) 
				;
	where '21dec2020'd <= PrDate <= '21feb2021'd ;
	panelby PrWeek_name / columns=3 rows=3 sort=data novarname;
	density CT_value_1 
						/ type=kernel 
						group=Lineage_2
					;
	colaxis 
			values =(18 to 38 by 2)
			label="Ct Value" 
			grid
			;
	keylegend / Title="Lineage" position=bottom  noborder ;
run;

*************************
	Age and Lineages per week
*************************;
proc sql;
	create table First_positive_3

	as select
				F.*,
				C.age,
				C.age_5

	from		First_positive_2	F

	left join	CPR_FINAL			C
		on F.pnr = C.pnr

	order by  lineage_order, PrDate
;quit;

ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "density age mutations over time" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
title 'density agee mutations - over time' ;
title  ;
proc sgpanel data = First_positive_3 ;
	styleattrs 
				datacontrastcolors = (red blue gray) 
				datasymbols=( trianglefilled diamondfilled circlefilled) 
				datalinepatterns=( solid dash dot) 
				datacolors=(red blue gray) 
				;

	where '21dec2020'd <= PrDate <= '21feb2021'd ;
	panelby PrWeek_name / columns=3 rows=3 sort=data novarname;
	density age 
						/ type=kernel 
						group=Lineage_2
						
					;
	colaxis 
			values =(0 to 100 by 10)
			label="Age (year)"
			grid
			;
	
	keylegend / Title="Lineage" position=bottom  noborder ;
run;
