


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Total.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	class 
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = count  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Sex.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	class 
		house_number
		female
		/ param=glm;
	model
			ever_test_pos_100 = female  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Age10.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	class 
		Age_10
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = Age_10  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Age5.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	class 
		Age_5
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = Age_5  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_HouseSize.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	class 
		house_members
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = house_members  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Lineage.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	class 
		lineage
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = lineage  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


proc sort data = super_shead6 ;
	by lineage ;
run;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Lineage_CT.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	by lineage ;
	class 
		lineage
		Ct_value_2
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = Ct_value_2  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Lineage_withCT.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	where Ct_value_2 ne . ;
	by lineage ;
	class 
		lineage
		Ct_value_2
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = count  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Lineage_withoutCT.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	where Ct_value_2 = . ;
	by lineage ;
	class 
		lineage
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = count  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\AttackRate_Lineage_Age10.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
	by lineage ;
	class 
		lineage
		Age_index_10
		pnr
		house_number
		/ param=glm;
	model
			ever_test_pos_100 = Age_index_10  / noint  ;
			repeated subject = house_number / type=ind;
run;quit;
ods excel close ;
