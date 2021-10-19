********************************
	BUILD_HouseHoldTransmission - START
********************************;

********************************
	BUILD - START
********************************;

%let in = In04942 ;
libname WGS_Data "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Data\" ;

options compress = yes;
options obs = max ;
dm 'cle log' ;


********;

* WGS ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Build - Revision 1\WGS, Build.sas" ;

* MIBA ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Build - Revision 1\MIBA, Build.sas" ;

* CPR ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Build - Revision 1\CPR, Build.sas" ;

* DATES ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Build - Revision 1\DATES, Build.sas" ;

* Households ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Build - Revision 1\Households, Build.sas" ;

* Build ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Build - Revision 1\Build_Household_End_14_days.sas" ;

* CT ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Build - Revision 1\Ct_build.sas" ;


*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	BUILD - END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;
