********************************
	WGS - START
********************************;

proc import
	datafile 	= "F:\Projekter\FSEID00004942\InputData\WGS_data\wgs_data_20210227_cpr10.csv"
	out 		= WGS
	dbms		= csv
	replace ;
	delimiter 	= ";" ;
	getnames 	= yes ;
run; 

data WGS ;
	set WGS ;
		rename CPR_ENCRYPTED = pnr ;
		WGS_Selection = 1 ;

		keep
				CPR_ENCRYPTED
				pnr
				LINEAGE
				SEQUENCE_STATUS
				WGS_Selection
				;
run;


*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	WGS - END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
