********************** Variablen erstellen *************************************
*** Allgemein ***
// Welle
gen wave = 1

// Tage der Befragung
gen    surveyday = dofC(startdate)
format surveyday %tdDD.NN.YYYY


********************************************************************************
*** Person ***

// Geschlecht
gen 		female = q01gndr == 2 if q01gndr < 3
replace female = .c if female == .

// Alter
gen 	  age = 2020 - q02yrbrn
replace age = q02yrbrn if mi(age)

// Altersgruppen
gen 		agegr = irecode(age, 24, 29, 34, 39, 44, 49, 54, 59, 64, 69, 74, 79)
replace agegr = agegr + 1
replace agegr = q02yrbrn if mi(agegr)

// Bildung (Partner)
recode q27educ    (2 = 1) (3 = 2) (4 = 3) (5 = .c), gen(edu)
recode q33educpar (2 = 1) (3 = 2) (4 = 3) (5 = .c), gen(p_edu)

recode q27educ (4 = 1) (0/3 = 0), gen(tertiary)


********************************************************************************
*** Beruf ***

// Status (mit Erwerbstätigkeit)
recode q04status (0 = .c), gen(status)
replace status = 0 if q03empst == 1

// Arbeitsverhältnis
recode q05ctrtype (5 = 1)   (2 3 4 = 0), gen(permempl)
recode q05ctrtype (3 4 = 1) (1 2 5 = 0), gen(selfempl)

// Systemrelevanter Beruf (Dummy)
recode q08prof    (1 = 0) (2/8 = 1), gen(sysjob)
recode q31profpar (1 = 0) (2/8 = 1), gen(p_sysjob)

// Homeoffice
recode q12office (2 3 4 = 1) (1 = 0) (0 = .), gen(homeoffice)

gen 		homeoffice_det = homeoffice
replace homeoffice_det = 2 if q12office == 3
recode  homeoffice_det (.b = 3) if q10currenttime == 4


********************************************************************************
*** Familie ***

// Familie
gen 		fam = 1 if q14partner == 0 & q15achildren == 0
replace fam = 2 if q14partner == 1 & q15achildren == 0
replace fam = 3 if q14partner == 1 & q15achildren == 1
replace fam = 4 if q14partner == 0 & q15achildren == 1
recode  fam (. = .c)

// Alter der Kinder
foreach num of numlist 1/10 {
	gen 		q16childage`num' = 2020 - q16byrchild`num'
	replace q16childage`num' = q16byrchild`num' if mi(q16byrchild`num')
}

// Anzahl Kinder
recode q15bchildren (3/10 = 3), gen(nrchildren)
replace nrchildren = 0 if q15achildren == 0

egen 		youngest = rowmin(q16childage?)
replace youngest = q16childage1 if mi(q16childage1)

recode 	youngest (0/2 = 1) (3/5 = 2) (6/10 = 3) (11/19 = 4), gen(youngestcat)
recode 	youngestcat (. = 0) if nrchildren == 0


* Kinderbetreuung
// myself
gen 		childcare = 1 if (q17childcare1 == 1 | ///
												  q17childcare2 == 1 | ///
												  q17childcare3 == 1) & ///
                          q17childcare4 != 1
// joint
replace childcare = 2 if (q17childcare4 == 1 & ///
											   (q17childcare1 == 1 | ///
												  q17childcare2 == 1 | ///
												  q17childcare3 == 1))
// partner
replace childcare = 3 if q17childcare4 == 1 & ///
											 !(q17childcare1 == 1 | ///
												 q17childcare2 == 1 | ///
												 q17childcare3 == 1)
// others
replace childcare = 4 if q17childcare5 == 1 | q17childcare6 == 1 | ///
		q17childcare7 == 1 | q17childcare8 == 1 | q17childcare9 == 1
replace childcare = 4 if childcare == . & q15achildren == 1

replace childcare = .b if q17childcare1 == .b
replace childcare = .c if q17childcare1 == .c


/*Überbelegt, unterbelegt, adäquat belegt nach Eurostat - Definition
	1 Raum pro Paar
	1 Raum pro weitere Person ab 12 Jahren
	0.5 Räume pro Person unter 12 (genau genommen auch für gleichgeschlechtliche Kinder unter 18, diese Differenzierung ist für uns nicht möglich)
	1 Raum extra

laut Destatis 2019 waren in 2017 in Deutschland 7% der Haushalte überbelegt und 35% unterbelegt (Quelle Eurostat)*/

gen 	  raumbedarf = q25hhsize  + 1   if q25hhsize  <= 10 //1 Raum pro Person + Gemeinschaftsraum
replace raumbedarf = raumbedarf - 1   if q14partner == 1 //Paare nur einen Raum gemeinsam
replace raumbedarf = raumbedarf - 0.5 if q16childage1  < 12 //pro Kind U12 nur halber Raum
replace raumbedarf = raumbedarf - 0.5 if q16childage2  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage3  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage4  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage5  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage6  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage7  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage8  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage9  < 12
replace raumbedarf = raumbedarf - 0.5 if q16childage10 < 12
replace raumbedarf = q25hhsize if mi(q25hhsize)

replace raumbedarf = round(raumbedarf) //auf ganze Räume aufrunden


// Wohnsituation
gen     wohnsit = 1 if q26flatsize <  raumbedarf & raumbedarf < . & q26flatsize <= 10
replace wohnsit = 2 if q26flatsize == raumbedarf & q26flatsize <= 10
replace wohnsit = 3 if q26flatsize >  raumbedarf & q26flatsize <= 10
recode  wohnsit (. = .c)


// Haushaltseinkommen
recode q34hhinc (4 = 3), gen(hhinc)


drop startdate datestamp submitdate

*** Variablen Reihenfolge
order id wave version ///
	surveyday interviewtime lastgroup ///
	link* /// FG2
	q01 female q02 agegr q03 q04* status /// FG3
	q05* permempl selfempl q06 q07 q08 sysjob q09 q10 q11* q12* homeoffice* ///
	q13support /// FG4
	q14 q15achildren fam q15bchildren nrchildren q16* youngest* ///
	childcare q17* q18* q19* /// FG5
	q20* q21* /// FG 6
	q23 q24 q25 q26 raumbedarf wohnsit q27* edu tertiary q28 /// FG7
	q29 q30 q31 p_sysjob q32* q33* p_edu /// FG8
	q34 hhinc /// FG9
	q35* /// FG10
	outro2 // FG11

exit
