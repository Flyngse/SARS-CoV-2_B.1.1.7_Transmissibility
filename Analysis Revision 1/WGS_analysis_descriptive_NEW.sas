

* descriptives ;

***** Primary cases ;
* Total ;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Primary_cases_stat.xlsx" ;
proc means data = Primary_cases_stat n sum maxdec=0;
	var  count;
run;
* Sex ;
proc means data = Primary_cases_stat n sum maxdec=0;
	class female_index ;
	var  count;
run;
* Age ;
proc means data = Primary_cases_stat n sum maxdec=0;
	class Age_index_5 ;
	var  count;
run;
proc means data = Primary_cases_stat n sum maxdec=0;
	class Age_index_10 ;
	var  count;
run;
* Houshold Size ;
proc means data = Primary_cases_stat n ;
	class house_members ;
	var count ;
run;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Primary_cases_stat_2.xlsx" ;
proc means data = Primary_cases_stat n sum maxdec=0;
	var  WGS_Selection_index ;
run;
* Sex ;
proc means data = Primary_cases_stat n sum maxdec=0;
	class female_index ;
	var  WGS_Selection_index ;
run;
* Age ;
proc means data = Primary_cases_stat n sum maxdec=0;
	class Age_index_5 ;
	var  WGS_Selection_index ;
run;
* Age ;
proc means data = Primary_cases_stat n sum maxdec=0;
	class Age_index_10 ;
	var  WGS_Selection_index ;
run;
* Houshold Size ;
proc means data = Primary_cases_stat n sum;
	class house_members ;
	var  WGS_Selection_index ;
run;
ods excel close ;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Primary_cases_stat_3.xlsx" ;
proc means data = Primary_cases_stat n sum maxdec=0;
	var  WGS_genome_index ;
run;
* Sex ;
proc means data = Primary_cases_stat n sum maxdec=0;
	class female_index ;
	var  WGS_genome_index ;
run;
* Age ;
proc means data = Primary_cases_stat n sum maxdec=0;
	class Age_index_5 ;
	var  WGS_genome_index ;
run;
proc means data = Primary_cases_stat n sum maxdec=0;
	class Age_index_10 ;
	var  WGS_genome_index ;
run;
* Houshold Size ;
proc means data = Primary_cases_stat n sum;
	class house_members ;
	var  WGS_genome_index ;
run;
ods excel close ;


ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Primary_cases_stat_4.xlsx" ;
proc means data = Primary_cases_stat n sum maxdec=0;
	where Lineage = "B.1.1.7" ;
	var  WGS_genome_index ;
run;
* Sex ;
proc means data = Primary_cases_stat n sum maxdec=0;
	where Lineage = "B.1.1.7" ;
	class female_index ;
	var  WGS_genome_index ;
run;
* Age ;
proc means data = Primary_cases_stat n sum maxdec=0;
	where Lineage = "B.1.1.7" ;
	class Age_index_5 ;
	var  WGS_genome_index ;
run;
proc means data = Primary_cases_stat n sum maxdec=0;
	where Lineage = "B.1.1.7" ;
	class Age_index_10 ;
	var  WGS_genome_index ;
run;
* Houshold Size ;
proc means data = Primary_cases_stat n sum;
	where Lineage = "B.1.1.7" ;
	class house_members ;
	var  WGS_genome_index ;
run;
ods excel close ;


***** Potential secondary cases ;
* Total ;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\Secondary_cases_stat.xlsx" ;
proc means data = super_shead5 n sum maxdec=0;
	var  ever_test_pos;
run;
* Sex ;
proc means data = super_shead5 n sum maxdec=0;
	class female ;
	var  ever_test_pos;
run;
* Age ;
proc means data = super_shead5 n sum maxdec=0;
	*where Age_5 < 90 ;
	class Age_5 ;
	var  ever_test_pos;
run;
proc means data = super_shead5 n sum maxdec=0;
	*where Age_5 < 90 ;
	class Age_10 ;
	var  ever_test_pos;
run;
* Houshold Size ;
proc means data = super_shead5 n sum maxdec=0;
	class house_members ;
	var ever_test_pos ;
run;
ods excel close ;



* Age groups ;
ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output Revision 1\PrimaryCasesLinkedStats.xlsx" ;
proc sql;
	select
			Lineage,
			Age_index_10,
			Count(distinct PNR_index) as N_index,
			count(pnr) as N_pot_sec,
			sum(ever_test_pos) as N_pot_sec

	from super_shead5

	group by Lineage, Age_index_10
;quit;

* Ct value ;
proc sql;
	select
			Lineage,
			CT_value_2,
			Count(distinct PNR_index) as N_index,
			count(pnr) as N_pot_sec,
			sum(ever_test_pos) as N_pot_sec

	from super_shead5

	group by Lineage, CT_value_2
;quit;
ods excel close ;



proc sql;
	select
			Lineage,
			Count(distinct PNR_index) as N_index,
			count(pnr) as N_pot_sec,
			sum(ever_test_pos) as N_pot_sec

	from super_shead5



	group by Lineage
;quit;




proc sql;
	select
			Lineage,
			Count(distinct PNR_index) as N_index,
			count(pnr) as N_pot_sec,
			sum(ever_test_pos) as N_pot_sec

	from super_shead5

	where lineage = "No Genome"



	group by Lineage
;quit;


