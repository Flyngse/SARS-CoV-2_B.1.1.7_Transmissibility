********************************
	Analysis  - START
********************************;

* Summary Statistics ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\WGS_analysis_descriptive_NEW.sas" ;

* Descriptive Statistics on sampes, week ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Primary Data Selection.sas" ;

* Descriptive Statistics ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\WGS_Selection_NEW.sas" ;

* Ct value and sampling ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\WGS_prob of sampling by Ct value - NEW.sas" ;

* Ct value and sampling ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\WGS_prob of sampling by Age - NEW.sas" ;

* primary secondary by WGS;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Primary cases and secondary cases by genome.sas" ;

* Transmissibility and Ct values ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Association between transmission risk and Ct value.sas" ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Association between transmission risk and Ct value_NoCoPrim.sas" ;

* Transmissibility and Age ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Association between age and transmission risk.sas" ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Association between age and transmission risk_NoCoPrim.sas" ;


* Additive vs multiplicative effect ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Additive_multiplicative_TransRate.sas" ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Additive_multiplicative_TransRisk.sas" ;

* Odds ratio model ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Regressions Transmission Rate, OR.sas" ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Regressions Transmission Risk, OR.sas" ;

* Age-by_age Heatmap ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Analysis_heatmaps.sas" ;

* Definition of Co-Primary - sensitivity;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Co_primary.sas" ;

* Odds ratio model - excluding co-primary cases ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Regressions Transmission Rate, OR_nocoprim.sas" ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Regressions Transmission Risk, OR_nocoprim.sas" ;

* Attack Rate with confidence bands ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Regressions Attack Rate.sas" ;

* Test for Selection by age and testing place ;
%include "F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Analysis Revision 1\Test for Selection by age and testing place.sas" ;

*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	Analysis - END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;


 
