*****************************;
* + TCDK ;
*****************************;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\OR_mod5_transmissionRisk_nocoprim.xlsx" ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and co_primary_dayZERO_home = 0 ;
	cluster house_number ;
	class 
		Age_index_5 (ref="22.5")
		house_number 
		lineage
		house_members (ref="2")
		Age_5 (ref="22.5")

		;

	model 
		transmission_d1 (event = '100') = 
											B117_index
											;
		weight weight_d1 ;
run; quit;
ods excel close ;

*****************************;
* + TCDK ;
*****************************;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\OR_mod6_transmissionRisk_nocoprim.xlsx" ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and co_primary_dayZERO_home = 0 ;
	cluster house_number ;
	class 
		pnr
		Age_index_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		Age_5 (ref="22.5")

		;

	model 
		transmission_d1 (event = '100') = 
											B117_index
											Age_index_10
											;
		weight weight_d1 ;
run; quit;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\OR_mod7_transmissionRisk_nocoprim.xlsx" ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and Ct_value_2 ne . and co_primary_dayZERO_home = 0 ;
	cluster house_number ;
	class 
		Age_index_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		Ct_value_2 (ref="29")
		;

	model 
		transmission_d1 (event = '100') = 
											B117_index
											Age_index_10
											Ct_value_2 
											;
		weight weight_d1 ;
run; quit;
ods excel close ;




