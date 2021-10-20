
*****************************;
* No controls ;
*****************************;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\OR_mod1_transmissionRate_nocoprim.xlsx" ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and co_primary_dayZERO_home = 0 ;
	cluster house_number ;
	class 
		Age_index_5 (ref="22.5")
		pnr
		Age_index_10 (ref="25")
		Age_10 (ref="25")
		house_number 
		lineage
		house_members (ref="2")
		;

	model 
		ever_test_pos_100 (event = '100') = 
											B117_index
											;
		weight weight_d1 ;
run; quit;
ods excel close ;

*****************************;
* with age index ;
*****************************;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\OR_mod2_transmissionRate_nocoprim.xlsx" ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and co_primary_dayZERO_home = 0 ;
	cluster house_number ;
	class 
		Age_index_5 (ref="22.5")
		pnr
		Age_index_10 (ref="25")
		Age_10 (ref="25")
		house_number 
		lineage
		house_members (ref="2")
		Age_5 (ref="22.5")
		;

	model 
		ever_test_pos_100 (event = '100') = 
											B117_index
											Age_index_10
											;
		weight weight_d1 ;
run; quit;
ods excel close ;

*****************************;
* with age index + age seco ;
*****************************;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\OR_mod3_transmissionRate_nocoprim.xlsx" ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and co_primary_dayZERO_home = 0 ;
	cluster house_number ;
	class 
		Age_index_5 (ref="22.5")
		pnr
		Age_index_10 (ref="25")
		Age_10 (ref="25")
		house_number 
		lineage
		house_members (ref="2")
		Age_5 (ref="22.5")
		;

	model 
		ever_test_pos_100 (event = '100') = 
											B117_index
											Age_index_10
											Age_10 
											;
		weight weight_d1 ;
run; quit;
ods excel close ;

*****************************;
* with age index + age seco + Ct ;
*****************************;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\OR_mod4_transmissionRate_nocoprim.xlsx" ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and Ct_value_2 ne . and co_primary_dayZERO_home = 0 ;
	cluster house_number ;
	class 
		pnr
		Age_index_10 (ref="25")
		Age_10 (ref="25")
		house_number 
		lineage
		house_members (ref="2")
		Ct_value_2 (ref="29")
		;

	model 
		ever_test_pos_100 (event = '100') = 
											B117_index
											Age_index_10
											Age_10 
											Ct_value_2
											;
		weight weight_d1 ;
run; quit;
ods excel close ;



