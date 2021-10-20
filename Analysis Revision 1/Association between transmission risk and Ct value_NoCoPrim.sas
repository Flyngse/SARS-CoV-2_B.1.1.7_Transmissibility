

****
	Association between transmission RATE and Ct value
****;
proc sort data = super_shead6 ;
	by
		lineage
		Age_index_5
		;
run;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	where co_primary_dayZERO_home = 0 ;
	by lineage ;
	class 
		Age_index_5
		pnr
		house_number
		CT_value_Q
		CT_value_Q2
		/ param=glm;
	model
			ever_test_pos_100 = CT_value_Q2  / noint  ;
			repeated subject = house_number / type=ind;
			weight weight_d1 ;
run;quit;
data parms_pos ;
	set parms_pos ;
		length var $10 ;
		var = "Positive" ;
run;
data parms ;
	set 
		
		parms_pos 
		;
		CT = Level1+0 ;
		format estimate comma10.0 ;
		if Lineage = "B.1.1.7" then lineage_order=1;
		if Lineage = "Other" then lineage_order=2;
		if Lineage = "No Genome" then lineage_order=3;
run;

proc sort data = parms ;
	by lineage_order ;
run;

ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "WGS_TransmissionRATE_WGS_CT_quartile_nocoprim" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
Title ;
proc sgplot data = parms noborder;
	*where 18 <= CT <= 38 ;
	styleattrs 
				datacontrastcolors = (red blue gray) 
				datasymbols=( trianglefilled diamondfilled circlefilled) 
				datalinepatterns=( solid dash dot) 
				datacolors=(red blue gray) 
				;
	series
			y = Estimate
			x = CT
			/ markers   group=lineage name="estimates" datalabel=estimate  grouporder=data;

	band
			x = CT
			lower=LowerCL
			upper=UpperCL
			/   transparency = 0.9  group=lineage name="band" ;
			;

	xaxis	
			label = "Ct Value"
			values = (18 25 28 32 38 )
			;

	yaxis 	
			values = (0 to 70 by 10) 
			label = "Transmission Rate (%)"
			grid
			;

	keylegend "estimates" / Title="Lineage" location=inside position=bottomleft across=1 exclude=("band")  noborder opaque;
run; quit;


****
	Association between transmission RISK and Ct value
****;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	where co_primary_dayZERO_home = 0 ;
	by lineage ;
	class 
		Age_index_5
		pnr
		house_number
		CT_value_Q
		CT_value_Q2
		/ param=glm;
	model
			transmission_d1 = CT_value_Q2  / noint  ;
			repeated subject = house_number / type=ind;
			weight weight_d1 ;
run;quit;
data parms_pos ;
	set parms_pos ;
		length var $10 ;
		var = "Positive" ;
run;
data parms ;
	set 
		
		parms_pos 
		;
		CT = Level1+0 ;
		format estimate comma10.0 ;
		if Lineage = "B.1.1.7" then lineage_order=1;
		if Lineage = "Other" then lineage_order=2;
		if Lineage = "No Genome" then lineage_order=3;
run;

proc sort data = parms ;
	by lineage_order ;
run;

ods listing gpath = "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\" ;
ods graphics / reset=index imagename = "WGS_TransmissionRISK_WGS_CT_quartile_nocoprim" imagefmt=pdf ;
ods graphics on / attrpriority=none border=off ;
Title ;
proc sgplot data = parms noborder;
	*where 18 <= CT <= 38 ;
	styleattrs 
				datacontrastcolors = (red blue gray) 
				datasymbols=( trianglefilled diamondfilled circlefilled) 
				datalinepatterns=( solid dash dot) 
				datacolors=(red blue gray) 
				;
	series
			y = Estimate
			x = CT
			/ markers   group=lineage name="estimates" datalabel=estimate  grouporder=data;

	band
			x = CT
			lower=LowerCL
			upper=UpperCL
			/   transparency = 0.9  group=lineage name="band" ;
			;

	xaxis	
			label = "Ct Value"
			values = (18 25 28 32 38 )
			;

	yaxis 	
			values = (0 to 70 by 10) 
			label = "Transmission Risk (%)"
			grid
			;

	keylegend "estimates" / Title="Lineage" location=inside position=bottomleft across=1 exclude=("band")  noborder opaque;
run; quit;
