********************************
	Dates - START
********************************;


%let startdate 	= 20dec2020 ;
%let enddate	= 01mar2021 ;

* construct all dates betweend start and end date ;
data dates_day ;
	date = "&startdate."d ;
		do while (date <= "&enddate."d) ;
			output;
				date = intnx('day', date, 1, 's' ) ;
				week = week(date, 'w')+1 ;
				month = month(date) ;
		end;
			format date date9. ;
run;

data dates_day_final ;
	set dates_day ;
run ;

proc sql;
	create table dates_week_final

	as select distinct
						week

	from dates_day_final
;quit;


*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	Dates - END
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@;