/*Part - C*/

/*1*/
proc import datafile = "D:\Downloads\Statistical Computing\Final Project\Students.csv"
dbms = csv
out = asgnt.students;
run;

/*2*/
proc contents data = asgnt.students;
run;

ods pdf file = "D:\Downloads\Statistical Computing\Final Project\Pinnika_report.pdf";
/*3*/
data students;
  set asgnt.students;
  label class = 'Student class'
        race = 'Student Race'
        gender = 'Student Gender'
        GPA = 'Student GPA'
        Algebra = 'Student Algebra score'
		calculus = 'Student calculus Score'
		statistics = 'Student Statistics Score'
		Probability = 'Student Probability Score'
		y = 'Final Decision';
run;
title "Data with permanent labels";
proc print data = students (obs = 10) label;
run;
footnote "Students dataset";

/*4*/
proc format;
value Race
      1 = 'Indian'
	  2 = 'African American'
	  3 = 'Asian'
	  4 = 'Hispanic'
      5 = 'White';
value y
      0 = 'Try again'
	  1 = 'Success, Inland'
	  2 = 'Success, Abroad';
run;

/*5*/
proc sort data=students;
 by id;
run;
title "sorted data";
proc print data=students (obs=10) label;
format race race. y y.;
run;
footnote "Students datset";

/*6*/
data students1;
 set students;
 if calculus > 70 then output;
 drop race ID GPA;
run;
title "Subsetted data";
proc print data=students1 (obs=10) label;
format y y.;
run;
footnote "Students Dataset";

/*7*/
data students2;
 set students;
 if algebra>70 and calculus>70 then Feedback = 'Excellent';
 else Feedback = 'Good';
 drop race ID GPA;
run;
title "Students data with new variable";
proc print data = students2 (obs=10)label ;
format y y.;
run;
footnote "Students Dataset";

/*8*/
title "Frequency table with 2 variables";
proc freq data=students ;
  tables class*y / nocum nopercent norow;
  format race race. y y.;
run;
proc sort data=students;
by y ;
run;
title "Frequency table using by statement";
proc freq data=students ;
by y ;
tables gender*y / nocum nopercent norow;
format race race. y y.;
run;
footnote "Students Dataset";

/*9*/
title "Average scores in Statistics,Probability and average GPA";
proc means data=students n mean std var min max maxdec=2 ;
 var Statistics probability;
run;
footnote "Students dataset";

/*10*/
proc summary data = students sum print;
var Algebra calculus probability;
run;

%let macro = Great;/*Creating Macro Variable*/
data students3 ;
  set students;
   Decision = "&macro";
  do i = 40;
     sub = algebra - i;
     output;
  end;
  drop i;
run;
title "Modified data using macro variable & do loop";
proc print data = students3 (obs=10) label;
var Gender Algebra decision sub ;
run;
footnote "Students Dataset";
ods pdf close;
