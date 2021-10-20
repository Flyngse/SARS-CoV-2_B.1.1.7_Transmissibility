

* Primary cases and secondary cases by genome ;


proc freq data= super_shead6 ;
	where  0 < test_pos_day;
	table lineage*Lineage_sec / nopercent norow nocol;
run;

proc freq data= super_shead6 ;
	table lineage*ever_test_pos_100 / nopercent norow nocol;
run;

