

data First_positive_2 ;
	set First_positive_2 ;
		WGS_Selection_100 = WGS_Selection*100 ;
		WGS_genome_100 = WGS_genome*100 ;
run;

proc sort data = First_positive_2 ;
	by PrWeek ;
run;

proc sql;
	create table First_positive_3 

	as select
				F.*,
				C.age_5,
				C.age_10

	from		First_positive_2		F

	left join	cpr_final				C
		on F.pnr = C.pnr

	order by PrWeek
;quit;

*********
	Overall Ct and WGS ;
*********;
ods output ParameterEstimates = parms_SELECT ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100
	and 2 <= PrWeek <= 5
	;
	class 
		Age_5
		/ param=glm;
	model
			WGS_Selection_100 = Age_5  / noint  ;
run;quit;
data parms_SELECT ;
	set parms_SELECT ;
		Group = "Selected for WGS" ;
run;
ods output ParameterEstimates = parms_GENOME ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100
	and 2 <= PrWeek <= 5
	;
	class 
		Age_5
		/ param=glm;
	model
			WGS_genome_100 = Age_5  / noint  ;
run;quit;
data parms_GENOME ;
	set parms_GENOME ;
		Group = "With Genome" ;
run;
data parms ;
	set 
		parms_SELECT
		parms_GENOME 
		;
		Age = Level1+0 ;
		format estimate comma10.0 ;
run;

ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "Prob_of_WGS_by_AGE_5" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
*title 'prob of wgs_selection' ;
proc sgplot data = parms ;
		styleattrs 
				datacontrastcolors = (purple green ) 
				datasymbols=(circlefilled squarefilled) 
				datalinepatterns=( solid dash ) 
				datacolors=(purple green ) 
				;
	series
			y = Estimate
			x = Age
			/ markers   group=Group name="estimates" datalabel=estimate ;

	band
			x = Age
			lower=LowerWaldCL
			upper=UpperWaldCL
			/   transparency = 0.9  group=Group name="band" ;


	xaxis
		values = (0 to 100 by 10) 
		label = "Age"
		
		;

	yaxis 
		values = (0 to 100 by 10)
		label = "Proportion (%)"
		grid
		;

		keylegend "estimates" / Title="" location=inside position=bottomright across=1 exclude=("band")  noborder opaque;
run;

*********
	Overall Ct and WGS ;
*********;
ods output ParameterEstimates = parms_SELECT ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100
	and 2 <= PrWeek <= 5
	;
	class 
		Age_10
		/ param=glm;
	model
			WGS_Selection_100 = Age_10  / noint  ;
run;quit;
data parms_SELECT ;
	set parms_SELECT ;
		Group = "Selected for WGS" ;
run;
ods output ParameterEstimates = parms_GENOME ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100
	and 2 <= PrWeek <= 5
	;
	class 
		Age_10
		/ param=glm;
	model
			WGS_genome_100 = Age_10  / noint  ;
run;quit;
data parms_GENOME ;
	set parms_GENOME ;
		Group = "With Genome" ;
run;
data parms ;
	set 
		parms_SELECT
		parms_GENOME 
		;
		Age = Level1+0 ;
		format estimate comma10.0 ;
run;

ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "Prob_of_WGS_by_AGE_10" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
*title 'prob of wgs_selection' ;
proc sgplot data = parms ;
		styleattrs 
				datacontrastcolors = (purple green ) 
				datasymbols=(circlefilled squarefilled) 
				datalinepatterns=( solid dash ) 
				datacolors=(purple green ) 
				;
	series
			y = Estimate
			x = Age
			/ markers   group=Group name="estimates" datalabel=estimate ;

	band
			x = Age
			lower=LowerWaldCL
			upper=UpperWaldCL
			/   transparency = 0.9  group=Group name="band" ;


	xaxis
		values = (0 to 100 by 10) 
		label = "Age"
		grid
		;

	yaxis 
		values = (0 to 100 by 10)
		label = "Proportion (%)"
		grid
		;

		keylegend "estimates" / Title="" location=inside position=bottomright across=1 exclude=("band")  noborder opaque;
