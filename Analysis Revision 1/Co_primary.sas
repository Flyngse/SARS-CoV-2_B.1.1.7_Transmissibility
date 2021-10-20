

%macro Risk_coprim(ii) ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and Ct_value_2 ne .
	and 1 <= test_pos_day
	;
	cluster house_number ;
	class 
		Age_index_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		Ct_value_2 (ref="29")
		;

	model 
		transmission_d&ii. (event = '100') = 
											B117_index
											Age_index_10
											Ct_value_2 
											;
		weight weight_d&ii. ;
run; quit;
%mend;

%Risk_coprim(ii=1) ;
%Risk_coprim(ii=2) ;
%Risk_coprim(ii=3) ;
%Risk_coprim(ii=4) ;



%macro Rate_coprim(ii) ;
proc surveylogistic data = super_shead6 ;
	where lineage ne "No Genome" and Ct_value_2 ne .
	and 1 <= test_pos_day
	;
	cluster house_number ;
	class 
		Age_index_10 (ref="15")
		house_number 
		lineage
		house_members (ref="2")
		Ct_value_2 (ref="29")
		;

	model 
		ever_test_pos_100 (event = '100') = 
											B117_index
											Age_index_10
											Ct_value_2 
											;
		weight weight_d&ii. ;
run; quit;
%mend;

%Rate_coprim(ii=1) ;
%Rate_coprim(ii=2) ;
%Rate_coprim(ii=3) ;
%Rate_coprim(ii=4) ;
