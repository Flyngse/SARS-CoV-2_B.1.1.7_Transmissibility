

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\Model1_linear_transmissionRate.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
where lineage ne "No Genome" ;
class 
		pnr
		Age_index_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		/ ;
	model
			ever_test_pos_100 (event = '100') =  B117_index Age_index_10 / dist=binomial link=identity;
			weight weight_d1;
			*repeated subject = house_number / type=ind;
run;quit;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Model1_logit_transmissionRate.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
where lineage ne "No Genome" ;
class 
		pnr
		Age_index_10 (ref="15")
		Age_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		/ ;
	model
			ever_test_pos_100 (event = '100') =  B117_index Age_index_10 / dist=binomial link=logit;
			weight weight_d1;
			*repeated subject = house_number / type=ind;
run;quit;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Model2_linear_transmissionRate.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
where lineage ne "No Genome" ;
class 
		pnr
		Age_index_10 (ref="15")
		Age_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		/ ;
	model
			ever_test_pos_100 (event = '100') =  B117_index Age_index_10 Age_10 / dist=binomial link=identity;
			weight weight_d1;
			*repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Model2_logit_transmissionRate.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
where lineage ne "No Genome" ;
class 
		pnr
		Age_index_10 (ref="15")
		Age_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		/ ;
	model
			ever_test_pos_100 (event = '100') =  B117_index Age_index_10 Age_10 / dist=binomial link=logit;
			weight weight_d1;
			*repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Model3_linear_transmissionRate.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
where lineage ne "No Genome" ;
class 
		pnr
		Age_index_10 (ref="15")
		Age_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		Ct_value_2 (ref="29")

		/ ;
	model
			ever_test_pos_100 (event = '100') =  B117_index Age_index_10 Age_10 Ct_value_2/ dist=binomial link=identity;
			weight weight_d1;
			*repeated subject = house_number / type=ind;
run;quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Model3_logit_transmissionRate.xlsx" ;
ods output GEEEmpPEst = parms_pos ;
proc genmod data = super_shead6 plots=none;
where lineage ne "No Genome" ;
class 
		pnr
		Age_index_10 (ref="15")
		Age_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		Ct_value_2 (ref="29")
		/ ;
	model
			ever_test_pos_100 (event = '100') =  B117_index Age_index_10 Age_10 Ct_value_2/ dist=binomial link=logit;
			weight weight_d1;
			*repeated subject = house_number / type=ind;
run;quit;
ods excel close ;
