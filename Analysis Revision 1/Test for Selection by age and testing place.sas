
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
			WGS_Selection_100 = Age_5 Age_5*TCD /  type1 type3;
run;quit;



*********
	Overall Ct and WGS ;
*********;
ods output ParameterEstimates = parms_SELECT ;
proc genmod data = First_positive_3 plots=none;
	where '21dec2020'd <= PrDate <= '21feb2021'd 
	and 0 <= Age_5 <= 100 
	
	;
	class 
		Age_5 
		/ param=glm;
	model
			WGS_Selection = Age_5 Age_5*TCD /  type1 type3;
run;quit;
