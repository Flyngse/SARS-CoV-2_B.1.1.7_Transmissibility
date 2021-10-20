

data miba_final_stats ;
	set miba_final ;
		where '21dec2020'd <= PrDate <= '21feb2021'd ;
run;

ods excel file="F:\Projekter\FSEID00004942\FrederikPlesnerLyngse\Household Transmission\WGS\Output\WGS_week_stat.xlsx" ;
* FIRST POSTIVE ;
proc sql;
	select 
			PrWeek,
			count(distinct PNR) as count_pnr,
			sum(WGS_Selection) as WGS_Selection,
			mean(WGS_Selection) as WGS_Selection_mean,
			sum(WGS_genome) as WGS_genome,
			mean(WGS_genome) as WGS_genome_mean,
			sum(B117) as B117,
			mean(B117) as B117_mean

	from First_positive_2

	where '21dec2020'd <= PrDate <= '21feb2021'd 

	group by PrWeek
;quit;
ods excel close ;