run;



*********
	By week Ct and WGS ;
*********;
ods output ParameterEstimates = parms_SELECT ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100
	;
	by PrWeek ;
	class 
		Age_5
		/ param=glm;
	model
			WGS_Selection_100 = Age_5  / noint  ;
run;quit;
data parms_SELECT ;
	set parms_SELECT ;
		Group = "Selected for WGS" ;
run;
ods output ParameterEstimates = parms_GENOME ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100
	;
	by PrWeek ;
	class 
		Age_5
		/ param=glm;
	model
			WGS_genome_100 = Age_5  / noint  ;
run;quit;
data parms_GENOME ;
	set parms_GENOME ;
		Group = "With Genome" ;
run;
data parms ;
	set 
		parms_SELECT
		parms_GENOME 
		;
		Age = Level1+0 ;
		format estimate comma10.0 ;

		year = 2021 ;
		if Prweek in (52,53) then year = 2020 ;

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

proc sort data = parms ;
	by year PrWeek ;
run;

ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "Prob_of_WGS_by_AGE_5_by_Week" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
proc sgpanel data = parms ;
	panelby PrWeek_name / columns=3 rows=3 sort=data novarname;
		styleattrs 
				datacontrastcolors = (purple green ) 
				datasymbols=(circlefilled squarefilled) 
				datalinepatterns=( solid dash ) 
				datacolors=(purple green ) 
				;
	series
			y = Estimate
			x = Age
			/ markers   group=Group name="estimates" ;

	band
			x = Age
			lower=LowerWaldCL
			upper=UpperWaldCL
			/   transparency = 0.9  group=Group name="band" ;


	colaxis
		values = (0 to 100 by 20) 
		label = "Age"
		grid
		;

	rowaxis 
		values = (0 to 100 by 10)
		label = "Proportion (%)"
		grid
		;

		keylegend "estimates" / Title="" position=bottom  exclude=("band")  noborder ;
run;





*********
	By week Ct and WGS ;
*********;
ods output ParameterEstimates = parms_SELECT ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100
	;
	by PrWeek ;
	class 
		Age_10
		/ param=glm;
	model
			WGS_Selection_100 = Age_10  / noint  ;
run;quit;
data parms_SELECT ;
	set parms_SELECT ;
		Group = "Selected for WGS" ;
run;
ods output ParameterEstimates = parms_GENOME ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_10 <= 100
	;
	by PrWeek ;
	class 
		Age_10
		/ param=glm;
	model
			WGS_genome_100 = Age_10  / noint  ;
run;quit;
data parms_GENOME ;
	set parms_GENOME ;
		Group = "With Genome" ;
run;
data parms ;
	set 
		parms_SELECT
		parms_GENOME 
		;
		Age = Level1+0 ;
		format estimate comma10.0 ;

		year = 2021 ;
		if Prweek in (52,53) then year = 2020 ;

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

proc sort data = parms ;
	by year PrWeek ;
run;

ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "Prob_of_WGS_by_AGE_10_by_Week" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
proc sgpanel data = parms ;
	panelby PrWeek_name / columns=3 rows=3 sort=data novarname;
		styleattrs 
				datacontrastcolors = (purple green ) 
				datasymbols=(circlefilled squarefilled) 
				datalinepatterns=( solid dash ) 
				datacolors=(purple green ) 
				;
	series
			y = Estimate
			x = Age
			/ markers   group=Group name="estimates" ;

	band
			x = Age
			lower=LowerWaldCL
			upper=UpperWaldCL
			/   transparency = 0.9  group=Group name="band" ;


	colaxis
		values = (0 to 100 by 20) 
		label = "Age"
		grid
		;

	rowaxis 
		values = (0 to 100 by 10)
		label = "Proportion (%)"
		grid
		;

		keylegend "estimates" / Title="" position=bottom  exclude=("band")  noborder ;
run;
