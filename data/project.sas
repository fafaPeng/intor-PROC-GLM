libname proj 'C:\Users\chery\Desktop\342project';

/* 1. ADULT data  */
data proj.adult;
length workclass $20 education $20  marital_status $ 25  occupation $ 20 
	   relationship $ 20 race $ 20 sex $ 20 native_country $30 ;
infile 'C:\Users\chery\Desktop\342project\adult.data' delimiter=',';
input age workclass $ fnlwgt education $ education_num 
	  marital_status $ occupation $ relationship $ race $ sex $ 
	  capital_gain capital_loss hours_per_week native_country $ earning $;
run;

proc print data=proj.adult (obs=30);
run;
proc contents data=proj.adult;
run;

data proj.adult;
set proj.adult;
if earning ='<=50K' then numeric_earning=0;
else if earning='>50K' then numeric_earning=1;
run;

proc print data=proj.adult (obs=30);
run;

data proj.adult;
set proj.adult;
if age <=30 then age_group=1;
else if 30<age <=40 then age_group=2;
else if 40<age <=50 then age_group=3;
else if 50<age <=60 then age_group=4;

else if 60<age <=70 then age_group=5;
else if 70<age <=80 then age_group=6;
else if 80<age <=90 then age_group=7;
else age_group=8;
run;

data proj.adult;
set proj.adult;
if education_num <=3 then education_group=1;
else if 4<education_num <=9 then education_group=2;
else if 10<education_num <=15 then education_group=3;
else age_group=4;
run;


proc print data=proj.adult (obs=30);
run;

proc glm data=proj.adult;
	class education;
	model numeric_earning = education;
	means education / hovtest=levene;
	run;


proc glm data=proj.adult;
	class education;
	model numeric_earning = education;
	means education / hovtest=levene welch;
	run;

proc glm 
	data=proj.adult;
	class education_num;
	model numeric_earning = education_num;
	means education_num / hovtest=levene;
	run;

ods graphics on;
proc glm 
	data=proj.adult PLOTS=IntPlot PLOTS(MAXPOINTS=10000000);
	class occupation age_group;
	model numeric_earning = occupation age_group;

	run;
ods graphics off;

ods graphics on;
	proc glm 
	data=proj.adult PLOTS=IntPlot PLOTS(MAXPOINTS=10000000);;
	class occupation age_group;
	model numeric_earning = occupation age_group occupation*age_group;
	run;
ods graphics off;

ods graphics on;
	proc glm 
	data=proj.adult PLOTS=IntPlot PLOTS(MAXPOINTS=10000000);;
	class sex native_country;
	model numeric_earning = sex native_country sex*native_country;
	run;
ods graphics off;

	proc glm 
	data=proj.adult;
	class marital_status age;
	model numeric_earning = marital_status age;
	run;


proc glm 
	data=proj.adult;
	class education_num age race relationship;
	model numeric_earning = education_num age race relationship;
	run;

	proc glm data=proj.adult;
	class race;
	model numeric_earning = race;
	means race / hovtest=levene welch;
	run;

ods graphics on;
proc glm data=proj.adult PLOTS=IntPlot PLOTS(MAXPOINTS=10000000);
	class  education_num occupation age_group;
	model numeric_earning = education_num occupation age_group / solution clparm;
	run;
ods graphics off;


ods graphics on;
proc glm data=proj.adult;
	class  education_group;
	model numeric_earning = education_group / solution clparm;
	run;
ods graphics off;

proc contents data=proj.adult;
run;

proc glm data=proj.adult;
	model numeric_earning = education_num / p clm;
	run;

ods graphics on;
proc glm data=proj.adult;
	class  education_num;
	model numeric_earning = education_num / solution clparm;
	run;
ods graphics off;
